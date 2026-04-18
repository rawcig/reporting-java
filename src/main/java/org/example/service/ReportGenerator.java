package org.example.service;

import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import org.example.model.ReportType;
import org.example.ui.ReportPreviewFrame;
import org.example.util.DBConnection;

import javax.swing.*;
import java.awt.*;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ReportGenerator {

    /**
     * Generates a report and returns JasperPrint.
     * Throws on any failure — caller handles UI.
     * @param reportType the report type to generate
     * @param parameters filter parameters (may be empty)
     */
    public static JasperPrint generate(ReportType reportType, Map<String, Object> parameters) throws Exception {
        System.out.println("=== Starting: " + reportType.getDisplayName() + " ===");
        System.out.flush();

        // Step 1: Load JRXML
        System.out.println("  [1/4] Loading JRXML template...");
        System.out.flush();
        String jrxmlPath = reportType.getJrxmlPath();
        InputStream jrxmlStream = ReportGenerator.class.getClassLoader().getResourceAsStream(jrxmlPath);
        if (jrxmlStream == null) {
            throw new RuntimeException("Report template not found: " + jrxmlPath);
        }
        System.out.println("  [1/4] OK: " + jrxmlPath);
        System.out.flush();

        // Step 2: Compile
        System.out.println("  [2/4] Compiling JRXML...");
        System.out.flush();
        JasperDesign jasperDesign = JRXmlLoader.load(jrxmlStream);
        JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
        System.out.println("  [2/4] Compiled successfully");
        System.out.flush();

        // Step 3: Connect and fill
        System.out.println("  [3/4] Connecting to database...");
        System.out.flush();

        JasperPrint jasperPrint;
        long elapsed;
        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("  [3/4] Connected");
            System.out.flush();

            System.out.println("  [4/4] Executing query and filling report...");
            System.out.flush();
            long start = System.currentTimeMillis();

            // Use provided parameters (or empty map)
            Map<String, Object> params = parameters != null ? new HashMap<>(parameters) : new HashMap<>();
            // Add report metadata as parameters
            params.put("REPORT_TITLE", reportType.getDisplayName());
            params.put("GENERATED_BY", "Training Management System");

            // Build SQL with filter conditions
            String sql = buildFilteredSql(reportType, parameters);

            try (var stmt = conn.createStatement()) {
                stmt.setQueryTimeout(60);
                try (var rs = stmt.executeQuery(sql)) {
                    JRResultSetDataSource dataSource = new JRResultSetDataSource(rs);
                    jasperPrint = JasperFillManager.fillReport(jasperReport, params, dataSource);
                }
            }
            elapsed = System.currentTimeMillis() - start;
        }

        System.out.println("  [4/4] Filled in " + elapsed + "ms, pages: " + jasperPrint.getPages().size());
        System.out.flush();

        return jasperPrint;
    }

    /**
     * Builds SQL with dynamic WHERE clauses based on filter parameters.
     * Only applies filters that are relevant to the report type.
     */
    private static String buildFilteredSql(ReportType reportType, Map<String, Object> filters) {
        String sql = reportType.getSqlQuery().trim();
        if (filters == null || filters.isEmpty()) {
            return sql;
        }

        List<String> conditions = new ArrayList<>();

        // Determine which filters apply based on report type
        Set<String> allowedFilters = getFilterKeysForReport(reportType);

        // Institute filter
        if (allowedFilters.contains("institute")) {
            String inst = (String) filters.get("institute_name");
            if (inst != null) {
                conditions.add("rc.regcom_name = '" + sanitize(inst) + "'");
            }
        }

        // Course filter
        if (allowedFilters.contains("course")) {
            String course = (String) filters.get("course_filter");
            if (course != null) {
                conditions.add("(c.course_code || ' - ' || c.course_name) = '" + sanitize(course) + "'");
            }
        }

        // Student search
        if (allowedFilters.contains("student")) {
            String student = (String) filters.get("student_filter");
            if (student != null) {
                conditions.add("(LOWER(s.first_name || ' ' || s.last_name) LIKE '%" + sanitize(student.toLowerCase()) + "%' "
                        + "OR LOWER(s.student_code) LIKE '%" + sanitize(student.toLowerCase()) + "%')");
            }
        }

        // Date range
        if (allowedFilters.contains("date")) {
            java.sql.Date fromDate = (java.sql.Date) filters.get("from_date");
            java.sql.Date toDate = (java.sql.Date) filters.get("to_date");
            if (fromDate != null) {
                conditions.add("e.enrollment_date >= '" + fromDate + "'");
            }
            if (toDate != null) {
                conditions.add("e.enrollment_date <= '" + toDate + "'");
            }
        }

        // Payment status
        if (allowedFilters.contains("payment")) {
            String payment = (String) filters.get("payment_filter");
            if (payment != null) {
                conditions.add("e.payment_status = '" + sanitize(payment) + "'");
            }
        }

        // Gender
        if (allowedFilters.contains("gender")) {
            String gender = (String) filters.get("gender_filter");
            if (gender != null) {
                conditions.add("s.gender = '" + sanitize(gender) + "'");
            }
        }

        // Skill level
        if (allowedFilters.contains("skill")) {
            String skill = (String) filters.get("skill_filter");
            if (skill != null) {
                conditions.add("c.skill_level = '" + sanitize(skill) + "'");
            }
        }

        // Completion status
        if (allowedFilters.contains("completion")) {
            String completion = (String) filters.get("completion_filter");
            if (completion != null) {
                conditions.add("e.completion_status = '" + sanitize(completion) + "'");
            }
        }

        if (conditions.isEmpty()) {
            return sql;
        }

        String whereClause = " WHERE " + String.join(" AND ", conditions);
        String upperSql = sql.toUpperCase();
        String andClause = " AND " + String.join(" AND ", conditions);

        // For UNION queries, wrap in subquery with WHERE (use column names, not table aliases)
        if (upperSql.contains("UNION")) {
            String unionWhere = String.join(" AND ", conditions)
                    .replace("s.gender", "gender")
                    .replace("c.course_code || ' - ' || c.course_name", "course_code || ' - ' || course_name");
            sql = "SELECT * FROM (" + sql + ") AS filtered WHERE " + unionWhere + " ORDER BY 1";
        } else if (containsWhereClause(upperSql)) {
            // Query already has WHERE — append AND before next clause
            int whereStart = upperSql.indexOf("WHERE");
            int endIdx = sql.length();

            // Find where the WHERE clause ends (before next SQL clause)
            String[] nextClauses = {"GROUP BY", "ORDER BY", "HAVING", "LIMIT"};
            for (String clause : nextClauses) {
                int idx = upperSql.indexOf(clause, whereStart + 5);
                if (idx > 0 && idx < endIdx) {
                    endIdx = idx;
                }
            }

            sql = sql.substring(0, endIdx) + andClause + sql.substring(endIdx);
        } else if (upperSql.contains("GROUP BY")) {
            // WHERE must come BEFORE GROUP BY
            int groupByIdx = upperSql.indexOf("GROUP BY");
            sql = sql.substring(0, groupByIdx) + whereClause + "\n    " + sql.substring(groupByIdx);
        } else if (upperSql.contains("ORDER BY")) {
            // No GROUP BY — WHERE before ORDER BY
            int orderByIdx = upperSql.lastIndexOf("ORDER BY");
            sql = sql.substring(0, orderByIdx) + whereClause + "\n    " + sql.substring(orderByIdx);
        } else {
            // Simple query — append WHERE at end
            sql += whereClause;
        }

        System.out.println("  [SQL Filter] Applied " + conditions.size() + " condition(s) for " + reportType.name());
        return sql;
    }

    /**
     * Checks if the SQL already has a WHERE clause (not inside a string literal).
     * Simple approach: look for WHERE keyword with word boundaries.
     */
    private static boolean containsWhereClause(String upperSql) {
        // Remove string literals (text between single quotes) to avoid false matches
        String sqlNoStrings = upperSql.replaceAll("'[^']*'", "''");
        // Check for WHERE as a whole word
        return sqlNoStrings.matches("(?s).*\\bWHERE\\b.*");
    }

    /**
     * Returns the set of filter keys applicable to a given report type.
     */
    private static Set<String> getFilterKeysForReport(ReportType reportType) {
        Set<String> keys = new HashSet<>();
        switch (reportType) {
            case STUDENT_ENROLLMENT:
                keys.addAll(Arrays.asList("institute", "course", "student", "date", "payment", "gender", "completion"));
                break;
            case COURSE_PERFORMANCE:
                keys.addAll(Arrays.asList("institute", "course", "skill"));
                break;
            case STUDENT_DETAIL:
                keys.addAll(Arrays.asList("institute", "course", "student", "gender"));
                break;
            case ATTENDANCE_CROSSTAB:
                keys.addAll(Arrays.asList("institute", "course"));
                break;
            case STUDENT_ATTENDANCE:
                keys.addAll(Arrays.asList("institute", "course", "student", "gender"));
                break;
            case EXAM_ASSIGNMENT_REPORT:
                keys.addAll(Arrays.asList("course", "student", "gender"));
                break;
        }
        return keys;
    }

    /**
     * Basic SQL injection prevention — escape single quotes.
     */
    private static String sanitize(String input) {
        return input.replace("'", "''");
    }

    /**
     * Legacy method: generates and previews a report with full UI handling.
     * Kept for backward compatibility — delegates to generate().
     */
    public static void generateAndPreview(ReportType reportType, JFrame parent) {
        generateAndPreview(reportType, parent, new HashMap<>());
    }

    /**
     * Generates and previews a report with filter parameters.
     */
    public static void generateAndPreview(ReportType reportType, JFrame parent, Map<String, Object> parameters) {
        try {
            JasperPrint jasperPrint = generate(reportType, parameters);

            if (jasperPrint.getPages().isEmpty()) {
                SwingUtilities.invokeLater(() ->
                    JOptionPane.showMessageDialog(parent,
                        "Report generated but contains no data.",
                        "No Data",
                        JOptionPane.INFORMATION_MESSAGE)
                );
                return;
            }

            final String title = reportType.getDisplayName() + " - Report Preview";
            SwingUtilities.invokeLater(() -> {
                try {
                    ReportPreviewFrame preview = new ReportPreviewFrame(parent, jasperPrint, title);
                    preview.showOnTop();
                    System.out.println("  Preview displayed");
                    System.out.flush();
                } catch (Exception e) {
                    System.err.println("  Preview ERROR: " + e.getMessage());
                    e.printStackTrace();
                    JOptionPane.showMessageDialog(parent,
                            "Failed to open preview: " + e.getMessage(),
                            "Preview Error", JOptionPane.ERROR_MESSAGE);
                }
            });

        } catch (SQLException e) {
            System.err.println("  DATABASE ERROR: " + e.getClass().getName() + ": " + e.getMessage());
            e.printStackTrace(System.err);
            final String userMessage = buildDatabaseErrorMessage(e);
            SwingUtilities.invokeLater(() -> showDatabaseErrorDialog(parent, userMessage));

        } catch (Exception e) {
            System.err.println("  ERROR: " + e.getClass().getName() + ": " + e.getMessage());
            e.printStackTrace(System.err);
            final String msg = e.getClass().getSimpleName() + ": " + e.getMessage();
            SwingUtilities.invokeLater(() -> {
                JTextArea area = new JTextArea(msg);
                area.setEditable(false);
                area.setFont(new Font("Consolas", Font.PLAIN, 11));
                area.setRows(8);
                area.setColumns(60);
                area.setLineWrap(true);
                area.setWrapStyleWord(true);
                JScrollPane sp = new JScrollPane(area);
                sp.setPreferredSize(new Dimension(650, 250));
                JOptionPane.showMessageDialog(parent, sp,
                    "Report Generation Error", JOptionPane.ERROR_MESSAGE);
            });
        }
    }

    /**
     * Builds a user-friendly error message for database failures.
     */
    private static String buildDatabaseErrorMessage(SQLException e) {
        String state = e.getSQLState();
        String message = e.getMessage();

        // Connection lost / refused
        if (state != null && (state.equals("08001") || state.equals("08006") || state.equals("08003"))) {
            return "Lost connection to the database while generating the report.\n\n"
                    + "Please check:\n"
                    + "  • PostgreSQL service is still running\n"
                    + "  • Network connection is stable\n"
                    + "  • Database server is not overloaded\n\n"
                    + "Details: " + message;
        }

        // Query timeout
        if (state != null && state.equals("57014")) {
            return "The database query took too long and was cancelled.\n\n"
                    + "Possible causes:\n"
                    + "  • The report covers too much data\n"
                    + "  • Database server is under heavy load\n\n"
                    + "Try narrowing your report criteria and try again.";
        }

        // Generic SQL error
        return "A database error occurred while generating the report.\n\n"
                + "SQL State: " + (state != null ? state : "Unknown") + "\n"
                + "Details: " + message + "\n\n"
                + "Please try again or contact your system administrator.";
    }

    /**
     * Shows a detailed database error dialog.
     */
    private static void showDatabaseErrorDialog(JFrame parent, String message) {
        JPanel panel = new JPanel(new BorderLayout(10, 10));
        panel.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));

        JPanel headerPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 0));
        JLabel iconLabel = new JLabel(UIManager.getIcon("OptionPane.errorIcon"));
        JLabel headerLabel = new JLabel("<html><b style='font-size:13px;'>Report Generation Failed</b><br>"
                + "<span style='font-size:11px;'>A database error occurred.</span></html>");
        headerPanel.add(iconLabel);
        headerPanel.add(headerLabel);
        panel.add(headerPanel, BorderLayout.NORTH);

        JTextArea detailsArea = new JTextArea(message);
        detailsArea.setEditable(false);
        detailsArea.setFont(new Font("Segoe UI", Font.PLAIN, 11));
        detailsArea.setLineWrap(true);
        detailsArea.setWrapStyleWord(true);
        detailsArea.setBackground(new Color(255, 245, 245));
        detailsArea.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));

        JScrollPane scrollPane = new JScrollPane(detailsArea);
        scrollPane.setPreferredSize(new Dimension(500, 180));
        panel.add(scrollPane, BorderLayout.CENTER);

        JOptionPane.showMessageDialog(parent,
                panel,
                "Database Error",
                JOptionPane.ERROR_MESSAGE);
    }
}
