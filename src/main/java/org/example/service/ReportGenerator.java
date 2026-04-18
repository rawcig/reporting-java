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
import java.sql.*;
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
     */
    public static JasperPrint generate(ReportType reportType, Map<String, Object> parameters) throws Exception {
        System.out.println("=== Starting: " + reportType.getDisplayName() + " ===");
        System.out.flush();

        // Step 1: Load JRXML
        System.out.println("  [1/4] Loading JRXML template...");
        String jrxmlPath = reportType.getJrxmlPath();
        InputStream jrxmlStream = ReportGenerator.class.getClassLoader().getResourceAsStream(jrxmlPath);
        if (jrxmlStream == null) {
            throw new RuntimeException("Report template not found: " + jrxmlPath);
        }
        System.out.println("  [1/4] OK: " + jrxmlPath);

        // Step 2: Compile
        System.out.println("  [2/4] Compiling JRXML...");
        JasperDesign jasperDesign = JRXmlLoader.load(jrxmlStream);
        JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
        System.out.println("  [2/4] Compiled successfully");

        // Step 3: Connect and fill
        System.out.println("  [3/4] Connecting to database...");

        JasperPrint jasperPrint;
        long elapsed;
        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("  [3/4] Connected");
            System.out.println("  [4/4] Executing query and filling report...");

            Map<String, Object> params = parameters != null ? new HashMap<>(parameters) : new HashMap<>();
            params.put("REPORT_TITLE", reportType.getDisplayName());
            params.put("GENERATED_BY", "Training Management System");

            // Build SQL with filter conditions using prepared statements
            FilteredSql filteredSql = buildFilteredSqlWithParams(reportType, parameters);

            try (PreparedStatement pstmt = conn.prepareStatement(filteredSql.sql)) {
                // Set parameters
                int paramIndex = 1;
                for (Object value : filteredSql.parameters) {
                    pstmt.setObject(paramIndex++, value);
                }
                pstmt.setQueryTimeout(60);
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    JRResultSetDataSource dataSource = new JRResultSetDataSource(rs);
                    jasperPrint = JasperFillManager.fillReport(jasperReport, params, dataSource);
                }
            }
            elapsed = System.currentTimeMillis() - System.currentTimeMillis();
        }

        System.out.println("  [4/4] Filled in " + elapsed + "ms, pages: " + jasperPrint.getPages().size());
        System.out.flush();

        return jasperPrint;
    }

    /**
     * Builds SQL with dynamic WHERE clauses using prepared statement parameters.
     */
    private static FilteredSql buildFilteredSqlWithParams(ReportType reportType, Map<String, Object> filters) {
        String sql = reportType.getSqlQuery().trim();
        if (filters == null || filters.isEmpty()) {
            return new FilteredSql(sql, new ArrayList<>());
        }

        List<String> conditions = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        Set<String> allowedFilters = getFilterKeysForReport(reportType);

        // Institute filter
        if (allowedFilters.contains("institute")) {
            String inst = (String) filters.get("institute_name");
            if (inst != null && !inst.trim().isEmpty()) {
                conditions.add("rc.regcom_name = ?");
                params.add(inst);
            }
        }

        // Course filter
        if (allowedFilters.contains("course")) {
            String course = (String) filters.get("course_filter");
            if (course != null && !course.trim().isEmpty()) {
                conditions.add("(c.course_code || ' - ' || c.course_name) = ?");
                params.add(course);
            }
        }

        // Student search
        if (allowedFilters.contains("student")) {
            String student = (String) filters.get("student_filter");
            if (student != null && !student.trim().isEmpty()) {
                conditions.add("(LOWER(s.first_name || ' ' || s.last_name) LIKE ? "
                        + "OR LOWER(s.student_code) LIKE ?)");
                String searchPattern = "%" + student.toLowerCase() + "%";
                params.add(searchPattern);
                params.add(searchPattern);
            }
        }

        // Date range
        if (allowedFilters.contains("date")) {
            java.sql.Date fromDate = (java.sql.Date) filters.get("from_date");
            java.sql.Date toDate = (java.sql.Date) filters.get("to_date");
            if (fromDate != null) {
                conditions.add("e.enrollment_date >= ?");
                params.add(fromDate);
            }
            if (toDate != null) {
                conditions.add("e.enrollment_date <= ?");
                params.add(toDate);
            }
        }

        // Payment status
        if (allowedFilters.contains("payment")) {
            String payment = (String) filters.get("payment_filter");
            if (payment != null && !ALL.equals(payment)) {
                conditions.add("e.payment_status = ?");
                params.add(payment);
            }
        }

        // Gender
        if (allowedFilters.contains("gender")) {
            String gender = (String) filters.get("gender_filter");
            if (gender != null && !ALL.equals(gender)) {
                // Map display values to DB values
                String dbGender = gender.equals("Male") ? "M" : gender.equals("Female") ? "F" : gender;
                conditions.add("s.gender = ?");
                params.add(dbGender);
            }
        }

        // Skill level
        if (allowedFilters.contains("skill")) {
            String skill = (String) filters.get("skill_filter");
            if (skill != null && !ALL.equals(skill)) {
                conditions.add("c.skill_level = ?");
                params.add(skill);
            }
        }

        // Completion status
        if (allowedFilters.contains("completion")) {
            String completion = (String) filters.get("completion_filter");
            if (completion != null && !ALL.equals(completion)) {
                conditions.add("e.completion_status = ?");
                params.add(completion);
            }
        }

        if (conditions.isEmpty()) {
            return new FilteredSql(sql, new ArrayList<>());
        }

        // Build WHERE clause
        String whereClause = " WHERE " + String.join(" AND ", conditions);
        String upperSql = sql.toUpperCase();

        // Handle UNION queries
        if (upperSql.contains("UNION")) {
            String unionWhere = String.join(" AND ", conditions)
                    .replace("rc.regcom_name = ?", "regcom_name = ?")
                    .replace("c.course_code || ' - ' || c.course_name = ?", "course_code || ' - ' || course_name = ?")
                    .replace("s.gender = ?", "gender = ?");
            sql = "SELECT * FROM (" + sql + ") AS filtered WHERE " + unionWhere + " ORDER BY 1";
        } else if (containsWhereClause(upperSql)) {
            int whereStart = upperSql.indexOf("WHERE");
            int endIdx = sql.length();
            String[] nextClauses = {"GROUP BY", "ORDER BY", "HAVING", "LIMIT"};
            for (String clause : nextClauses) {
                int idx = upperSql.indexOf(clause, whereStart + 5);
                if (idx > 0 && idx < endIdx) {
                    endIdx = idx;
                }
            }
            sql = sql.substring(0, endIdx) + " AND " + String.join(" AND ", conditions) + sql.substring(endIdx);
        } else if (upperSql.contains("GROUP BY")) {
            int groupByIdx = upperSql.indexOf("GROUP BY");
            sql = sql.substring(0, groupByIdx) + whereClause + "\n    " + sql.substring(groupByIdx);
        } else if (upperSql.contains("ORDER BY")) {
            int orderByIdx = upperSql.lastIndexOf("ORDER BY");
            sql = sql.substring(0, orderByIdx) + whereClause + "\n    " + sql.substring(orderByIdx);
        } else {
            sql += whereClause;
        }

        System.out.println("  [SQL Filter] Applied " + conditions.size() + " condition(s) for " + reportType.name());
        return new FilteredSql(sql, params);
    }

    private static final String ALL = "-- All --";

    private static boolean containsWhereClause(String upperSql) {
        String sqlNoStrings = upperSql.replaceAll("'[^']*'", "''");
        return sqlNoStrings.matches("(?s).*\\bWHERE\\b.*");
    }

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
     * Helper class to hold SQL and parameters.
     */
    private static class FilteredSql {
        final String sql;
        final List<Object> parameters;

        FilteredSql(String sql, List<Object> parameters) {
            this.sql = sql;
            this.parameters = parameters;
        }
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
                    // Disable parent dashboard
                    if (parent != null) {
                        parent.setEnabled(false);
                    }
                    
                    ReportPreviewFrame preview = new ReportPreviewFrame(parent, jasperPrint, title);
                    preview.showOnTop();
                } catch (Exception e) {
                    JOptionPane.showMessageDialog(parent,
                            "Failed to open preview: " + e.getMessage(),
                            "Preview Error", JOptionPane.ERROR_MESSAGE);
                }
            });

        } catch (SQLException e) {
            e.printStackTrace(System.err);
            final String userMessage = buildDatabaseErrorMessage(e);
            SwingUtilities.invokeLater(() -> showDatabaseErrorDialog(parent, userMessage));

        } catch (Exception e) {
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

    private static String buildDatabaseErrorMessage(SQLException e) {
        String state = e.getSQLState();
        String message = e.getMessage();

        if (state != null && (state.equals("08001") || state.equals("08006") || state.equals("08003"))) {
            return "Lost connection to the database while generating the report.\n\n"
                    + "Please check:\n"
                    + "  • PostgreSQL service is still running\n"
                    + "  • Network connection is stable\n\n"
                    + "Details: " + message;
        }

        if (state != null && state.equals("57014")) {
            return "The database query took too long and was cancelled.\n\n"
                    + "Try narrowing your report criteria and try again.";
        }

        return "A database error occurred while generating the report.\n\n"
                + "SQL State: " + (state != null ? state : "Unknown") + "\n"
                + "Details: " + message;
    }

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

        JScrollPane scrollPane = new JScrollPane(detailsArea);
        scrollPane.setPreferredSize(new Dimension(500, 180));
        panel.add(scrollPane, BorderLayout.CENTER);

        JOptionPane.showMessageDialog(parent, panel, "Database Error", JOptionPane.ERROR_MESSAGE);
    }

    // Legacy methods for backward compatibility
    public static void generateAndPreview(ReportType reportType, JFrame parent) {
        generateAndPreview(reportType, parent, new HashMap<>());
    }
}
