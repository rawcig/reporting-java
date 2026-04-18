package org.example.ui;

import org.example.model.ReportType;
import org.example.util.DBConnection;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.border.TitledBorder;
import java.awt.*;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

/**
 * Context-aware filter dialog.
 * Only shows filters relevant to the selected report type.
 */
public class FilterDialog extends JDialog {

    private final ReportType reportType;

    // All possible filter controls
    private JComboBox<String> instituteCombo;
    private JLabel instituteLabel;
    private JComboBox<String> courseCombo;
    private JLabel courseLabel;
    private JTextField studentSearchField;
    private JLabel studentLabel;
    private JSpinner dateFromSpinner;
    private JSpinner dateToSpinner;
    private JLabel dateLabel;
    private JComboBox<String> paymentCombo;
    private JLabel paymentLabel;
    private JComboBox<String> genderCombo;
    private JLabel genderLabel;
    private JComboBox<String> skillLevelCombo;
    private JLabel skillLabel;
    private JComboBox<String> completionCombo;
    private JLabel completionLabel;

    // Result
    private Map<String, Object> parameters;
    private boolean confirmed;

    // Dropdown defaults
    private static final String ALL = "-- All --";

    public FilterDialog(Frame owner, ReportType reportType) {
        super(owner, "Filters: " + reportType.getDisplayName(), true);
        this.reportType = reportType;
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setSize(420, 320); // Compact default
        setLocationRelativeTo(owner);
        setResizable(false);
        initControls();
        configureForReport();
        loadDropdowns();
    }

