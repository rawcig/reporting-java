package org.example;

import org.example.model.ReportType;
import org.example.service.ReportGenerator;
import org.example.util.DBConnection;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

import java.io.File;
import java.io.FileOutputStream;

/**
 * Test PDF export functionality.
 */
public class TestPdfExport {
    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("  PDF EXPORT TEST");
        System.out.println("========================================\n");

        // 1. Test DB connection
        System.out.println("[TEST] Database connection...");
        DBConnection.DBResult dbResult = DBConnection.checkConnection();
        if (!dbResult.isSuccess()) {
            System.err.println("[FAIL] " + dbResult.getMessage());
            System.exit(1);
        }
        System.out.println("[PASS] Database connected OK\n");

        // 2. Generate a report
        System.out.println("[TEST] Generating report...");
        try {
            JasperPrint jp = ReportGenerator.generate(ReportType.STUDENT_ENROLLMENT, new java.util.HashMap<>());
            System.out.println("[PASS] Report generated: " + jp.getPages().size() + " pages\n");

            // 3. Export to PDF
            System.out.println("[TEST] Exporting to PDF...");
            File pdfFile = new File("test_export.pdf");
            
            try (FileOutputStream fos = new FileOutputStream(pdfFile)) {
                JRPdfExporter exporter = new JRPdfExporter();
                exporter.setExporterInput(new SimpleExporterInput(jp));
                exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(fos));
                
                SimplePdfExporterConfiguration config = new SimplePdfExporterConfiguration();
                config.setCreatingBatchModeBookmarks(true);
                config.setMetadataAuthor("Test System");
                config.setMetadataTitle("Test Report");
                exporter.setConfiguration(config);
                
                exporter.exportReport();
            }
            
            if (pdfFile.exists() && pdfFile.length() > 0) {
                System.out.println("[PASS] PDF exported successfully!");
                System.out.println("  File: " + pdfFile.getAbsolutePath());
                System.out.println("  Size: " + (pdfFile.length() / 1024) + " KB");
            } else {
                System.err.println("[FAIL] PDF file is empty or not created");
            }
            
        } catch (Exception e) {
            System.err.println("[FAIL] " + e.getClass().getName() + ": " + e.getMessage());
            e.printStackTrace(System.out);
        }
    }
}
