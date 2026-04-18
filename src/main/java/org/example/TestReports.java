package org.example;

import org.example.model.ReportType;
import org.example.service.ReportGenerator;
import org.example.util.DBConnection;
import net.sf.jasperreports.engine.JasperPrint;

import java.util.HashMap;

/**
 * Test all report types by generating them directly (no UI).
 * Captures errors and prints them to stdout.
 */
public class TestReports {
    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("  REPORT GENERATION TEST");
        System.out.println("========================================");
        System.out.println();

        // 1. Test DB connection
        System.out.println("[TEST] Database connection...");
        DBConnection.DBResult dbResult = DBConnection.checkConnection();
        if (!dbResult.isSuccess()) {
            System.err.println("[FAIL] " + dbResult.getMessage());
            System.exit(1);
        }
        System.out.println("[PASS] Database connected OK\n");

        // 2. Test each report type
        ReportType[] allTypes = ReportType.values();
        int passed = 0, failed = 0;

        for (ReportType rt : allTypes) {
            System.out.println("----------------------------------------");
            System.out.println("[TEST] " + rt.getDisplayName());
            System.out.println("  JRXML: " + rt.getJrxmlPath());
            System.out.flush();

            try {
                long start = System.currentTimeMillis();
                JasperPrint jp = ReportGenerator.generate(rt, new HashMap<>());
                long elapsed = System.currentTimeMillis() - start;
                int pages = jp.getPages().size();
                System.out.println("[PASS] Generated in " + elapsed + "ms, " + pages + " page(s)\n");
                passed++;

            } catch (Exception e) {
                System.out.println("[FAIL] " + e.getClass().getSimpleName() + ": " + e.getMessage());
                // Print full stack trace for debugging
                e.printStackTrace(System.out);
                System.out.println();
                failed++;
            }
        }

        // 3. Summary
        System.out.println("========================================");
        System.out.println("  RESULTS: " + passed + " passed, " + failed + " failed out of " + allTypes.length);
        System.out.println("========================================");

        if (failed > 0) {
            System.exit(1);
        }
    }
}
