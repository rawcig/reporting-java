package org.example.service;

import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;
import org.example.model.ReportType;
import org.example.util.DBConnection;

import javax.swing.*;
import java.awt.*;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class ReportGenerator {

    /**
     * Generates and previews a report using JasperViewer.
     * This method blocks until the report is ready.
     */
    public static void generateAndPreview(ReportType reportType, JFrame parent) {
        System.out.println("=== Starting: " + reportType.getDisplayName() + " ===");
        System.out.flush();

        try {
            // Step 1: Load JRXML
            System.out.println("  [1/5] Loading JRXML template...");
            System.out.flush();
            String jrxmlPath = reportType.getJrxmlPath();
            InputStream jrxmlStream = ReportGenerator.class.getClassLoader().getResourceAsStream(jrxmlPath);
            if (jrxmlStream == null) {
                throw new RuntimeException("Report template not found: " + jrxmlPath);
            }
            System.out.println("  [1/5] OK: " + jrxmlPath);
            System.out.flush();

            // Step 2: Compile
            System.out.println("  [2/5] Compiling JRXML...");
            System.out.flush();
            JasperDesign jasperDesign = JRXmlLoader.load(jrxmlStream);
            JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
            System.out.println("  [2/5] Compiled successfully");
            System.out.flush();

            // Step 3: Connect to DB
            System.out.println("  [3/5] Connecting to database...");
            System.out.flush();
            Connection conn = DBConnection.getConnection();
            System.out.println("  [3/5] Connected");
            System.out.flush();

            // Step 4: Execute query and fill report
            System.out.println("  [4/5] Executing query and filling report...");
            System.out.flush();
            long start = System.currentTimeMillis();
            var stmt = conn.createStatement();
            stmt.setQueryTimeout(30);
            var rs = stmt.executeQuery(reportType.getSqlQuery());
            JRResultSetDataSource dataSource = new JRResultSetDataSource(rs);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, new HashMap<>(), dataSource);
            long elapsed = System.currentTimeMillis() - start;
            System.out.println("  [4/5] Filled in " + elapsed + "ms, pages: " + jasperPrint.getPages().size());
            System.out.flush();

            conn.close();

            if (jasperPrint.getPages().isEmpty()) {
                // Show no-data dialog on EDT
                SwingUtilities.invokeLater(() ->
                    JOptionPane.showMessageDialog(parent,
                        "Report generated but contains no data.",
                        "No Data",
                        JOptionPane.INFORMATION_MESSAGE)
                );
                return;
            }

            // Step 5: Show viewer on EDT
            System.out.println("  [5/5] Opening preview window...");
            System.out.flush();
            final JasperPrint fp = jasperPrint;
            final String title = reportType.getDisplayName();
            SwingUtilities.invokeLater(() -> {
                try {
                    JasperViewer viewer = new JasperViewer(fp, false);
                    viewer.setTitle(title + " - Report Preview");
                    viewer.setAlwaysOnTop(true);
                    viewer.setSize(1100, 750);
                    viewer.setLocationRelativeTo(parent);
                    viewer.setVisible(true);
                    viewer.toFront();
                    System.out.println("  [5/5] Viewer displayed");
                    System.out.flush();
                } catch (Exception e) {
                    System.err.println("  [5/5] Viewer ERROR: " + e.getMessage());
                    e.printStackTrace();
                }
            });

        } catch (Throwable e) {
            System.err.println("  ERROR: " + e.getClass().getName() + ": " + e.getMessage());
            e.printStackTrace(System.err);
            System.err.flush();

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
}