    private void initControls() {
        JPanel main = new JPanel(new BorderLayout(8, 8));
        main.setBorder(new EmptyBorder(12, 12, 12, 12));

        JPanel formPanel = new JPanel(new GridLayout(0, 1, 6, 6));

        // Institute
        instituteLabel = new JLabel("Institute:");
        instituteCombo = new JComboBox<>();
        instituteCombo.addItem(ALL);
        formPanel.add(makeRow(instituteLabel, instituteCombo));

        // Course
        courseLabel = new JLabel("Course:");
        courseCombo = new JComboBox<>();
        courseCombo.addItem(ALL);
        formPanel.add(makeRow(courseLabel, courseCombo));

        // Student search
        studentLabel = new JLabel("Student (name/code):");
        studentSearchField = new JTextField(20);
        formPanel.add(makeRow(studentLabel, studentSearchField));

        // Date range
        dateLabel = new JLabel("Date range:");
        JPanel dateRow = new JPanel(new FlowLayout(FlowLayout.LEFT, 4, 0));
        dateRow.add(new JLabel("From:"));
        dateFromSpinner = new JSpinner(new SpinnerDateModel());
        dateFromSpinner.setEditor(new JSpinner.DateEditor(dateFromSpinner, "dd/MM/yyyy"));
        dateRow.add(dateFromSpinner);
        dateRow.add(new JLabel("  To:"));
        dateToSpinner = new JSpinner(new SpinnerDateModel());
        dateToSpinner.setEditor(new JSpinner.DateEditor(dateToSpinner, "dd/MM/yyyy"));
        dateRow.add(dateToSpinner);
        formPanel.add(makeRow(dateLabel, dateRow));

        // Payment status
        paymentLabel = new JLabel("Payment:");
        paymentCombo = new JComboBox<>();
        paymentCombo.addItem(ALL);
        paymentCombo.addItem("Paid");
        paymentCombo.addItem("Pending");
        formPanel.add(makeRow(paymentLabel, paymentCombo));

        // Gender
        genderLabel = new JLabel("Gender:");
        genderCombo = new JComboBox<>();
        genderCombo.addItem(ALL);
        genderCombo.addItem("M");
        genderCombo.addItem("F");
        formPanel.add(makeRow(genderLabel, genderCombo));

        // Skill level
        skillLabel = new JLabel("Skill Level:");
        skillLevelCombo = new JComboBox<>();
        skillLevelCombo.addItem(ALL);
        skillLevelCombo.addItem("Beginner");
        skillLevelCombo.addItem("Intermediate");
        skillLevelCombo.addItem("Advanced");
        formPanel.add(makeRow(skillLabel, skillLevelCombo));

        // Completion status
        completionLabel = new JLabel("Completion:");
        completionCombo = new JComboBox<>();
        completionCombo.addItem(ALL);
        completionCombo.addItem("Completed");
        completionCombo.addItem("Ongoing");
        completionCombo.addItem("Not Started");
        formPanel.add(makeRow(completionLabel, completionCombo));

        JScrollPane scroll = new JScrollPane(formPanel);
        scroll.setBorder(new TitledBorder("Filter Criteria"));
        main.add(scroll, BorderLayout.CENTER);

        // Buttons
        JPanel btnPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 4));
        JButton clearBtn = new JButton("Clear");
        JButton cancelBtn = new JButton("Cancel");
        JButton applyBtn = new JButton("Apply");
        applyBtn.setFont(applyBtn.getFont().deriveFont(Font.BOLD));
        btnPanel.add(clearBtn);
        btnPanel.add(cancelBtn);
        btnPanel.add(applyBtn);
        main.add(btnPanel, BorderLayout.SOUTH);

        clearBtn.addActionListener(e -> clearFilters());
        cancelBtn.addActionListener(e -> { confirmed = false; dispose(); });
        applyBtn.addActionListener(e -> applyAndClose());

        add(main);
    }

    /** Show/hide filter controls based on report type */
    private void configureForReport() {
        FilterProfile fp = FilterProfile.forReport(reportType);

        instituteCombo.setVisible(fp.institute);
        instituteLabel.setVisible(fp.institute);
        courseCombo.setVisible(fp.course);
        courseLabel.setVisible(fp.course);
        studentSearchField.setVisible(fp.student);
        studentLabel.setVisible(fp.student);
        dateFromSpinner.setVisible(fp.dateRange);
        dateToSpinner.setVisible(fp.dateRange);
        dateLabel.setVisible(fp.dateRange);
        paymentCombo.setVisible(fp.payment);
        paymentLabel.setVisible(fp.payment);
        genderCombo.setVisible(fp.gender);
        genderLabel.setVisible(fp.gender);
        skillLevelCombo.setVisible(fp.skillLevel);
        skillLabel.setVisible(fp.skillLevel);
        completionCombo.setVisible(fp.completion);
        completionLabel.setVisible(fp.completion);

        // Resize dialog to fit only visible controls
        int visibleCount = 0;
        if (fp.institute) visibleCount++;
        if (fp.course) visibleCount++;
        if (fp.student) visibleCount++;
        if (fp.dateRange) visibleCount++;
        if (fp.payment) visibleCount++;
        if (fp.gender) visibleCount++;
        if (fp.skillLevel) visibleCount++;
        if (fp.completion) visibleCount++;

        // Base height: title(30) + form padding(30) + buttons(50) + scroll padding(20)
        // Each row: ~35px
        int formHeight = Math.max(120, 30 + visibleCount * 38 + 80);
        setSize(420, formHeight);
        setLocationRelativeTo(getOwner());
    }

    private JPanel makeRow(JLabel label, JComponent field) {
        JPanel row = new JPanel(new BorderLayout(6, 0));
        label.setPreferredSize(new Dimension(100, 22));
        row.add(label, BorderLayout.WEST);
        row.add(field, BorderLayout.CENTER);
        return row;
    }

    /** Load dropdown options from database */
    private void loadDropdowns() {
        try (Connection conn = DBConnection.getConnection()) {
            // Institutes
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT regcom_name FROM register_company ORDER BY regcom_name")) {
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) instituteCombo.addItem(rs.getString(1));
                }
            }
            // Courses
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT course_code || ' - ' || course_name FROM courses ORDER BY course_code")) {
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) courseCombo.addItem(rs.getString(1));
                }
            }
        } catch (SQLException e) {
            System.err.println("Warning: Could not load filter dropdowns: " + e.getMessage());
        }
    }

    private void clearFilters() {
        instituteCombo.setSelectedItem(ALL);
        courseCombo.setSelectedItem(ALL);
        studentSearchField.setText("");
        paymentCombo.setSelectedItem(ALL);
        genderCombo.setSelectedItem(ALL);
        skillLevelCombo.setSelectedItem(ALL);
        completionCombo.setSelectedItem(ALL);
        dateFromSpinner.setValue(new java.util.Date());
        dateToSpinner.setValue(new java.util.Date());
    }

    private void applyAndClose() {
        parameters = buildParameters();
        confirmed = true;
        dispose();
    }

    private Map<String, Object> buildParameters() {
        Map<String, Object> params = new HashMap<>();

        if (instituteCombo.isVisible() && !ALL.equals(instituteCombo.getSelectedItem())) {
            params.put("institute_name", instituteCombo.getSelectedItem());
        }
        if (courseCombo.isVisible() && !ALL.equals(courseCombo.getSelectedItem())) {
            params.put("course_filter", courseCombo.getSelectedItem());
        }
        if (studentSearchField.isVisible() && !studentSearchField.getText().trim().isEmpty()) {
            params.put("student_filter", studentSearchField.getText().trim());
        }
        if (paymentCombo.isVisible() && !ALL.equals(paymentCombo.getSelectedItem())) {
            params.put("payment_filter", paymentCombo.getSelectedItem());
        }
        if (genderCombo.isVisible() && !ALL.equals(genderCombo.getSelectedItem())) {
            params.put("gender_filter", genderCombo.getSelectedItem());
        }
        if (skillLevelCombo.isVisible() && !ALL.equals(skillLevelCombo.getSelectedItem())) {
            params.put("skill_filter", skillLevelCombo.getSelectedItem());
        }
        if (completionCombo.isVisible() && !ALL.equals(completionCombo.getSelectedItem())) {
            params.put("completion_filter", completionCombo.getSelectedItem());
        }
        // Dates: always set if visible
        if (dateFromSpinner.isVisible()) {
            params.put("from_date", new java.sql.Date(((java.util.Date) dateFromSpinner.getValue()).getTime()));
            params.put("to_date", new java.sql.Date(((java.util.Date) dateToSpinner.getValue()).getTime()));
        }

        return params;
    }

    public Map<String, Object> showAndGetParameters() {
        setVisible(true);
        return confirmed ? parameters : null;
    }

    /**
     * Defines which filters apply to each report type.
     */
    private static class FilterProfile {
        final boolean institute, course, student, dateRange, payment, gender, skillLevel, completion;

        FilterProfile(boolean institute, boolean course, boolean student, boolean dateRange,
                     boolean payment, boolean gender, boolean skillLevel, boolean completion) {
            this.institute = institute;
            this.course = course;
            this.student = student;
            this.dateRange = dateRange;
            this.payment = payment;
            this.gender = gender;
            this.skillLevel = skillLevel;
            this.completion = completion;
        }

        static FilterProfile forReport(ReportType rt) {
            switch (rt) {
                case STUDENT_ENROLLMENT:
                    // Full enrollment report: all filters except skill level
                    return new FilterProfile(true, true, true, true, true, true, false, true);

                case COURSE_PERFORMANCE:
                    // Grouped by institute: institute, course, skill level only
                    return new FilterProfile(true, true, false, false, false, false, true, false);

                case STUDENT_DETAIL:
                    // Per-student view: institute, course, student search, gender
                    return new FilterProfile(true, true, true, false, false, true, false, false);

                case ATTENDANCE_CROSSTAB:
                    // Matrix: institute and course only
                    return new FilterProfile(true, true, false, false, false, false, false, false);

                case STUDENT_ATTENDANCE:
                    // Attendance: institute, course, student, gender
                    return new FilterProfile(true, true, true, false, false, true, false, false);

                case EXAM_ASSIGNMENT_REPORT:
                    // Exam/Assignment: course, student, gender
                    return new FilterProfile(false, true, true, false, false, true, false, false);

                default:
                    // Fallback: show all
                    return new FilterProfile(true, true, true, true, true, true, true, true);
            }
        }
    }
}
