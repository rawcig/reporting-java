package org.example.model;

public enum ReportType {

    STUDENT_ENROLLMENT(
            "Student Enrollment Report",
            "reports/student_enrollment_report.jrxml",
            """
            SELECT
                e.enrollment_id,
                s.student_code,
                s.first_name || ' ' || s.last_name AS student_name,
                s.gender,
                s.phone,
                s.email,
                c.course_code,
                c.course_name,
                t.first_name || ' ' || t.last_name AS teacher_name,
                e.enrollment_date,
                e.payment_status,
                e.payment_amount,
                c.course_fee,
                e.completion_status,
                e.progress_percentage,
                e.final_grade,
                e.certificate_issued,
                e.certificate_number,
                rc.regcom_name AS institute_name
            FROM enrollments e
            JOIN students s ON e.student_id = s.student_id
            JOIN courses c ON e.course_id = c.course_id
            LEFT JOIN teachers t ON c.teacher_id = t.teacher_id
            LEFT JOIN register_company rc ON c.regcom_id = rc.regcom_id
            ORDER BY e.enrollment_date DESC, s.last_name, s.first_name
            """
    ),

    COURSE_PERFORMANCE(
            "Course Performance Report",
            "reports/course_performance_report.jrxml",
            """
            SELECT
                c.course_code,
                c.course_name,
                c.course_description,
                c.duration_hours,
                c.start_date,
                c.end_date,
                c.course_fee,
                c.skill_level,
                c.status,
                rc.regcom_name AS institute_name,
                t.first_name || ' ' || t.last_name AS teacher_name,
                t.qualification,
                t.specialization,
                COUNT(DISTINCT e.student_id) AS total_students,
                COUNT(DISTINCT CASE WHEN e.completion_status = 'Completed' THEN e.student_id END) AS completed_students,
                COALESCE(ROUND(AVG(e.progress_percentage), 2), 0) AS avg_progress,
                COALESCE(SUM(CASE WHEN e.payment_status = 'Paid' THEN 1 ELSE 0 END), 0) AS paid_students,
                COALESCE(SUM(CASE WHEN e.payment_status = 'Pending' THEN 1 ELSE 0 END), 0) AS pending_students,
                COALESCE(SUM(CASE WHEN e.payment_status = 'Paid' THEN e.payment_amount ELSE 0 END), 0) AS total_revenue
            FROM courses c
            LEFT JOIN teachers t ON c.teacher_id = t.teacher_id
            LEFT JOIN register_company rc ON c.regcom_id = rc.regcom_id
            LEFT JOIN enrollments e ON c.course_id = e.course_id
            GROUP BY c.course_id, c.course_code, c.course_name, c.course_description,
                     c.duration_hours, c.start_date, c.end_date, c.course_fee,
                     c.skill_level, c.status, rc.regcom_name,
                     t.first_name, t.last_name, t.qualification, t.specialization
            ORDER BY c.start_date DESC
            """
    ),

    STUDENT_ATTENDANCE(
            "Student Attendance Report",
            "reports/student_attendance_report.jrxml",
            """
            SELECT
                s.student_code,
                s.first_name || ' ' || s.last_name AS student_name,
                s.gender,
                s.phone,
                s.email,
                c.course_code,
                c.course_name,
                COUNT(*) AS total_sessions,
                SUM(CASE WHEN oa.status = 'Present' THEN 1 ELSE 0 END) AS present_count,
                SUM(CASE WHEN oa.status = 'Absent' THEN 1 ELSE 0 END) AS absent_count,
                ROUND(
                    SUM(CASE WHEN oa.status = 'Present' THEN 1 ELSE 0 END)::numeric / COUNT(*) * 100, 2
                ) AS attendance_percentage,
                COALESCE(SUM(CASE WHEN oa.status = 'Present' THEN oa.duration_minutes ELSE 0 END), 0) AS total_minutes_attended,
                rc.regcom_name AS institute_name
            FROM online_attendance oa
            JOIN students s ON oa.student_id = s.student_id
            JOIN courses c ON oa.course_id = c.course_id
            LEFT JOIN register_company rc ON c.regcom_id = rc.regcom_id
            WHERE oa.attendance_type = 'Student'
            GROUP BY s.student_id, s.student_code, s.first_name, s.last_name, s.gender,
                     s.phone, s.email, c.course_id, c.course_code, c.course_name, rc.regcom_name
            ORDER BY s.last_name, s.first_name, c.course_code
            """
    ),

    EXAM_ASSIGNMENT_REPORT(
            "Exam & Assignment Performance Report",
            "reports/exam_assignment_report.jrxml",
            """
            SELECT
                s.student_code,
                s.first_name || ' ' || s.last_name AS student_name,
                s.gender,
                c.course_code,
                c.course_name,
                'Assignment' AS record_type,
                a.assignment_title AS title,
                a.due_date,
                a.total_marks,
                ast.marks_obtained,
                CASE
                    WHEN ast.marks_obtained IS NOT NULL AND a.total_marks > 0
                    THEN ROUND((ast.marks_obtained / a.total_marks) * 100, 2)
                    ELSE NULL
                END AS percentage,
                ast.status AS submission_status,
                ast.submission_date,
                ast.feedback
            FROM assignment_submissions ast
            JOIN students s ON ast.student_id = s.student_id
            JOIN assignments a ON ast.assignment_id = a.assignment_id
            JOIN courses c ON a.course_id = c.course_id

            UNION ALL

            SELECT
                s.student_code,
                s.first_name || ' ' || s.last_name AS student_name,
                s.gender,
                c.course_code,
                c.course_name,
                'Exam' AS record_type,
                ex.exam_title AS title,
                ex.exam_date AS due_date,
                ex.total_marks,
                er.marks_obtained,
                er.percentage,
                CASE WHEN er.passed = true THEN 'Passed' ELSE 'Failed' END AS submission_status,
                er.exam_date AS submission_date,
                NULL AS feedback
            FROM exam_results er
            JOIN students s ON er.student_id = s.student_id
            JOIN exams ex ON er.exam_id = ex.exam_id
            JOIN courses c ON ex.course_id = c.course_id

            ORDER BY student_name, course_code, record_type, due_date DESC
            """
    );

    private final String displayName;
    private final String jrxmlPath;
    private final String sqlQuery;

    ReportType(String displayName, String jrxmlPath, String sqlQuery) {
        this.displayName = displayName;
        this.jrxmlPath = jrxmlPath;
        this.sqlQuery = sqlQuery;
    }

    public String getDisplayName() {
        return displayName;
    }

    public String getJrxmlPath() {
        return jrxmlPath;
    }

    public String getSqlQuery() {
        return sqlQuery;
    }

    @Override
    public String toString() {
        return displayName;
    }
}
