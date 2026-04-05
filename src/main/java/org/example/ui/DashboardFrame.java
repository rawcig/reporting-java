package org.example.ui;

import org.example.model.ReportType;
import org.example.service.ReportGenerator;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class DashboardFrame extends JFrame {

    private JComboBox<ReportType> reportCombo;
    private JButton generateBtn;
    private JLabel statusLabel;
    private JProgressBar progressBar;

    public DashboardFrame() {
        initComponents();
        layoutComponents();

        // Force window to front and center
        setAlwaysOnTop(true);
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

        reportCombo = new JComboBox<>(ReportType.values());
        reportCombo.setFont(new Font("Segoe UI", Font.PLAIN, 14));
        reportCombo.setSelectedIndex(0);

        generateBtn = new JButton("Generate Report");
        generateBtn.setFont(new Font("Segoe UI", Font.BOLD, 14));
        generateBtn.setPreferredSize(new Dimension(200, 42));
        generateBtn.addActionListener(e -> generateReport());

        statusLabel = new JLabel("Select a report and click Generate to preview");
        statusLabel.setBorder(new EmptyBorder(5, 5, 5, 5));

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
        JPanel btnRow = new JPanel(new FlowLayout(FlowLayout.CENTER, 10, 8));
        btnRow.add(generateBtn);

        // Status row (progress bar + text)
        JPanel statusRow = new JPanel(new BorderLayout(5, 0));
        statusRow.add(progressBar, BorderLayout.NORTH);
        statusRow.add(statusLabel, BorderLayout.CENTER);

        bottomPanel.add(btnRow, BorderLayout.NORTH);
        bottomPanel.add(statusRow, BorderLayout.CENTER);

        // --- Assemble ---
        mainPanel.add(headerPanel, BorderLayout.NORTH);
        mainPanel.add(selectionCard, BorderLayout.CENTER);
        mainPanel.add(bottomPanel, BorderLayout.SOUTH);

        add(mainPanel);
        getRootPane().setDefaultButton(generateBtn);
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

        generateBtn.setEnabled(false);
        progressBar.setVisible(true);
        statusLabel.setText("Generating: " + selected.getDisplayName() + "...");
        statusLabel.setForeground(new Color(80, 80, 80));
        revalidate();
        repaint();

        // Run in background so UI stays responsive
        SwingWorker<Void, Void> worker = new SwingWorker<>() {
            @Override
            protected Void doInBackground() {
                ReportGenerator.generateAndPreview(selected, DashboardFrame.this);
                return null;
            }

            @Override
            protected void done() {
                generateBtn.setEnabled(true);
                progressBar.setVisible(false);
                statusLabel.setText("Ready — select a report to generate");
                statusLabel.setForeground(new Color(80, 80, 80));
                revalidate();
                repaint();
            }
        };
        worker.execute();
    }
}
