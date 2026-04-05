import java.sql.*;
public class DBTest {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://localhost:5432/online_short_course_db";
        String user = "postgres";
        String pass = "12345";
        
        System.out.println("Testing DB connection...");
        System.out.println("URL: " + url);
        System.out.println("User: " + user);
        
        try {
            Connection conn = DriverManager.getConnection(url, user, pass);
            System.out.println(">> CONNECTED SUCCESSFULLY <<");
            
            Statement stmt = conn.createStatement();
            stmt.setQueryTimeout(10);
            
            String[] tables = {"enrollments", "students", "courses", "online_attendance", 
                              "assignments", "assignment_submissions", "exams", "exam_results", "teachers"};
            
            for (String table : tables) {
                try {
                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM " + table);
                    if (rs.next()) {
                        System.out.println("  " + table + ": " + rs.getInt(1) + " rows");
                    }
                } catch (SQLException e) {
                    System.out.println("  " + table + ": ERROR - " + e.getMessage());
                }
            }
            
            // Test the actual report queries with timeout
            System.out.println("\n--- Testing report queries (10s timeout each) ---");
            
            String q1 = "SELECT e.enrollment_id, s.student_code, s.first_name || ' ' || s.last_name AS student_name, s.gender, s.phone, s.email, c.course_code, c.course_name, t.first_name || ' ' || t.last_name AS teacher_name, e.enrollment_date, e.payment_status, e.payment_amount, c.course_fee, e.completion_status, e.progress_percentage, e.final_grade, e.certificate_issued, e.certificate_number, rc.regcom_name AS institute_name FROM enrollments e JOIN students s ON e.student_id = s.student_id JOIN courses c ON e.course_id = c.course_id LEFT JOIN teachers t ON c.teacher_id = t.teacher_id LEFT JOIN register_company rc ON c.regcom_id = rc.regcom_id ORDER BY e.enrollment_date DESC, s.last_name, s.first_name";
            
            try {
                long start = System.currentTimeMillis();
                ResultSet rs = stmt.executeQuery(q1);
                int count = 0;
                while (rs.next()) count++;
                System.out.println("  Enrollment query: " + count + " rows in " + (System.currentTimeMillis()-start) + "ms");
            } catch (SQLException e) {
                System.out.println("  Enrollment query FAILED: " + e.getMessage());
            }
            
            conn.close();
            System.out.println("\nDB test complete.");
            
        } catch (SQLException e) {
            System.out.println(">> CONNECTION FAILED <<");
            System.out.println("Error: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
            e.printStackTrace();
        }
    }
}
