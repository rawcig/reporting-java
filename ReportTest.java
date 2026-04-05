import java.sql.*;
import java.io.*;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

public class ReportTest {
    public static void main(String[] args) throws Exception {
        String url = "jdbc:postgresql://localhost:5432/online_short_course_db";
        String user = "postgres";
        String pass = "12345";

        System.out.println("=== Direct Report Test ===");
        
        // Load JRXML
        String jrxmlPath = "target/classes/reports/student_enrollment_report.jrxml";
        System.out.println("Loading: " + jrxmlPath);
        FileInputStream fis = new FileInputStream(jrxmlPath);
        JasperDesign jd = JRXmlLoader.load(fis);
        System.out.println("JRXML loaded OK");
        
        JasperReport jr = JasperCompileManager.compileReport(jd);
        System.out.println("Compiled OK");
        
        // Connect and fill
        Connection conn = DriverManager.getConnection(url, user, pass);
        String sql = "SELECT e.enrollment_id, s.student_code, s.first_name || ' ' || s.last_name AS student_name, s.gender, s.phone, s.email, c.course_code, c.course_name, t.first_name || ' ' || t.last_name AS teacher_name, e.enrollment_date, e.payment_status, e.payment_amount, c.course_fee, e.completion_status, e.progress_percentage, e.final_grade, e.certificate_issued, e.certificate_number, rc.regcom_name AS institute_name FROM enrollments e JOIN students s ON e.student_id = s.student_id JOIN courses c ON e.course_id = c.course_id LEFT JOIN teachers t ON c.teacher_id = t.teacher_id LEFT JOIN register_company rc ON c.regcom_id = rc.regcom_id ORDER BY e.enrollment_date DESC, s.last_name, s.first_name";
        
        Statement stmt = conn.createStatement();
        stmt.setQueryTimeout(10);
        ResultSet rs = stmt.executeQuery(sql);
        
        JRResultSetDataSource ds = new JRResultSetDataSource(rs);
        JasperPrint jp = JasperFillManager.fillReport(jr, new java.util.HashMap<>(), ds);
        
        System.out.println("Report filled: " + jp.getPages().size() + " pages");
        
        if (jp.getPages().isEmpty()) {
            System.out.println("ERROR: No pages generated!");
        } else {
            System.out.println("SUCCESS: Report generated with " + jp.getPages().size() + " page(s)");
        }
        
        conn.close();
    }
}
