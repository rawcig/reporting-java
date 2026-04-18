package org.example;

import org.example.model.ReportType;
import org.example.service.ReportGenerator;
import org.example.util.DBConnection;
import net.sf.jasperreports.engine.JasperPrint;

import java.util.HashMap;
import java.util.Map;

/**
 * Test reports WITH filters applied to verify SQL WHERE clause insertion.
 */
public class TestFilteredReports {
    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("  FILTERED REPORT TEST");
        System.out.println("========================================\n");

        // Test DB
        DBConnection.DBResult db = DBConnection.checkConnection();
        if (!db.isSuccess()) { System.err.println("DB FAIL: " + db.getMessage()); System.exit(1); }
        System.out.println("[PASS] Database OK\n");

        int passed = 0, failed = 0;

        for (ReportType rt : ReportType.values()) {
            System.out.println("----------------------------------------");
            System.out.println("[TEST] " + rt.getDisplayName() + " (WITH FILTERS)");

            Map<String, Object> filters = buildTestFilters(rt);

            try {
                long start = System.currentTimeMillis();
                JasperPrint jp = ReportGenerator.generate(rt, filters);
                long elapsed = System.currentTimeMillis() - start;
                int pages = jp.getPages().size();
                System.out.println("[PASS] Generated in " + elapsed + "ms, " + pages + " page(s)\n");
                passed++;
            } catch (Exception e) {
                System.out.println("[FAIL] " + e.getClass().getSimpleName() + ": " + e.getMessage());
                // Print first 3 lines of stack trace
                StackTraceElement[] st = e.getStackTrace();
                if (st.length > 0) System.out.println("  at " + st[0]);
                System.out.println();
                failed++;
            }
        }

        System.out.println("========================================");
        System.out.println("  RESULTS: " + passed + " passed, " + failed + " failed out of " + ReportType.values().length);
        System.out.println("========================================");

        if (failed > 0) System.exit(1);
    }

    private static Map<String, Object> buildTestFilters(ReportType rt) {
        Map<String, Object> f = new HashMap<>();
        switch (rt) {
            case STUDENT_ENROLLMENT:
                // Test: filter by gender
                f.put("gender_filter", "M");
                break;
            case COURSE_PERFORMANCE:
                // Test: filter by skill level
                f.put("skill_filter", "Beginner");
                break;
            case STUDENT_DETAIL:
                // Test: filter by gender
                f.put("gender_filter", "F");
                break;
            case ATTENDANCE_CROSSTAB:
                // No filters (only institute/course available)
                break;
            case STUDENT_ATTENDANCE:
                // Test: filter by gender
                f.put("gender_filter", "M");
                break;
            case EXAM_ASSIGNMENT_REPORT:
                // Test: filter by gender
                f.put("gender_filter", "M");
                break;
        }
        return f;
    }
}
