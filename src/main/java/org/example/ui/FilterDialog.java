package org.example.ui;

import com.formdev.flatlaf.FlatClientProperties;
import org.example.model.ReportType;
import org.example.util.DBConnection;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.border.TitledBorder;
import java.awt.*;
import java.sql.*;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

/**
 * Enhanced context-aware filter dialog with improved UX.
 */
public class FilterDialog extends JDialog {

    private final ReportType reportType;

    // Filter controls
    private JComboBox<String> instituteCombo;
    private JComboBox<String> courseCombo;
    private JTextField studentSearchField;
    private JSpinner dateFromSpinner;
    private JSpinner dateToSpinner;
    private JComboBox<String> datePresetCombo;
    private JComboBox<String> paymentCombo;
    private JComboBox<String> genderCombo;
    private JComboBox<String> skillLevelCombo;
    private JComboBox<String> completionCombo;

    // Result
    private Map<String, Object> parameters;
    private boolean confirmed;

    // Constants
    private static final String ALL = "-- All --";
    private static final String DATE_PRESET_ALL = "All Time";
    private static final String DATE_PRESET_TODAY = "Today";
    private static final String DATE_PRESET_WEEK = "This Week";
    private static final String DATE_PRESET_MONTH = "This Month";
    private static final String DATE_PRESET_YEAR = "This Year";
    private static final String DATE_PRESET_CUSTOM = "Custom Range";

    public FilterDialog(Frame owner, ReportType reportType) {
        super(owner, "Filter: " + reportType.getDisplayName(), true);
        this.reportType = reportType;
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        initControls();
        configureForReport();
        loadDropdowns();
        pack();
        setLocationRelativeTo(owner);
    }

