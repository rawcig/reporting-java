package org.example.ui;

import net.sf.jasperreports.engine.JasperPrint;
import org.example.model.ReportType;
import org.example.service.ReportGenerator;
import org.example.util.DBConnection;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;
import javax.swing.KeyStroke;
import javax.swing.AbstractAction;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class DashboardFrame extends JFrame {

    private JComboBox<ReportType> reportCombo;
    private JButton generateBtn;
    private JButton filterBtn;
    private JLabel statusLabel;
    private JProgressBar progressBar;
    private Map<String, Object> activeFilters;
    private JLabel filterSummaryLabel;

    public DashboardFrame() {
        initComponents();
        layoutComponents();

        // Center and focus the window
        setLocationRelativeTo(null);
        requestFocus();
        toFront();
    }

    private void initComponents() {
        setTitle("Training System - Report Dashboard");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(800, 550);
        setLocationRelativeTo(null);
        setMinimumSize(new Dimension(700, 480));

        activeFilters = new HashMap<>();

        reportCombo = new JComboBox<>(ReportType.values());
        reportCombo.setFont(new Font("Segoe UI", Font.PLAIN, 14));
        reportCombo.setSelectedIndex(0);

        filterBtn = new JButton("\uD83D\uDD0D Filters");
        filterBtn.setFont(new Font("Segoe UI", Font.BOLD, 13));
        filterBtn.setPreferredSize(new Dimension(140, 38));
        filterBtn.addActionListener(e -> openFilterDialog());

        generateBtn = new JButton("Generate Report");
        generateBtn.setFont(new Font("Segoe UI", Font.BOLD, 14));
        generateBtn.setPreferredSize(new Dimension(200, 42));
        generateBtn.addActionListener(e -> generateReport());

        statusLabel = new JLabel("Select a report and click Generate to preview");
        statusLabel.setBorder(new EmptyBorder(5, 5, 5, 5));

        filterSummaryLabel = new JLabel("No active filters");
        filterSummaryLabel.setFont(new Font("Segoe UI", Font.ITALIC, 11));
        filterSummaryLabel.setForeground(new Color(130, 130, 130));

        progressBar = new JProgressBar();
        progressBar.setVisible(false);
        progressBar.setIndeterminate(true);
        progressBar.setMaximumSize(new Dimension(Integer.MAX_VALUE, 6));
    }

    private void layoutComponents() {
        JPanel mainPanel = new JPanel(new BorderLayout(10, 10));
        mainPanel.setBorder(new EmptyBorder(20, 25, 15, 25));

        // --- Header ---
        JPanel headerPanel = new JPanel(new BorderLayout(0, 4));
        headerPanel.setBorder(new EmptyBorder(0, 0, 15, 0));

        JLabel titleLabel = new JLabel("Report Center");
        titleLabel.setFont(new Font("Segoe UI", Font.BOLD, 24));

        JLabel subtitleLabel = new JLabel("Generate and preview training system reports");
        subtitleLabel.setFont(new Font("Segoe UI", Font.PLAIN, 13));
        subtitleLabel.setForeground(new Color(130, 130, 130));

        headerPanel.add(titleLabel, BorderLayout.NORTH);
        headerPanel.add(subtitleLabel, BorderLayout.CENTER);

        // --- Center: report selection card ---
        JPanel selectionCard = new JPanel(new BorderLayout(0, 12));
        selectionCard.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(210, 210, 210), 1, true),
                new EmptyBorder(20, 22, 20, 22)
        ));

        // Report list (descriptions)
        JPanel descPanel = new JPanel(new GridLayout(0, 1, 0, 6));
        for (ReportType rt : ReportType.values()) {
            JLabel lbl = new JLabel("\u2022  " + rt.getDisplayName());
            lbl.setFont(new Font("Segoe UI", Font.PLAIN, 12));
            lbl.setForeground(new Color(110, 110, 110));
            descPanel.add(lbl);
        }

        // Combo row
        JPanel comboRow = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
        JLabel comboLabel = new JLabel("Report Type:  ");
        comboLabel.setFont(new Font("Segoe UI", Font.BOLD, 13));
        comboRow.add(comboLabel);
        comboRow.add(reportCombo);

        selectionCard.add(comboRow, BorderLayout.NORTH);
        selectionCard.add(descPanel, BorderLayout.CENTER);

        // --- Bottom: button + status ---
        JPanel bottomPanel = new JPanel(new BorderLayout(0, 8));

        // Button row
        JPanel btnRow = new JPanel(new FlowLayout(FlowLayout.CENTER, 12, 8));
        btnRow.add(filterBtn);
        btnRow.add(generateBtn);

        // Filter summary
        JPanel filterRow = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
        filterRow.add(filterSummaryLabel);

        // Status row (progress bar + text)
        JPanel statusRow = new JPanel(new BorderLayout(5, 0));
        statusRow.add(progressBar, BorderLayout.NORTH);
        statusRow.add(statusLabel, BorderLayout.CENTER);

        bottomPanel.add(btnRow, BorderLayout.NORTH);
        bottomPanel.add(filterRow, BorderLayout.CENTER);
        bottomPanel.add(statusRow, BorderLayout.SOUTH);

        // --- Assemble ---
        mainPanel.add(headerPanel, BorderLayout.NORTH);
        mainPanel.add(selectionCard, BorderLayout.CENTER);
        mainPanel.add(bottomPanel, BorderLayout.SOUTH);

        add(mainPanel);
        getRootPane().setDefaultButton(generateBtn);
        
        // Add F5 keyboard shortcut for Generate
        KeyStroke f5 = KeyStroke.getKeyStroke("F5");
        getRootPane().getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW).put(f5, "generateReport");
        getRootPane().getActionMap().put("generateReport", new AbstractAction() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent e) {
                generateReport();
            }
        });
        
        // Add Ctrl+F for Filter dialog
        KeyStroke ctrlF = KeyStroke.getKeyStroke("ctrl F");
        getRootPane().getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW).put(ctrlF, "openFilter");
        getRootPane().getActionMap().put("openFilter", new AbstractAction() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent e) {
                openFilterDialog();
            }
        });
        
        // Add Escape to clear filters
        KeyStroke escape = KeyStroke.getKeyStroke("ESCAPE");
        getRootPane().getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW).put(escape, "clearFilters");
        getRootPane().getActionMap().put("clearFilters", new AbstractAction() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent e) {
                clearFilters();
            }
        });
    }

    private void openFilterDialog() {
        ReportType selected = (ReportType) reportCombo.getSelectedItem();
        if (selected == null) return;

        FilterDialog dialog = new FilterDialog(this, selected);
        Map<String, Object> result = dialog.showAndGetParameters();
        if (result != null) {
            activeFilters = result;
            updateFilterSummary(selected);
        }
    }

    private void updateFilterSummary(ReportType rt) {
        List<String> parts = new ArrayList<>();
        if (activeFilters.get("institute_name") != null) {
            parts.add("Institute: " + activeFilters.get("institute_name"));
        }
        if (activeFilters.get("course_filter") != null) {
            parts.add("Course: " + activeFilters.get("course_filter"));
        }
        if (activeFilters.get("student_filter") != null) {
            parts.add("Student: " + activeFilters.get("student_filter"));
        }
        if (activeFilters.get("payment_filter") != null) {
            parts.add("Payment: " + activeFilters.get("payment_filter"));
        }
        if (activeFilters.get("gender_filter") != null) {
            parts.add("Gender: " + activeFilters.get("gender_filter"));
        }
        if (activeFilters.get("skill_filter") != null) {
            parts.add("Skill: " + activeFilters.get("skill_filter"));
        }
        if (activeFilters.get("completion_filter") != null) {
            parts.add("Completion: " + activeFilters.get("completion_filter"));
        }
        if (activeFilters.get("from_date") != null) {
            parts.add("Date: " + activeFilters.get("from_date") + " \u2192 " + activeFilters.get("to_date"));
        }
        if (parts.isEmpty()) {
            filterSummaryLabel.setText("No active filters for " + rt.getDisplayName());
            filterSummaryLabel.setForeground(new Color(130, 130, 130));
        } else {
            filterSummaryLabel.setText("\uD83D\uDD3D " + String.join("  \u2502  ", parts));
            filterSummaryLabel.setForeground(new Color(0, 100, 0));
            filterSummaryLabel.setFont(filterSummaryLabel.getFont().deriveFont(Font.PLAIN, 10));
        }
    }

    private void generateReport() {
        ReportType selected = (ReportType) reportCombo.getSelectedItem();
        if (selected == null) {
            JOptionPane.showMessageDialog(this,
                    "Please select a report type.",
                    "No Selection",
                    JOptionPane.WARNING_MESSAGE);
            return;
        }

        // Disable UI during generation
        statusLabel.setText("Checking database connection...");
        statusLabel.setForeground(new Color(80, 80, 80));
        generateBtn.setEnabled(false);
        progressBar.setVisible(true);
        progressBar.setIndeterminate(true);
        revalidate();
        repaint();

        // Single worker: check DB -> generate -> show preview
        SwingWorker<ReportResult, Void> worker = new SwingWorker<>() {
            @Override
            protected ReportResult doInBackground() {
                try {
                    // Step 1: Verify DB
                    DBConnection.DBResult dbResult = DBConnection.checkConnection();
                    if (!dbResult.isSuccess()) {
                        return new ReportResult(false, null, dbResult.getMessage());
                    }

                    // Step 2: Generate report (returns JasperPrint or throws)
                    JasperPrint jp = ReportGenerator.generate(selected, activeFilters);
                    return new ReportResult(true, jp, null);

                } catch (Exception e) {
                    System.err.println("  ERROR in background: " + e.getMessage());
                    e.printStackTrace();
                    return new ReportResult(false, null, e.getMessage());
                }
            }

            @Override
            protected void done() {
                generateBtn.setEnabled(true);
                progressBar.setVisible(false);

                try {
                    ReportResult result = get();

                    if (!result.success) {
                        // Show error
                        statusLabel.setText("Failed — check errors below");
                        statusLabel.setForeground(new Color(192, 0, 0));
                        if (result.errorMessage.contains("database") || result.errorMessage.contains("Connection")) {
                            showDbDownDialog(result.errorMessage);
                        } else {
                            JOptionPane.showMessageDialog(DashboardFrame.this,
                                    "Report generation failed:\n\n" + result.errorMessage,
                                    "Report Error",
                                    JOptionPane.ERROR_MESSAGE);
                        }
                        return;
                    }

                    if (result.jasperPrint == null || result.jasperPrint.getPages().isEmpty()) {
                        statusLabel.setText("Report contains no data");
                        statusLabel.setForeground(new Color(192, 0, 0));
                        JOptionPane.showMessageDialog(DashboardFrame.this,
                                "Report generated but contains no data.",
                                "No Data",
                                JOptionPane.INFORMATION_MESSAGE);
                        return;
                    }

                    // Success — show preview
                    statusLabel.setText("Preview open — " + selected.getDisplayName());
                    statusLabel.setForeground(new Color(40, 120, 40));
                    String title = selected.getDisplayName() + " - Report Preview";
                    ReportPreviewFrame preview = new ReportPreviewFrame(
                            DashboardFrame.this, result.jasperPrint, title);
                    preview.showOnTop();

                } catch (Exception e) {
                    System.err.println("  ERROR in done(): " + e.getMessage());
                    e.printStackTrace();
                    statusLabel.setText("Unexpected error occurred");
                    statusLabel.setForeground(new Color(192, 0, 0));
                    JOptionPane.showMessageDialog(DashboardFrame.this,
                            "Unexpected error: " + e.getMessage(),
                            "Error",
                            JOptionPane.ERROR_MESSAGE);
                }
            }
        };
        worker.execute();
    }

    /** Simple result wrapper for the background report task */
    private static class ReportResult {
        final boolean success;
        final JasperPrint jasperPrint;
        final String errorMessage;

        ReportResult(boolean success, JasperPrint jasperPrint, String errorMessage) {
            this.success = success;
            this.jasperPrint = jasperPrint;
            this.errorMessage = errorMessage;
        }
    }

    private void clearFilters() {
        activeFilters.clear();
        ReportType selected = (ReportType) reportCombo.getSelectedItem();
        if (selected != null) {
            updateFilterSummary(selected);
        }
        statusLabel.setText("Filters cleared");
        statusLabel.setForeground(new Color(130, 130, 130));
    }

    /**
     * Shows a warning dialog when the database is unreachable during report generation.
     */
    private void showDbDownDialog(String detailMessage) {
        JPanel panel = new JPanel(new BorderLayout(10, 10));
        panel.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));

        JPanel headerPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 0));
        JLabel iconLabel = new JLabel(UIManager.getIcon("OptionPane.warningIcon"));
        JLabel headerLabel = new JLabel("<html><b style='font-size:13px;'>Database Unavailable</b><br>"
                + "<span style='font-size:11px;'>Cannot generate report at this time.</span></html>");
        headerPanel.add(iconLabel);
        headerPanel.add(headerLabel);
        panel.add(headerPanel, BorderLayout.NORTH);

        JTextArea detailsArea = new JTextArea(detailMessage);
        detailsArea.setEditable(false);
        detailsArea.setFont(new Font("Segoe UI", Font.PLAIN, 11));
        detailsArea.setLineWrap(true);
        detailsArea.setWrapStyleWord(true);
        detailsArea.setBackground(new Color(255, 250, 240));
        detailsArea.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));

        JScrollPane scrollPane = new JScrollPane(detailsArea);
        scrollPane.setPreferredSize(new Dimension(450, 120));
        panel.add(scrollPane, BorderLayout.CENTER);

        JOptionPane.showMessageDialog(this,
                panel,
                "Database Connection Error",
                JOptionPane.WARNING_MESSAGE);
    }
}