    private void initControls() {
        JPanel main = new JPanel(new BorderLayout(10, 10));
        main.setBorder(new EmptyBorder(15, 15, 15, 15));

        // Header with info and date preset
        JPanel headerPanel = new JPanel(new BorderLayout(8, 0));
        headerPanel.setBorder(new EmptyBorder(0, 0, 10, 0));
        
        JLabel infoLabel = new JLabel("<html><b>Filter Options</b><br>Select criteria to narrow down your report results.</html>");
        infoLabel.setForeground(UIManager.getColor("Label.disabledForeground"));
        headerPanel.add(infoLabel, BorderLayout.CENTER);
        
        datePresetCombo = new JComboBox<>(new String[]{
            DATE_PRESET_ALL, DATE_PRESET_TODAY, DATE_PRESET_WEEK, 
            DATE_PRESET_MONTH, DATE_PRESET_YEAR, DATE_PRESET_CUSTOM
        });
        datePresetCombo.addActionListener(e -> applyDatePreset());
        datePresetCombo.setToolTipText("Quick date range selection");
        headerPanel.add(datePresetCombo, BorderLayout.EAST);
        
        main.add(headerPanel, BorderLayout.NORTH);

        // Form panel
        JPanel formPanel = new JPanel(new GridBagLayout());
        formPanel.setBorder(new TitledBorder(null, "Filter Criteria", 
            TitledBorder.LEFT, TitledBorder.TOP, null, 
            UIManager.getColor("Title.foreground")));
        
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.fill = GridBagConstraints.HORIZONTAL;
        gbc.insets = new Insets(4, 8, 4, 8);
        gbc.gridx = 0;
        gbc.gridy = 0;

        // Institute
        instituteCombo = createComboBox(ALL);
        instituteCombo.putClientProperty(FlatClientProperties.PLACEHOLDER_TEXT, "Select institute...");
        formPanel.add(createLabeledRow("Institute:", instituteCombo), gbc);
        gbc.gridy++;

        // Course
        courseCombo = createComboBox(ALL);
        courseCombo.putClientProperty(FlatClientProperties.PLACEHOLDER_TEXT, "Select course...");
        formPanel.add(createLabeledRow("Course:", courseCombo), gbc);
        gbc.gridy++;

        // Student search
        studentSearchField = new JTextField(25);
        studentSearchField.putClientProperty(FlatClientProperties.PLACEHOLDER_TEXT, "Search by name or code...");
        formPanel.add(createLabeledRow("Student:", studentSearchField), gbc);
        gbc.gridy++;

        // Date range
        JPanel datePanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 0));
        dateFromSpinner = createDateSpinner();
        dateToSpinner = createDateSpinner();
        
        datePanel.add(new JLabel("From:"));
        datePanel.add(dateFromSpinner);
        datePanel.add(Box.createHorizontalStrut(10));
        datePanel.add(new JLabel("To:"));
        datePanel.add(dateToSpinner);
        
        formPanel.add(createLabeledRow("Date Range:", datePanel), gbc);
        gbc.gridy++;

        // Payment status
        paymentCombo = new JComboBox<>(new String[]{ALL, "Paid", "Pending", "Overdue"});
        formPanel.add(createLabeledRow("Payment:", paymentCombo), gbc);
        gbc.gridy++;

        // Gender
        genderCombo = new JComboBox<>(new String[]{ALL, "Male", "Female"});
        formPanel.add(createLabeledRow("Gender:", genderCombo), gbc);
        gbc.gridy++;

        // Skill level
        skillLevelCombo = createComboBox(ALL, "Beginner", "Intermediate", "Advanced");
        formPanel.add(createLabeledRow("Skill Level:", skillLevelCombo), gbc);
        gbc.gridy++;

        // Completion status
        completionCombo = createComboBox(ALL, "Completed", "Ongoing", "Not Started", "Dropped Out");
        formPanel.add(createLabeledRow("Completion:", completionCombo), gbc);
        gbc.gridy++;

        JScrollPane scroll = new JScrollPane(formPanel);
        scroll.setBorder(null);
        scroll.getVerticalScrollBar().setUnitIncrement(16);
        main.add(scroll, BorderLayout.CENTER);

        // Active filters indicator
        JPanel filterStatusPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 4));
        JLabel statusLabel = new JLabel("<html><i>No active filters</i></html>");
        statusLabel.setName("filterStatusLabel");
        filterStatusPanel.add(statusLabel);
        main.add(filterStatusPanel, BorderLayout.SOUTH);

        // Buttons
        JPanel btnPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 8));
        btnPanel.setBorder(new EmptyBorder(8, 0, 0, 0));
        
        JButton clearBtn = new JButton("Reset");
        JButton cancelBtn = new JButton("Cancel");
        JButton previewBtn = new JButton("Preview");
        JButton applyBtn = new JButton("Apply Filters");
        applyBtn.setFont(applyBtn.getFont().deriveFont(Font.BOLD));
        applyBtn.putClientProperty(FlatClientProperties.BUTTON_TYPE, "primary");
        
        btnPanel.add(clearBtn);
        btnPanel.add(previewBtn);
        btnPanel.add(cancelBtn);
        btnPanel.add(applyBtn);
        main.add(btnPanel, BorderLayout.SOUTH);

        // Actions
        clearBtn.addActionListener(e -> { clearFilters(); updateFilterStatus(statusLabel); });
        cancelBtn.addActionListener(e -> { confirmed = false; dispose(); });
        previewBtn.addActionListener(e -> previewFilters(statusLabel));
        applyBtn.addActionListener(e -> { applyAndClose(); updateFilterStatus(statusLabel); });

        // Update status on changes
        addChangeListener(() -> updateFilterStatus(statusLabel), 
            instituteCombo, courseCombo, studentSearchField, 
            paymentCombo, genderCombo, skillLevelCombo, completionCombo);

        add(main);
    }

    private JComboBox<String> createComboBox(String... items) {
        JComboBox<String> combo = new JComboBox<>(items);
        combo.setMaximumRowCount(10);
        return combo;
    }

    private JSpinner createDateSpinner() {
        JSpinner spinner = new JSpinner(new SpinnerDateModel());
        spinner.setEditor(new JSpinner.DateEditor(spinner, "dd/MM/yyyy"));
        spinner.setValue(new java.util.Date());
        return spinner;
    }

    private JPanel createLabeledRow(String labelText, JComponent component) {
        JPanel row = new JPanel(new BorderLayout(10, 0));
        row.setOpaque(false);
        
        JLabel label = new JLabel(labelText);
        label.setPreferredSize(new Dimension(90, 28));
        label.setHorizontalAlignment(SwingConstants.RIGHT);
        
        row.add(label, BorderLayout.WEST);
        row.add(component, BorderLayout.CENTER);
        return row;
    }

    private void addChangeListener(Runnable callback, JComponent... components) {
        for (JComponent comp : components) {
            if (comp instanceof JComboBox) {
                ((JComboBox<?>) comp).addActionListener(e -> callback.run());
            } else if (comp instanceof JTextField) {
                ((JTextField) comp).getDocument().addDocumentListener(
                    new javax.swing.event.DocumentListener() {
                        public void insertUpdate(javax.swing.event.DocumentEvent e) { callback.run(); }
                        public void removeUpdate(javax.swing.event.DocumentEvent e) { callback.run(); }
                        public void changedUpdate(javax.swing.event.DocumentEvent e) { callback.run(); }
                    });
            }
        }
    }

    private void applyDatePreset() {
        String preset = (String) datePresetCombo.getSelectedItem();
        LocalDate today = LocalDate.now();
        LocalDate from, to;

        switch (preset) {
            case DATE_PRESET_TODAY:
                from = to = today;
                break;
            case DATE_PRESET_WEEK:
                from = today.with(java.time.DayOfWeek.MONDAY);
                to = today;
                break;
            case DATE_PRESET_MONTH:
                from = today.withDayOfMonth(1);
                to = today;
                break;
            case DATE_PRESET_YEAR:
                from = today.withDayOfYear(1);
                to = today;
                break;
            case DATE_PRESET_CUSTOM:
                return;
            default:
                from = LocalDate.of(2000, 1, 1);
                to = today;
                break;
        }

        dateFromSpinner.setValue(java.util.Date.from(from.atStartOfDay(ZoneId.systemDefault()).toInstant()));
        dateToSpinner.setValue(java.util.Date.from(to.atStartOfDay(ZoneId.systemDefault()).toInstant()));
    }

    private void configureForReport() {
        FilterProfile fp = FilterProfile.forReport(reportType);

        instituteCombo.setVisible(fp.institute);
        instituteCombo.getParent().setVisible(fp.institute);
        courseCombo.setVisible(fp.course);
        courseCombo.getParent().setVisible(fp.course);
        studentSearchField.setVisible(fp.student);
        studentSearchField.getParent().setVisible(fp.student);
        dateFromSpinner.setVisible(fp.dateRange);
        dateToSpinner.setVisible(fp.dateRange);
        dateFromSpinner.getParent().setVisible(fp.dateRange);
        datePresetCombo.setVisible(fp.dateRange);
        datePresetCombo.getParent().setVisible(fp.dateRange);
        paymentCombo.setVisible(fp.payment);
        paymentCombo.getParent().setVisible(fp.payment);
        genderCombo.setVisible(fp.gender);
        genderCombo.getParent().setVisible(fp.gender);
        skillLevelCombo.setVisible(fp.skillLevel);
        skillLevelCombo.getParent().setVisible(fp.skillLevel);
        completionCombo.setVisible(fp.completion);
        completionCombo.getParent().setVisible(fp.completion);

        if (fp.dateRange) {
            datePresetCombo.setSelectedItem(DATE_PRESET_MONTH);
            applyDatePreset();
        }
    }

    private void loadDropdowns() {
        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT regcom_name FROM register_company ORDER BY regcom_name")) {
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) instituteCombo.addItem(rs.getString(1));
                }
            }
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
        datePresetCombo.setSelectedItem(DATE_PRESET_ALL);
        applyDatePreset();
    }

    private void previewFilters(JLabel statusLabel) {
        String preview = buildFilterPreview();
        JOptionPane.showMessageDialog(this, preview, "Active Filters", JOptionPane.INFORMATION_MESSAGE);
    }

    private String buildFilterPreview() {
        StringBuilder sb = new StringBuilder("<html><b>Active Filters:</b><br>");
        boolean hasFilter = false;

        if (instituteCombo.isVisible() && !ALL.equals(instituteCombo.getSelectedItem())) {
            sb.append("• Institute: ").append(instituteCombo.getSelectedItem()).append("<br>");
            hasFilter = true;
        }
        if (courseCombo.isVisible() && !ALL.equals(courseCombo.getSelectedItem())) {
            sb.append("• Course: ").append(courseCombo.getSelectedItem()).append("<br>");
            hasFilter = true;
        }
        if (studentSearchField.isVisible() && !studentSearchField.getText().trim().isEmpty()) {
            sb.append("• Student: ").append(studentSearchField.getText()).append("<br>");
            hasFilter = true;
        }
        if (dateFromSpinner.isVisible()) {
            String from = ((java.util.Date) dateFromSpinner.getValue()).toString().substring(0, 10);
            String to = ((java.util.Date) dateToSpinner.getValue()).toString().substring(0, 10);
            sb.append("• Date: ").append(from).append(" to ").append(to).append("<br>");
            hasFilter = true;
        }
        if (paymentCombo.isVisible() && !ALL.equals(paymentCombo.getSelectedItem())) {
            sb.append("• Payment: ").append(paymentCombo.getSelectedItem()).append("<br>");
            hasFilter = true;
        }
        if (genderCombo.isVisible() && !ALL.equals(genderCombo.getSelectedItem())) {
            sb.append("• Gender: ").append(genderCombo.getSelectedItem()).append("<br>");
            hasFilter = true;
        }
        if (skillLevelCombo.isVisible() && !ALL.equals(skillLevelCombo.getSelectedItem())) {
            sb.append("• Skill: ").append(skillLevelCombo.getSelectedItem()).append("<br>");
            hasFilter = true;
        }
        if (completionCombo.isVisible() && !ALL.equals(completionCombo.getSelectedItem())) {
            sb.append("• Completion: ").append(completionCombo.getSelectedItem()).append("<br>");
            hasFilter = true;
        }

        if (!hasFilter) {
            sb.append("<i>No filters applied - showing all data</i>");
        }
        sb.append("</html>");
        return sb.toString();
    }

    private void updateFilterStatus(JLabel statusLabel) {
        int count = countActiveFilters();
        if (count == 0) {
            statusLabel.setText("<html><i>No active filters</i></html>");
        } else {
            statusLabel.setText("<html><b>" + count + "</b> active filter(s)</html>");
        }
    }

    private int countActiveFilters() {
        int count = 0;
        if (instituteCombo.isVisible() && !ALL.equals(instituteCombo.getSelectedItem())) count++;
        if (courseCombo.isVisible() && !ALL.equals(courseCombo.getSelectedItem())) count++;
        if (studentSearchField.isVisible() && !studentSearchField.getText().trim().isEmpty()) count++;
        if (paymentCombo.isVisible() && !ALL.equals(paymentCombo.getSelectedItem())) count++;
        if (genderCombo.isVisible() && !ALL.equals(genderCombo.getSelectedItem())) count++;
        if (skillLevelCombo.isVisible() && !ALL.equals(skillLevelCombo.getSelectedItem())) count++;
        if (completionCombo.isVisible() && !ALL.equals(completionCombo.getSelectedItem())) count++;
        return count;
    }

    private void applyAndClose() {
        parameters = buildParameters();
        confirmed = true;
        dispose();
    }

    private Map<String, Object> buildParameters() {
        Map<String, Object> params = new HashMap<>();

        if (instituteCombo.isVisible() && !ALL.equals(instituteCombo.getSelectedItem())) {
            params.put("institute_name", instituteCombo.getSelectedItem().toString());
        }
        if (courseCombo.isVisible() && !ALL.equals(courseCombo.getSelectedItem())) {
            params.put("course_filter", courseCombo.getSelectedItem().toString());
        }
        if (studentSearchField.isVisible() && !studentSearchField.getText().trim().isEmpty()) {
            params.put("student_filter", studentSearchField.getText().trim());
        }
        if (paymentCombo.isVisible() && !ALL.equals(paymentCombo.getSelectedItem())) {
            params.put("payment_filter", paymentCombo.getSelectedItem().toString());
        }
        if (genderCombo.isVisible() && !ALL.equals(genderCombo.getSelectedItem())) {
            params.put("gender_filter", genderCombo.getSelectedItem().toString());
        }
        if (skillLevelCombo.isVisible() && !ALL.equals(skillLevelCombo.getSelectedItem())) {
            params.put("skill_filter", skillLevelCombo.getSelectedItem().toString());
        }
        if (completionCombo.isVisible() && !ALL.equals(completionCombo.getSelectedItem())) {
            params.put("completion_filter", completionCombo.getSelectedItem().toString());
        }
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
                    return new FilterProfile(true, true, true, true, true, true, false, true);
                case COURSE_PERFORMANCE:
                    return new FilterProfile(true, true, false, false, false, false, true, false);
                case STUDENT_DETAIL:
                    return new FilterProfile(true, true, true, false, false, true, false, false);
                case ATTENDANCE_CROSSTAB:
                    return new FilterProfile(true, true, false, false, false, false, false, false);
                case STUDENT_ATTENDANCE:
                    return new FilterProfile(true, true, true, false, false, true, false, false);
                case EXAM_ASSIGNMENT_REPORT:
                    return new FilterProfile(false, true, true, false, false, true, false, false);
                default:
                    return new FilterProfile(true, true, true, true, true, true, true, true);
            }
        }
    }
}
