/*
 Navicat Premium Dump SQL

 Source Server         : Posgtre
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : Reporting
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 25/03/2026 17:46:57
*/


-- ----------------------------
-- Sequence structure for assignment_submissions_submission_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."assignment_submissions_submission_id_seq";
CREATE SEQUENCE "public"."assignment_submissions_submission_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for assignments_assignment_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."assignments_assignment_id_seq";
CREATE SEQUENCE "public"."assignments_assignment_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for course_reviews_review_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."course_reviews_review_id_seq";
CREATE SEQUENCE "public"."course_reviews_review_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for courses_course_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."courses_course_id_seq";
CREATE SEQUENCE "public"."courses_course_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for enrollments_enrollment_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."enrollments_enrollment_id_seq";
CREATE SEQUENCE "public"."enrollments_enrollment_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for exam_questions_question_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."exam_questions_question_id_seq";
CREATE SEQUENCE "public"."exam_questions_question_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for exam_results_result_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."exam_results_result_id_seq";
CREATE SEQUENCE "public"."exam_results_result_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for exams_exam_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."exams_exam_id_seq";
CREATE SEQUENCE "public"."exams_exam_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for lesson_completion_completion_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."lesson_completion_completion_id_seq";
CREATE SEQUENCE "public"."lesson_completion_completion_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for lessons_lesson_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."lessons_lesson_id_seq";
CREATE SEQUENCE "public"."lessons_lesson_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for online_attendance_attendance_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."online_attendance_attendance_id_seq";
CREATE SEQUENCE "public"."online_attendance_attendance_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for register_company_regcom_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."register_company_regcom_id_seq";
CREATE SEQUENCE "public"."register_company_regcom_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for student_registrations_registration_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."student_registrations_registration_id_seq";
CREATE SEQUENCE "public"."student_registrations_registration_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for students_student_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."students_student_id_seq";
CREATE SEQUENCE "public"."students_student_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for subjects_subject_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."subjects_subject_id_seq";
CREATE SEQUENCE "public"."subjects_subject_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for teachers_teacher_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."teachers_teacher_id_seq";
CREATE SEQUENCE "public"."teachers_teacher_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for users_roles_role_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_roles_role_id_seq";
CREATE SEQUENCE "public"."users_roles_role_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for users_user_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_user_id_seq";
CREATE SEQUENCE "public"."users_user_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for assignment_submissions
-- ----------------------------
DROP TABLE IF EXISTS "public"."assignment_submissions";
CREATE TABLE "public"."assignment_submissions" (
  "submission_id" int4 NOT NULL DEFAULT nextval('training_system_v5.assignment_submissions_submission_id_seq'::regclass),
  "assignment_id" int4 NOT NULL,
  "student_id" int4 NOT NULL,
  "submission_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "submission_text" text COLLATE "pg_catalog"."default",
  "file_name" varchar(255) COLLATE "pg_catalog"."default",
  "marks_obtained" numeric(5,2),
  "feedback" text COLLATE "pg_catalog"."default",
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Submitted'::character varying
)
;

-- ----------------------------
-- Records of assignment_submissions
-- ----------------------------
INSERT INTO "public"."assignment_submissions" VALUES (1, 1, 1, '2024-12-07 23:45:00', 'Completed HTML portfolio with all required sections.', 'dara_portfolio.html', 95.00, 'Excellent work! Well-structured HTML. Minor: Add more semantic tags.', 'Graded');
INSERT INTO "public"."assignment_submissions" VALUES (2, 2, 1, '2024-12-11 18:30:00', 'Added CSS styling with responsive design.', 'dara_portfolio.css', 88.00, 'Good styling! Improve color contrast for accessibility.', 'Graded');
INSERT INTO "public"."assignment_submissions" VALUES (3, 3, 1, '2024-12-19 22:00:00', 'Interactive quiz app with timer and score tracking.', 'dara_quiz_app.zip', NULL, NULL, 'Submitted');
INSERT INTO "public"."assignment_submissions" VALUES (4, 1, 2, '2024-12-08 15:20:00', 'Personal portfolio with clean HTML structure.', 'sreymom_portfolio.html', 92.00, 'Very good! Clean code and proper indentation.', 'Graded');
INSERT INTO "public"."assignment_submissions" VALUES (5, 2, 2, '2024-12-12 20:00:00', 'Portfolio with modern CSS styling and animations.', 'sreymom_portfolio.css', NULL, NULL, 'Submitted');
INSERT INTO "public"."assignment_submissions" VALUES (6, 5, 2, '2024-12-14 16:45:00', 'Completed all Python exercises in Jupyter notebook.', 'sreymom_python_exercises.ipynb', 98.00, 'Excellent! Perfect solutions with clear comments.', 'Graded');
INSERT INTO "public"."assignment_submissions" VALUES (7, 1, 3, '2024-12-06 20:00:00', 'Advanced HTML portfolio with extra features.', 'kosal_portfolio.html', 100.00, 'Perfect! Exceeded expectations with semantic HTML and accessibility.', 'Graded');
INSERT INTO "public"."assignment_submissions" VALUES (8, 2, 3, '2024-12-10 19:30:00', 'Professional CSS styling with animations and transitions.', 'kosal_portfolio.css', 100.00, 'Outstanding! Professional-level design and code quality.', 'Graded');
INSERT INTO "public"."assignment_submissions" VALUES (9, 3, 3, '2024-12-18 21:00:00', 'Advanced quiz app with multiple question types and statistics.', 'kosal_quiz_master.zip', 150.00, 'Exceptional! Added extra features beyond requirements.', 'Graded');
INSERT INTO "public"."assignment_submissions" VALUES (10, 5, 3, '2024-12-15 18:00:00', 'Python exercises with additional challenges completed.', 'kosal_python_mastery.ipynb', 100.00, 'Perfect! Went beyond requirements with optimization.', 'Graded');

-- ----------------------------
-- Table structure for assignments
-- ----------------------------
DROP TABLE IF EXISTS "public"."assignments";
CREATE TABLE "public"."assignments" (
  "assignment_id" int4 NOT NULL DEFAULT nextval('training_system_v5.assignments_assignment_id_seq'::regclass),
  "course_id" int4 NOT NULL,
  "title" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "due_date" date NOT NULL,
  "total_marks" numeric(5,2) NOT NULL,
  "created_by" int4,
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Active'::character varying
)
;

-- ----------------------------
-- Records of assignments
-- ----------------------------
INSERT INTO "public"."assignments" VALUES (2, 1, 'CSS Styling Challenge', 'Style the portfolio you created with CSS. Use flexbox for layout, add colors, fonts, and make it responsive.', '2024-12-12', 100.00, 1, 'Active');
INSERT INTO "public"."assignments" VALUES (3, 1, 'JavaScript Quiz App', 'Build an interactive quiz application using HTML, CSS, and JavaScript. Must have questions, score tracking, and timer.', '2024-12-20', 150.00, 1, 'Active');
INSERT INTO "public"."assignments" VALUES (4, 1, 'Final Website Project', 'Create a complete multi-page website for a fictional business. Must be responsive and interactive.', '2025-01-25', 200.00, 1, 'Active');
INSERT INTO "public"."assignments" VALUES (5, 4, 'Python Basics Exercise', 'Complete exercises on variables, loops, and functions. Submit Jupyter notebook.', '2024-12-15', 100.00, 2, 'Active');
INSERT INTO "public"."assignments" VALUES (6, 4, 'Pandas Data Analysis', 'Analyze the provided dataset using Pandas. Clean data, calculate statistics, create summary report.', '2024-12-22', 150.00, 2, 'Active');
INSERT INTO "public"."assignments" VALUES (7, 4, 'Data Visualization Project', 'Create 5 different visualizations from a dataset. Use Matplotlib and Seaborn.', '2025-01-05', 150.00, 2, 'Active');
INSERT INTO "public"."assignments" VALUES (1, 1, 'HTML Personal Portfolio', 'Create a personal portfolio webpage using only HTML. Must include: header, about section, skills list, and contact information.', '2024-12-08', 100.00, 1, 'Active');
INSERT INTO "public"."assignments" VALUES (8, 7, 'Python basic assignement', NULL, '2026-03-25', 20.00, 9, 'Active');
INSERT INTO "public"."assignments" VALUES (9, 3, 'Database Normalize', NULL, '2026-03-27', 20.00, 8, 'Active');

-- ----------------------------
-- Table structure for course_reviews
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_reviews";
CREATE TABLE "public"."course_reviews" (
  "review_id" int4 NOT NULL DEFAULT nextval('training_system_v5.course_reviews_review_id_seq'::regclass),
  "course_id" int4 NOT NULL,
  "student_id" int4 NOT NULL,
  "rating" int4,
  "review_text" text COLLATE "pg_catalog"."default",
  "review_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of course_reviews
-- ----------------------------

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS "public"."courses";
CREATE TABLE "public"."courses" (
  "course_id" int4 NOT NULL DEFAULT nextval('training_system_v5.courses_course_id_seq'::regclass),
  "regcom_id" int4 NOT NULL,
  "course_code" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "course_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "course_description" text COLLATE "pg_catalog"."default",
  "course_image" bytea,
  "teacher_id" int4,
  "duration_hours" int4 NOT NULL,
  "start_date" date,
  "end_date" date,
  "meeting_link" varchar(500) COLLATE "pg_catalog"."default",
  "max_students" int4 DEFAULT 30,
  "course_fee" numeric(10,2),
  "skill_level" varchar(20) COLLATE "pg_catalog"."default",
  "is_self_enrollment_allowed" bool DEFAULT true,
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Active'::character varying
)
;

-- ----------------------------
-- Records of courses
-- ----------------------------
INSERT INTO "public"."courses" VALUES (1, 1, 'WEB101', 'Web Development Fundamentals', 'Learn HTML, CSS, JavaScript basics. Build responsive websites from scratch.', NULL, 1, 40, '2024-12-01', '2025-02-01', 'https://meet.google.com/web-101', 30, 500.00, 'Beginner', 't', 'Active');
INSERT INTO "public"."courses" VALUES (2, 1, 'WEB201', 'Advanced JavaScript & React', 'Master JavaScript ES6+, React framework, and modern web development.', NULL, 1, 50, '2025-01-15', '2025-03-15', 'https://meet.google.com/web-201', 25, 750.00, 'Intermediate', 't', 'Active');
INSERT INTO "public"."courses" VALUES (3, 1, 'WEB301', 'Full-Stack Web Development', 'Build complete web applications with Node.js, Express, MongoDB, and React.', NULL, 1, 60, '2025-02-01', '2025-04-30', 'https://meet.google.com/web-301', 20, 950.00, 'Advanced', 't', 'Active');
INSERT INTO "public"."courses" VALUES (4, 1, 'DATA101', 'Introduction to Data Science', 'Python programming, data analysis with Pandas, data visualization basics.', NULL, 2, 45, '2024-12-10', '2025-02-20', 'https://meet.google.com/data-101', 30, 600.00, 'Beginner', 't', 'Active');
INSERT INTO "public"."courses" VALUES (5, 1, 'DATA201', 'Machine Learning Fundamentals', 'Supervised learning, classification, regression, and model evaluation.', NULL, 2, 55, '2025-01-20', '2025-03-30', 'https://meet.google.com/data-201', 25, 850.00, 'Intermediate', 't', 'Active');
INSERT INTO "public"."courses" VALUES (6, 1, 'DATA301', 'Deep Learning & Neural Networks', 'Advanced machine learning, neural networks, TensorFlow, and Keras.', NULL, 2, 60, '2025-02-15', '2025-05-15', 'https://meet.google.com/data-301', 20, 1200.00, 'Advanced', 't', 'Active');
INSERT INTO "public"."courses" VALUES (7, 1, 'PROG101', 'Python Programming Basics', 'Learn Python from scratch. Variables, functions, OOP, and file handling.', NULL, 1, 35, '2024-12-05', '2025-01-25', 'https://meet.google.com/prog-101', 30, 450.00, 'Beginner', 't', 'Active');
INSERT INTO "public"."courses" VALUES (8, 1, 'PROG201', 'Java Programming', 'Object-oriented programming with Java. Build desktop applications.', NULL, 1, 50, '2025-01-10', '2025-03-20', 'https://meet.google.com/prog-201', 25, 700.00, 'Intermediate', 't', 'Active');

-- ----------------------------
-- Table structure for enrollments
-- ----------------------------
DROP TABLE IF EXISTS "public"."enrollments";
CREATE TABLE "public"."enrollments" (
  "enrollment_id" int4 NOT NULL DEFAULT nextval('training_system_v5.enrollments_enrollment_id_seq'::regclass),
  "student_id" int4 NOT NULL,
  "course_id" int4 NOT NULL,
  "enrollment_date" date DEFAULT CURRENT_DATE,
  "payment_status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Pending'::character varying,
  "payment_amount" numeric(10,2),
  "completion_status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Ongoing'::character varying,
  "progress_percentage" numeric(5,2) DEFAULT 0.00,
  "final_grade" varchar(2) COLLATE "pg_catalog"."default",
  "certificate_issued" bool,
  "certificate_number" varchar(50) COLLATE "pg_catalog"."default",
  "last_accessed" timestamp(6)
)
;

-- ----------------------------
-- Records of enrollments
-- ----------------------------
INSERT INTO "public"."enrollments" VALUES (1, 1, 1, '2024-12-01', 'Paid', 500.00, 'Ongoing', 65.50, NULL, 'f', NULL, '2024-12-05 14:30:00');
INSERT INTO "public"."enrollments" VALUES (2, 1, 7, '2024-12-05', 'Paid', 450.00, 'Ongoing', 35.00, NULL, 'f', NULL, '2024-12-05 16:45:00');
INSERT INTO "public"."enrollments" VALUES (3, 2, 1, '2024-12-01', 'Paid', 500.00, 'Ongoing', 45.00, NULL, 'f', NULL, '2024-12-04 10:15:00');
INSERT INTO "public"."enrollments" VALUES (4, 2, 4, '2024-12-10', 'Paid', 600.00, 'Ongoing', 25.00, NULL, 'f', NULL, '2024-12-05 09:30:00');
INSERT INTO "public"."enrollments" VALUES (5, 3, 1, '2024-12-01', 'Paid', 500.00, 'Completed', 100.00, 'A', 't', 'CERT-WEB101-2024-001', '2024-12-20 18:00:00');
INSERT INTO "public"."enrollments" VALUES (6, 3, 4, '2024-12-15', 'Paid', 600.00, 'Ongoing', 55.00, NULL, 'f', NULL, '2024-12-05 20:00:00');
INSERT INTO "public"."enrollments" VALUES (7, 3, 7, '2024-12-15', 'Pending', 450.00, 'Not Started', 0.00, NULL, 'f', NULL, NULL);

-- ----------------------------
-- Table structure for exam_questions
-- ----------------------------
DROP TABLE IF EXISTS "public"."exam_questions";
CREATE TABLE "public"."exam_questions" (
  "question_id" int4 NOT NULL DEFAULT nextval('training_system_v5.exam_questions_question_id_seq'::regclass),
  "exam_id" int4 NOT NULL,
  "question_number" int4 NOT NULL,
  "question_text" text COLLATE "pg_catalog"."default" NOT NULL,
  "question_type" varchar(20) COLLATE "pg_catalog"."default",
  "option_a" varchar(500) COLLATE "pg_catalog"."default",
  "option_b" varchar(500) COLLATE "pg_catalog"."default",
  "option_c" varchar(500) COLLATE "pg_catalog"."default",
  "option_d" varchar(500) COLLATE "pg_catalog"."default",
  "correct_answer" varchar(500) COLLATE "pg_catalog"."default",
  "marks" numeric(5,2) NOT NULL
)
;

-- ----------------------------
-- Records of exam_questions
-- ----------------------------

-- ----------------------------
-- Table structure for exam_results
-- ----------------------------
DROP TABLE IF EXISTS "public"."exam_results";
CREATE TABLE "public"."exam_results" (
  "result_id" int4 NOT NULL DEFAULT nextval('training_system_v5.exam_results_result_id_seq'::regclass),
  "exam_id" int4 NOT NULL,
  "student_id" int4 NOT NULL,
  "exam_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "marks_obtained" numeric(5,2),
  "percentage" numeric(5,2),
  "grade" varchar(5) COLLATE "pg_catalog"."default",
  "passed" bool
)
;

-- ----------------------------
-- Records of exam_results
-- ----------------------------

-- ----------------------------
-- Table structure for exams
-- ----------------------------
DROP TABLE IF EXISTS "public"."exams";
CREATE TABLE "public"."exams" (
  "exam_id" int4 NOT NULL DEFAULT nextval('training_system_v5.exams_exam_id_seq'::regclass),
  "course_id" int4 NOT NULL,
  "exam_type" varchar(20) COLLATE "pg_catalog"."default",
  "exam_title" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "exam_description" text COLLATE "pg_catalog"."default",
  "total_marks" numeric(5,2) NOT NULL,
  "passing_marks" numeric(5,2) NOT NULL,
  "exam_date" date,
  "duration_minutes" int4,
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Scheduled'::character varying
)
;

-- ----------------------------
-- Records of exams
-- ----------------------------

-- ----------------------------
-- Table structure for lesson_completion
-- ----------------------------
DROP TABLE IF EXISTS "public"."lesson_completion";
CREATE TABLE "public"."lesson_completion" (
  "completion_id" int4 NOT NULL DEFAULT nextval('training_system_v5.lesson_completion_completion_id_seq'::regclass),
  "lesson_id" int4 NOT NULL,
  "student_id" int4 NOT NULL,
  "started_date" timestamp(6),
  "completed_date" timestamp(6),
  "time_spent_minutes" int4 DEFAULT 0,
  "is_completed" bool DEFAULT false,
  "score" numeric(5,2)
)
;

-- ----------------------------
-- Records of lesson_completion
-- ----------------------------

-- ----------------------------
-- Table structure for lessons
-- ----------------------------
DROP TABLE IF EXISTS "public"."lessons";
CREATE TABLE "public"."lessons" (
  "lesson_id" int4 NOT NULL DEFAULT nextval('training_system_v5.lessons_lesson_id_seq'::regclass),
  "subject_id" int4 NOT NULL,
  "course_id" int4 NOT NULL,
  "lesson_number" int4 NOT NULL,
  "lesson_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "lesson_title" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "lesson_description" text COLLATE "pg_catalog"."default",
  "lesson_content" text COLLATE "pg_catalog"."default",
  "video_url" varchar(500) COLLATE "pg_catalog"."default",
  "duration_minutes" int4 DEFAULT 60,
  "lesson_order" int4 NOT NULL,
  "lesson_type" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Video'::character varying,
  "is_preview" bool DEFAULT false,
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Active'::character varying
)
;

-- ----------------------------
-- Records of lessons
-- ----------------------------
INSERT INTO "public"."lessons" VALUES (13, 7, 4, 1, 'Introduction to Python', 'Introduction to Python', 'Python setup, variables, data types, and basic operations.', '<h2>Getting Started with Python</h2><p>Learn Python basics.</p>', 'https://youtube.com/watch?v=data101-lesson1', 60, 1, 'Video', 'f', 'Active');
INSERT INTO "public"."lessons" VALUES (18, 8, 4, 2, 'Working with Pandas', 'Working with Pandas', 'DataFrames, reading CSV files, data cleaning basics.', '<h2>Data Analysis with Pandas</h2><p>Master data manipulation.</p>', 'https://youtube.com/watch?v=data101-lesson2', 75, 2, 'Video', 'f', 'Active');
INSERT INTO "public"."lessons" VALUES (19, 9, 4, 3, 'Data Visualization', 'Data Visualization', 'Creating charts with Matplotlib and Seaborn.', '<h2>Visualize Your Data</h2><p>Create compelling visualizations.</p>', 'https://youtube.com/watch?v=data101-lesson3', 60, 3, 'Video', 'f', 'Active');
INSERT INTO "public"."lessons" VALUES (20, 9, 4, 4, 'Statistics for Data Science', 'Statistics for Data Science', 'Descriptive statistics, probability, and hypothesis testing.', '<h2>Statistical Analysis</h2><p>Understand data patterns.</p>', 'https://youtube.com/watch?v=data101-lesson4', 90, 4, 'Video', 'f', 'Active');
INSERT INTO "public"."lessons" VALUES (22, 9, 4, 5, 'Data Science Project', 'Data Science Project', 'Complete data analysis project from data collection to insights.', '<h2>Real-World Data Analysis</h2><p>Apply your skills.</p>', 'https://youtube.com/watch?v=data101-lesson5', 120, 5, 'Video', 'f', 'Active');

-- ----------------------------
-- Table structure for online_attendance
-- ----------------------------
DROP TABLE IF EXISTS "public"."online_attendance";
CREATE TABLE "public"."online_attendance" (
  "attendance_id" int4 NOT NULL DEFAULT nextval('training_system_v5.online_attendance_attendance_id_seq'::regclass),
  "student_id" int4,
  "teacher_id" int4,
  "course_id" int4 NOT NULL,
  "lesson_id" int4,
  "attendance_date" date NOT NULL,
  "attendance_type" varchar(10) COLLATE "pg_catalog"."default",
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Present'::character varying,
  "duration_minutes" int4,
  "remarks" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON TABLE "public"."online_attendance" IS 'Simple attendance tracking - Present/Absent for online sessions';

-- ----------------------------
-- Records of online_attendance
-- ----------------------------
INSERT INTO "public"."online_attendance" VALUES (30, NULL, 2, 4, 13, '2024-12-01', 'Teacher', 'Present', 60, 'Taught Introduction to Python');
INSERT INTO "public"."online_attendance" VALUES (31, 1, NULL, 4, 13, '2024-12-01', 'Student', 'Present', 60, 'Attended intro');
INSERT INTO "public"."online_attendance" VALUES (32, 2, NULL, 4, 13, '2024-12-01', 'Student', 'Present', 60, 'Attended intro');
INSERT INTO "public"."online_attendance" VALUES (33, 3, NULL, 4, 13, '2024-12-01', 'Student', 'Absent', 0, 'Sick');
INSERT INTO "public"."online_attendance" VALUES (34, NULL, 2, 4, 18, '2024-12-02', 'Teacher', 'Present', 75, 'Taught Working with Pandas');
INSERT INTO "public"."online_attendance" VALUES (35, 1, NULL, 4, 18, '2024-12-02', 'Student', 'Present', 75, 'Completed examples');
INSERT INTO "public"."online_attendance" VALUES (36, 2, NULL, 4, 18, '2024-12-02', 'Student', 'Present', 75, 'Good questions');
INSERT INTO "public"."online_attendance" VALUES (37, 3, NULL, 4, 18, '2024-12-02', 'Student', 'Present', 75, 'Participated well');
INSERT INTO "public"."online_attendance" VALUES (38, NULL, 2, 4, 19, '2024-12-03', 'Teacher', 'Present', 60, 'Taught Data Visualization');
INSERT INTO "public"."online_attendance" VALUES (39, 1, NULL, 4, 19, '2024-12-03', 'Student', 'Present', 60, 'Practiced charts');
INSERT INTO "public"."online_attendance" VALUES (40, 2, NULL, 4, 19, '2024-12-03', 'Student', 'Present', 50, 'Late 10 mins');
INSERT INTO "public"."online_attendance" VALUES (41, 3, NULL, 4, 19, '2024-12-03', 'Student', 'Present', 60, 'Excellent work');
INSERT INTO "public"."online_attendance" VALUES (42, NULL, 2, 4, 20, '2024-12-04', 'Teacher', 'Present', 90, 'Taught Statistics for Data');
INSERT INTO "public"."online_attendance" VALUES (43, 1, NULL, 4, 20, '2024-12-04', 'Student', 'Present', 90, 'Good questions');
INSERT INTO "public"."online_attendance" VALUES (44, 2, NULL, 4, 20, '2024-12-04', 'Student', 'Present', 90, 'Active');
INSERT INTO "public"."online_attendance" VALUES (45, 3, NULL, 4, 20, '2024-12-04', 'Student', 'Present', 90, 'Strong participation');
INSERT INTO "public"."online_attendance" VALUES (46, NULL, 2, 4, 22, '2024-12-05', 'Teacher', 'Present', 120, 'Taught Data Science Project');
INSERT INTO "public"."online_attendance" VALUES (47, 1, NULL, 4, 22, '2024-12-05', 'Student', 'Present', 120, 'Project kickoff');
INSERT INTO "public"."online_attendance" VALUES (48, 2, NULL, 4, 22, '2024-12-05', 'Student', 'Present', 120, 'Project kickoff');
INSERT INTO "public"."online_attendance" VALUES (49, 3, NULL, 4, 22, '2024-12-05', 'Student', 'Present', 120, 'Project kickoff');

-- ----------------------------
-- Table structure for register_company
-- ----------------------------
DROP TABLE IF EXISTS "public"."register_company";
CREATE TABLE "public"."register_company" (
  "regcom_id" int4 NOT NULL DEFAULT nextval('training_system_v5.register_company_regcom_id_seq'::regclass),
  "regcom_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "regcom_email" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "regcom_phone" varchar(20) COLLATE "pg_catalog"."default",
  "website" varchar(255) COLLATE "pg_catalog"."default",
  "logo" bytea,
  "admin_user" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "admin_password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "status" varchar(3) COLLATE "pg_catalog"."default" DEFAULT 'yes'::character varying,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "regcom_address" text COLLATE "pg_catalog"."default",
  "approved_by" int4,
  "approved_at" timestamp(6)
)
;
COMMENT ON COLUMN "public"."register_company"."regcom_address" IS 'Company physical address';
COMMENT ON COLUMN "public"."register_company"."approved_by" IS 'Super admin who approved the company';
COMMENT ON COLUMN "public"."register_company"."approved_at" IS 'Timestamp when company was approved';

-- ----------------------------
-- Records of register_company
-- ----------------------------
INSERT INTO "public"."register_company" VALUES (1, 'ABC Tech Institute', 'admin@abctech.edu.kh', '023-123-456', 'https://abctech.edu.kh', NULL, 'admin_abc', '0192023a7bbd73250516f069df18b500', 'yes', '2025-12-06 09:20:48.953803', '#123, Street 456, Phnom Penh, Cambodia', 1, '2025-12-06 09:20:48.953803');
INSERT INTO "public"."register_company" VALUES (2, 'Digital Skills Academy', 'info@digitalskills.com.kh', '023-789-012', 'https://digitalskills.com.kh', NULL, 'admin_dsa', '0192023a7bbd73250516f069df18b500', 'no', '2025-12-06 09:20:48.95655', '#789, Street 012, Phnom Penh, Cambodia', NULL, NULL);
INSERT INTO "public"."register_company" VALUES (3, 'Setec Institute', 'setec@setec.com', '+855087587302', NULL, NULL, 'admin_setec', '0192023a7bbd73250516f069df18b500', 'no', '2025-12-06 09:33:39.395251', 'Toul Kork', NULL, NULL);
INSERT INTO "public"."register_company" VALUES (4, 'IDK', 'idk@idk.edu', '12345678', NULL, NULL, 'admin_idk', '0192023a7bbd73250516f069df18b500', 'yes', '2025-12-06 10:31:22.694044', 'Toul Kork', 1, '2025-12-06 10:34:14.886171');

-- ----------------------------
-- Table structure for student_registrations
-- ----------------------------
DROP TABLE IF EXISTS "public"."student_registrations";
CREATE TABLE "public"."student_registrations" (
  "registration_id" int4 NOT NULL DEFAULT nextval('training_system_v5.student_registrations_registration_id_seq'::regclass),
  "regcom_id" int4 NOT NULL,
  "first_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "last_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "gender" varchar(10) COLLATE "pg_catalog"."default",
  "date_of_birth" date,
  "phone" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "address" text COLLATE "pg_catalog"."default",
  "emergency_contact" varchar(255) COLLATE "pg_catalog"."default",
  "registration_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "approval_status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Pending'::character varying,
  "approved_by" int4,
  "approval_date" timestamp(6),
  "notes" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of student_registrations
-- ----------------------------

-- ----------------------------
-- Table structure for students
-- ----------------------------
DROP TABLE IF EXISTS "public"."students";
CREATE TABLE "public"."students" (
  "student_id" int4 NOT NULL DEFAULT nextval('training_system_v5.students_student_id_seq'::regclass),
  "regcom_id" int4 NOT NULL,
  "user_id" int4,
  "student_code" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "first_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "last_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "gender" varchar(10) COLLATE "pg_catalog"."default",
  "date_of_birth" date,
  "phone" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "address" text COLLATE "pg_catalog"."default",
  "photo" bytea,
  "emergency_contact" varchar(255) COLLATE "pg_catalog"."default",
  "registration_date" date DEFAULT CURRENT_DATE,
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Active'::character varying
)
;

-- ----------------------------
-- Records of students
-- ----------------------------
INSERT INTO "public"."students" VALUES (1, 1, 5, 'STU00001', 'Dara', 'Sok', 'M', '2000-05-15', '098-765-432', 'dara.sok@gmail.com', '#789, Street 012, Phnom Penh', NULL, 'Mother: 098-111-222', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (2, 1, 6, 'STU00002', 'Sreymom', 'Heng', 'F', '2001-08-22', '098-234-567', 'sreymom.heng@gmail.com', '#456, Street 789, Phnom Penh', NULL, 'Father: 098-333-444', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (3, 1, 7, 'STU00003', 'Kosal', 'Prak', 'M', '1999-12-10', '098-345-678', 'kosal.prak@gmail.com', '#123, Street 456, Phnom Penh', NULL, 'Sister: 098-555-666', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (11, 1, 11, 'STU00011', 'Chantha', 'Sim', 'M', '2000-07-30', '087-321-654', 'chantha.sim@gmail.com', '#71, Street 182, Phnom Penh', NULL, 'Mother: 096-852-741', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (12, 1, 12, 'STU00012', 'Sreymao', 'Heng', 'F', '2002-01-14', '086-753-159', 'sreymao.heng@gmail.com', '#19, Street 598, Phnom Penh', NULL, 'Father: 095-963-852', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (13, 1, 13, 'STU00013', 'Borey', 'Kim', 'M', '2001-05-23', '085-951-357', 'borey.kim@gmail.com', '#65, Street 278, Phnom Penh', NULL, 'Mother: 097-258-369', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (14, 1, 14, 'STU00014', 'Rany', 'Chan', 'F', '2000-10-09', '084-753-951', 'rany.chan@gmail.com', '#11, Street 63, Phnom Penh', NULL, 'Father: 096-654-321', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (15, 1, 15, 'STU00015', 'Sokun', 'Ly', 'M', '1999-03-27', '083-357-951', 'sokun.ly@gmail.com', '#73, Street 510, Phnom Penh', NULL, 'Mother: 095-753-159', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (16, 1, 16, 'STU00016', 'Linda', 'Chum', 'F', '2002-08-05', '082-159-357', 'linda.chum@gmail.com', '#91, Street 199, Phnom Penh', NULL, 'Father: 097-852-741', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (17, 1, 17, 'STU00017', 'Rith', 'Kao', 'M', '2001-06-11', '081-951-753', 'rith.kao@gmail.com', '#13, Street 278, Phnom Penh', NULL, 'Mother: 096-147-258', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (18, 1, 18, 'STU00018', 'Sreyly', 'Touch', 'F', '2000-02-22', '080-369-258', 'sreyly.touch@gmail.com', '#59, Street 488, Phnom Penh', NULL, 'Father: 095-456-789', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (19, 1, 19, 'STU00019', 'Vichea', 'Noun', 'M', '2001-09-16', '079-753-456', 'vichea.noun@gmail.com', '#26, Street 144, Phnom Penh', NULL, 'Mother: 096-963-147', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (20, 1, 20, 'STU00020', 'Sophea', 'Lay', 'F', '2002-04-28', '078-951-852', 'sophea.lay@gmail.com', '#84, Street 221, Phnom Penh', NULL, 'Father: 097-741-852', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (21, 1, 21, 'STU00021', 'Ratha', 'Sok', 'M', '2001-07-12', '077-111-222', 'ratha.sok@gmail.com', '#24, Street 200, Phnom Penh', NULL, 'Father: 098-222-111', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (22, 1, 22, 'STU00022', 'Sreyneang', 'Ly', 'F', '2000-03-18', '077-333-444', 'sreyneang.ly@gmail.com', '#17, Street 432, Phnom Penh', NULL, 'Mother: 097-321-456', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (23, 1, 23, 'STU00023', 'Piseth', 'Chan', 'M', '1999-10-10', '076-222-555', 'piseth.chan@gmail.com', '#66, Street 12, Phnom Penh', NULL, 'Father: 098-555-444', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (24, 1, 24, 'STU00024', 'Malis', 'Kim', 'F', '2002-02-20', '076-444-333', 'malis.kim@gmail.com', '#92, Street 101, Phnom Penh', NULL, 'Mother: 096-444-222', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (25, 1, 25, 'STU00025', 'Vichea', 'Lim', 'M', '2001-11-01', '076-555-666', 'vichea.lim@gmail.com', '#12, Street 305, Phnom Penh', NULL, 'Father: 095-777-111', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (26, 1, 26, 'STU00026', 'Linda', 'Heng', 'F', '2000-06-15', '075-111-999', 'linda.heng@gmail.com', '#47, Street 220, Phnom Penh', NULL, 'Mother: 096-741-852', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (27, 1, 27, 'STU00027', 'Borey', 'Phan', 'M', '1999-08-25', '075-222-333', 'borey.phan@gmail.com', '#56, Street 598, Phnom Penh', NULL, 'Father: 097-369-258', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (28, 1, 28, 'STU00028', 'Sreymao', 'Kong', 'F', '2002-12-05', '075-444-111', 'sreymao.kong@gmail.com', '#11, Street 145, Phnom Penh', NULL, 'Mother: 095-123-987', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (29, 1, 29, 'STU00029', 'Chantha', 'Lay', 'M', '2001-04-07', '074-555-777', 'chantha.lay@gmail.com', '#36, Street 371, Phnom Penh', NULL, 'Father: 096-789-456', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (30, 1, 30, 'STU00030', 'Nita', 'Srey', 'F', '2000-01-30', '074-666-888', 'nita.srey@gmail.com', '#44, Street 182, Phnom Penh', NULL, 'Mother: 095-741-963', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (31, 1, 31, 'STU00031', 'Rith', 'Huot', 'M', '2001-02-11', '073-111-555', 'rith.huot@gmail.com', '#67, Street 63, Phnom Penh', NULL, 'Father: 097-456-258', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (32, 1, 32, 'STU00032', 'Sophea', 'Touch', 'F', '2000-09-14', '073-333-777', 'sophea.touch@gmail.com', '#18, Street 217, Phnom Penh', NULL, 'Mother: 096-258-369', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (33, 1, 33, 'STU00033', 'Sokun', 'Kao', 'M', '2002-05-09', '073-444-888', 'sokun.kao@gmail.com', '#55, Street 144, Phnom Penh', NULL, 'Father: 095-951-753', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (34, 1, 34, 'STU00034', 'Rany', 'Chea', 'F', '1999-12-21', '072-222-111', 'rany.chea@gmail.com', '#23, Street 199, Phnom Penh', NULL, 'Mother: 096-852-147', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (35, 1, 35, 'STU00035', 'Pisey', 'Sim', 'F', '2001-03-03', '072-555-444', 'pisey.sim@gmail.com', '#74, Street 305, Phnom Penh', NULL, 'Father: 097-753-456', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (36, 1, 36, 'STU00036', 'Vannak', 'Noun', 'M', '2000-07-17', '071-111-333', 'vannak.noun@gmail.com', '#14, Street 488, Phnom Penh', NULL, 'Mother: 095-963-852', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (37, 1, 37, 'STU00037', 'Mony', 'Ly', 'M', '2002-10-10', '071-444-222', 'mony.ly@gmail.com', '#62, Street 221, Phnom Penh', NULL, 'Father: 096-321-987', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (38, 1, 38, 'STU00038', 'Sreypov', 'Heng', 'F', '2001-01-05', '071-555-666', 'sreypov.heng@gmail.com', '#27, Street 371, Phnom Penh', NULL, 'Mother: 095-789-456', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (39, 1, 39, 'STU00039', 'Kosal', 'Chan', 'M', '1999-04-16', '070-111-777', 'kosal.chan@gmail.com', '#93, Street 60, Phnom Penh', NULL, 'Father: 097-654-321', '2025-12-06', 'Active');
INSERT INTO "public"."students" VALUES (40, 1, 40, 'STU00040', 'Sreyka', 'Kim', 'F', '2002-06-26', '070-333-555', 'sreyka.kim@gmail.com', '#35, Street 12, Phnom Penh', NULL, 'Mother: 096-753-159', '2025-12-06', 'Active');

-- ----------------------------
-- Table structure for subjects
-- ----------------------------
DROP TABLE IF EXISTS "public"."subjects";
CREATE TABLE "public"."subjects" (
  "subject_id" int4 NOT NULL DEFAULT nextval('training_system_v5.subjects_subject_id_seq'::regclass),
  "course_id" int4 NOT NULL,
  "subject_code" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "subject_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "subject_description" text COLLATE "pg_catalog"."default",
  "duration_hours" int4 DEFAULT 0,
  "subject_order" int4 NOT NULL,
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Active'::character varying
)
;

-- ----------------------------
-- Records of subjects
-- ----------------------------
INSERT INTO "public"."subjects" VALUES (1, 1, 'HTML', 'HTML Fundamentals', 'Learn HTML5 and semantic markup', 12, 1, 'Active');
INSERT INTO "public"."subjects" VALUES (2, 1, 'CSS', 'CSS Styling', 'Master CSS3, Flexbox, and Grid', 12, 2, 'Active');
INSERT INTO "public"."subjects" VALUES (3, 1, 'JS', 'JavaScript Basics', 'JavaScript programming fundamentals', 16, 3, 'Active');
INSERT INTO "public"."subjects" VALUES (4, 2, 'ES6', 'Modern JavaScript ES6+', 'Arrow functions, destructuring, async/await', 15, 1, 'Active');
INSERT INTO "public"."subjects" VALUES (5, 2, 'REACT', 'React Framework', 'Components, hooks, state management', 20, 2, 'Active');
INSERT INTO "public"."subjects" VALUES (6, 2, 'REDUX', 'State Management', 'Redux for complex state management', 15, 3, 'Active');
INSERT INTO "public"."subjects" VALUES (7, 4, 'PY', 'Python Programming', 'Python basics for data science', 15, 1, 'Active');
INSERT INTO "public"."subjects" VALUES (8, 4, 'PANDAS', 'Data Analysis with Pandas', 'DataFrames and data manipulation', 15, 2, 'Active');
INSERT INTO "public"."subjects" VALUES (9, 4, 'VIZ', 'Data Visualization', 'Matplotlib and Seaborn charts', 15, 3, 'Active');
INSERT INTO "public"."subjects" VALUES (10, 7, 'PY-BASIC', 'Python Basics', 'Variables, data types, control flow', 12, 1, 'Active');
INSERT INTO "public"."subjects" VALUES (11, 7, 'PY-FUNC', 'Functions & Modules', 'Creating reusable code', 10, 2, 'Active');
INSERT INTO "public"."subjects" VALUES (12, 7, 'PY-OOP', 'Object-Oriented Programming', 'Classes and objects in Python', 13, 3, 'Active');

-- ----------------------------
-- Table structure for teachers
-- ----------------------------
DROP TABLE IF EXISTS "public"."teachers";
CREATE TABLE "public"."teachers" (
  "teacher_id" int4 NOT NULL DEFAULT nextval('training_system_v5.teachers_teacher_id_seq'::regclass),
  "regcom_id" int4 NOT NULL,
  "user_id" int4,
  "teacher_code" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "first_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "last_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "gender" varchar(10) COLLATE "pg_catalog"."default",
  "phone" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "bio" text COLLATE "pg_catalog"."default",
  "photo" bytea,
  "qualification" varchar(100) COLLATE "pg_catalog"."default",
  "specialization" varchar(100) COLLATE "pg_catalog"."default",
  "experience_years" int4 DEFAULT 0,
  "hourly_rate" numeric(10,2),
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Active'::character varying
)
;

-- ----------------------------
-- Records of teachers
-- ----------------------------
INSERT INTO "public"."teachers" VALUES (1, 1, 3, 'TCH001', 'Sokha', 'Chea', 'Male', '012-345-678', 'sokha.chea@abctech.edu.kh', NULL, NULL, 'B.Sc Computer Science', 'Web Development', 0, NULL, 'Active');
INSERT INTO "public"."teachers" VALUES (2, 1, 4, 'TCH002', 'Pisey', 'Lim', 'Female', '012-678-901', 'pisey.lim@abctech.edu.kh', NULL, NULL, 'M.Sc Data Analytics', 'Data Science', 0, NULL, 'Active');
INSERT INTO "public"."teachers" VALUES (7, 1, 42, 'TCH042', 'YU', 'Yunlong', 'Male', '097-111-012', 'Yunlong@gmyesil.com', 'Specialist in literature', NULL, 'Master of Arts', 'Quality and control ', 8, 18.00, 'Active');
INSERT INTO "public"."teachers" VALUES (10, 1, 45, 'TCH045', 'Heak', 'Thavuth', 'Male', '097-111-015', 'Thavuth@gmyesil.com', 'Computer science and programming expert', NULL, 'Master of Computer Science', 'Java', 9, 20.00, 'Active');
INSERT INTO "public"."teachers" VALUES (6, 1, 41, 'TCH041', 'Khov', 'Sok', 'Male', '097-111-011', 'khovsok@gmyesil.com', 'Expert in Linux', NULL, 'Bachelor of Education', 'Linux ', 10, 15.50, 'Active');
INSERT INTO "public"."teachers" VALUES (8, 1, 43, 'TCH043', 'Pan', 'Phanong', 'Male', '097-111-013', 'Phanong@gmyesil.com', 'Database researcher and teacher', NULL, 'PhD in Physics', 'Database ', 12, 25.00, 'Active');
INSERT INTO "public"."teachers" VALUES (9, 1, 44, 'TCH044', 'Ngim', 'Rady', 'Male', '097-111-014', 'Rady@gmyesil.com', 'Computer science', NULL, 'Bachelor of Science', 'Python', 6, 14.75, 'Active');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
  "user_id" int4 NOT NULL DEFAULT nextval('training_system_v5.users_user_id_seq'::regclass),
  "regcom_id" int4,
  "user_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "upassword" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "phone" varchar(20) COLLATE "pg_catalog"."default",
  "user_type" varchar(20) COLLATE "pg_catalog"."default",
  "status" varchar(3) COLLATE "pg_catalog"."default" DEFAULT 'yes'::character varying,
  "last_login" timestamp(6),
  "created_date" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."users"."regcom_id" IS 'Company ID. NULL for super_admin, NOT NULL for admin/teacher/student';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO "public"."users" VALUES (3, 2, 'admin_dsa', '0192023a7bbd73250516f069df18b500', 'info@digitalskills.com.kh', '023-789-012', 'admin', 'no', NULL, '2025-12-06 09:20:48.957051');
INSERT INTO "public"."users" VALUES (4, 1, 'sokha_teacher', 'a426dcf72ba25d046591f81a5495eab7', 'sokha.chea@abctech.edu.kh', '012-345-678', 'teacher', 'yes', NULL, '2025-12-06 09:20:48.957634');
INSERT INTO "public"."users" VALUES (5, 1, 'pisey_teacher', 'a426dcf72ba25d046591f81a5495eab7', 'pisey.lim@abctech.edu.kh', '012-678-901', 'teacher', 'yes', NULL, '2025-12-06 09:20:48.960628');
INSERT INTO "public"."users" VALUES (7, 1, 'sreymom_student', 'ad6a280417a0f533d8b670c61667e1a0', 'sreymom.heng@gmail.com', '098-234-567', 'student', 'yes', NULL, '2025-12-06 09:20:48.965017');
INSERT INTO "public"."users" VALUES (8, 1, 'kosal_student', 'ad6a280417a0f533d8b670c61667e1a0', 'kosal.prak@gmail.com', '098-345-678', 'student', 'yes', NULL, '2025-12-06 09:20:48.967104');
INSERT INTO "public"."users" VALUES (2, 1, 'admin_abc', '0192023a7bbd73250516f069df18b500', 'admin@abctech.edu.kh', '023-123-456', 'admin', 'yes', '2025-12-06 09:21:41.905008', '2025-12-06 09:20:48.955288');
INSERT INTO "public"."users" VALUES (9, 3, 'admin_setec', '0192023a7bbd73250516f069df18b500', 'admin_setec@setec.com', '+855087587302', 'admin', 'no', NULL, '2025-12-06 09:33:39.395251');
INSERT INTO "public"."users" VALUES (1, NULL, 'superadmin', '0192023a7bbd73250516f069df18b500', 'superadmin@system.local', NULL, 'super_admin', 'yes', '2025-12-06 10:41:20.65934', '2025-12-06 09:20:48.949529');
INSERT INTO "public"."users" VALUES (10, 4, 'admin_idk', '0192023a7bbd73250516f069df18b500', 'admin_idk@idk.edu', '12345678', 'admin', 'yes', '2025-12-06 10:41:34.69466', '2025-12-06 10:31:22.694044');
INSERT INTO "public"."users" VALUES (6, 1, 'dara_student', 'ad6a280417a0f533d8b670c61667e1a0', 'dara.sok@gmail.com', '098-765-432', 'student', 'yes', '2025-12-06 10:42:47.252885', '2025-12-06 09:20:48.96214');
INSERT INTO "public"."users" VALUES (11, 1, 'sim chanthea', '11', 'user11@gmail.com', '097-111-011', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (13, 1, 'Kim Borey', 'pwd13', 'user13@gmyesil.com', '097-111-013', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (14, 1, 'Chan Rany', 'pwd14', 'user14@gmyesil.com', '097-111-014', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (15, 1, 'Ly Sokun', 'pwd15', 'user15@gmyesil.com', '097-111-015', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (16, 1, 'Chum Linda', 'pwd16', 'user16@gmyesil.com', '097-111-016', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (17, 1, 'Kao Rith', 'pwd17', 'user17@gmyesil.com', '097-111-017', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (18, 1, 'Touch Sreyly', 'pwd18', 'user18@gmyesil.com', '097-111-018', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (19, 1, 'Noun Vichea', 'pwd19', 'user19@gmyesil.com', '097-111-019', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (20, 1, 'Lay Sophea', 'pwd20', 'user20@gmyesil.com', '097-111-020', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (21, 1, 'Sok Ratha', 'pwd21', 'user21@gmyesil.com', '097-111-021', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (22, 1, 'Ly Sreyneang', 'pwd22', 'user22@gmyesil.com', '097-111-022', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (23, 1, 'Chan Piseth', 'pwd23', 'user23@gmyesil.com', '097-111-023', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (24, 1, 'Kim Malis', 'pwd24', 'user24@gmyesil.com', '097-111-024', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (25, 1, 'Lim Vichea', 'pwd25', 'user25@gmyesil.com', '097-111-025', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (26, 1, 'Heng Linda', 'pwd26', 'user26@gmyesil.com', '097-111-026', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (27, 1, 'Phan Borey', 'pwd27', 'user27@gmyesil.com', '097-111-027', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (28, 1, 'Kong Sreymao', 'pwd28', 'user28@gmyesil.com', '097-111-028', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (29, 1, 'Lay Chantha', 'pwd29', 'user29@gmyesil.com', '097-111-029', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (30, 1, 'Srey Nita', 'pwd30', 'user30@gmyesil.com', '097-111-030', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (31, 1, 'Huot Rith', 'pwd31', 'user31@gmyesil.com', '097-111-031', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (32, 1, 'Touch Sophea', 'pwd32', 'user32@gmyesil.com', '097-111-032', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (33, 1, 'Kao Sokun', 'pwd33', 'user33@gmyesil.com', '097-111-033', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (34, 1, 'Chea Rany', 'pwd34', 'user34@gmyesil.com', '097-111-034', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (35, 1, 'Sim Pisey', 'pwd35', 'user35@gmyesil.com', '097-111-035', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (36, 1, 'Noun Vannak', 'pwd36', 'user36@gmyesil.com', '097-111-036', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (37, 1, 'Ly Mony', 'pwd37', 'user37@gmyesil.com', '097-111-037', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (38, 1, 'Heng Sreypov', 'pwd38', 'user38@gmyesil.com', '097-111-038', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (39, 1, 'Chan Kosal', 'pwd39', 'user39@gmyesil.com', '097-111-039', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (40, 1, 'Kim Sreyka', 'pwd40', 'user40@gmyesil.com', '097-111-040', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (12, 1, 'Heng Sreymao', 'pwd12', 'user12@gmyesil.com', '097-111-012', 'student', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (41, 1, 'Khov Sok', '123', 'khovsok@gmyesil.com', '097-111-011', 'teacher', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (42, 1, 'YU Yunlong', '123', 'Yunlong@gmyesil.com', '097-111-012', 'teacher', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (43, 1, 'Pan Phanong', '123', 'Phanong@gmyesil.com', '097-111-013', 'teacher', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (44, 1, 'Ngim Rady', '123', 'Rady@gmyesil.com', '097-111-014', 'teacher', 'yes', NULL, '2025-12-06 10:00:00');
INSERT INTO "public"."users" VALUES (45, 1, 'Heak Thavuth', '123', 'Thavuth@gmyesil.com', '097-111-015', 'teacher', 'yes', NULL, '2025-12-06 10:00:00');

-- ----------------------------
-- Table structure for users_roles
-- ----------------------------
DROP TABLE IF EXISTS "public"."users_roles";
CREATE TABLE "public"."users_roles" (
  "role_id" int4 NOT NULL DEFAULT nextval('training_system_v5.users_roles_role_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "module_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "can_read" bool DEFAULT false,
  "can_write" bool DEFAULT false,
  "can_update" bool DEFAULT false,
  "can_delete" bool DEFAULT false,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."users_roles"."module_name" IS 'Module name: courses, students, teachers, attendance, payments, reports, assignments, users';
COMMENT ON TABLE "public"."users_roles" IS 'Module 2: Role-based permission system for access control';

-- ----------------------------
-- Records of users_roles
-- ----------------------------
INSERT INTO "public"."users_roles" VALUES (1, 1, 'courses', 't', 't', 't', 't', '2025-12-06 09:20:48.951753');
INSERT INTO "public"."users_roles" VALUES (2, 1, 'students', 't', 't', 't', 't', '2025-12-06 09:20:48.951753');
INSERT INTO "public"."users_roles" VALUES (3, 1, 'teachers', 't', 't', 't', 't', '2025-12-06 09:20:48.951753');
INSERT INTO "public"."users_roles" VALUES (4, 1, 'attendance', 't', 't', 't', 't', '2025-12-06 09:20:48.951753');
INSERT INTO "public"."users_roles" VALUES (5, 1, 'payments', 't', 't', 't', 't', '2025-12-06 09:20:48.951753');
INSERT INTO "public"."users_roles" VALUES (6, 1, 'reports', 't', 't', 't', 't', '2025-12-06 09:20:48.951753');
INSERT INTO "public"."users_roles" VALUES (7, 1, 'assignments', 't', 't', 't', 't', '2025-12-06 09:20:48.951753');
INSERT INTO "public"."users_roles" VALUES (8, 1, 'users', 't', 't', 't', 't', '2025-12-06 09:20:48.951753');
INSERT INTO "public"."users_roles" VALUES (9, 2, 'courses', 't', 't', 't', 't', '2025-12-06 09:20:48.955939');
INSERT INTO "public"."users_roles" VALUES (10, 2, 'students', 't', 't', 't', 't', '2025-12-06 09:20:48.955939');
INSERT INTO "public"."users_roles" VALUES (11, 2, 'teachers', 't', 't', 't', 't', '2025-12-06 09:20:48.955939');
INSERT INTO "public"."users_roles" VALUES (12, 2, 'attendance', 't', 't', 't', 't', '2025-12-06 09:20:48.955939');
INSERT INTO "public"."users_roles" VALUES (13, 2, 'payments', 't', 't', 't', 't', '2025-12-06 09:20:48.955939');
INSERT INTO "public"."users_roles" VALUES (14, 2, 'reports', 't', 't', 't', 't', '2025-12-06 09:20:48.955939');
INSERT INTO "public"."users_roles" VALUES (15, 2, 'assignments', 't', 't', 't', 't', '2025-12-06 09:20:48.955939');
INSERT INTO "public"."users_roles" VALUES (16, 2, 'users', 't', 't', 't', 't', '2025-12-06 09:20:48.955939');
INSERT INTO "public"."users_roles" VALUES (17, 3, 'courses', 't', 't', 't', 'f', '2025-12-06 09:20:48.960118');
INSERT INTO "public"."users_roles" VALUES (18, 3, 'students', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.960118');
INSERT INTO "public"."users_roles" VALUES (19, 3, 'attendance', 't', 't', 't', 'f', '2025-12-06 09:20:48.960118');
INSERT INTO "public"."users_roles" VALUES (20, 3, 'assignments', 't', 't', 't', 't', '2025-12-06 09:20:48.960118');
INSERT INTO "public"."users_roles" VALUES (21, 3, 'reports', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.960118');
INSERT INTO "public"."users_roles" VALUES (22, 4, 'courses', 't', 't', 't', 'f', '2025-12-06 09:20:48.961663');
INSERT INTO "public"."users_roles" VALUES (23, 4, 'students', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.961663');
INSERT INTO "public"."users_roles" VALUES (24, 4, 'attendance', 't', 't', 't', 'f', '2025-12-06 09:20:48.961663');
INSERT INTO "public"."users_roles" VALUES (25, 4, 'assignments', 't', 't', 't', 't', '2025-12-06 09:20:48.961663');
INSERT INTO "public"."users_roles" VALUES (26, 4, 'reports', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.961663');
INSERT INTO "public"."users_roles" VALUES (27, 5, 'courses', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.964524');
INSERT INTO "public"."users_roles" VALUES (28, 5, 'assignments', 't', 't', 'f', 'f', '2025-12-06 09:20:48.964524');
INSERT INTO "public"."users_roles" VALUES (29, 5, 'attendance', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.964524');
INSERT INTO "public"."users_roles" VALUES (30, 5, 'payments', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.964524');
INSERT INTO "public"."users_roles" VALUES (31, 6, 'courses', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.966616');
INSERT INTO "public"."users_roles" VALUES (32, 6, 'assignments', 't', 't', 'f', 'f', '2025-12-06 09:20:48.966616');
INSERT INTO "public"."users_roles" VALUES (33, 6, 'attendance', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.966616');
INSERT INTO "public"."users_roles" VALUES (34, 6, 'payments', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.966616');
INSERT INTO "public"."users_roles" VALUES (35, 7, 'courses', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.968114');
INSERT INTO "public"."users_roles" VALUES (36, 7, 'assignments', 't', 't', 'f', 'f', '2025-12-06 09:20:48.968114');
INSERT INTO "public"."users_roles" VALUES (37, 7, 'attendance', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.968114');
INSERT INTO "public"."users_roles" VALUES (38, 7, 'payments', 't', 'f', 'f', 'f', '2025-12-06 09:20:48.968114');
INSERT INTO "public"."users_roles" VALUES (39, 10, 'courses', 't', 't', 't', 't', '2025-12-06 10:34:14.886171');
INSERT INTO "public"."users_roles" VALUES (40, 10, 'students', 't', 't', 't', 't', '2025-12-06 10:34:14.886171');
INSERT INTO "public"."users_roles" VALUES (41, 10, 'teachers', 't', 't', 't', 't', '2025-12-06 10:34:14.886171');
INSERT INTO "public"."users_roles" VALUES (42, 10, 'attendance', 't', 't', 't', 't', '2025-12-06 10:34:14.886171');
INSERT INTO "public"."users_roles" VALUES (43, 10, 'payments', 't', 't', 't', 't', '2025-12-06 10:34:14.886171');
INSERT INTO "public"."users_roles" VALUES (44, 10, 'reports', 't', 't', 't', 't', '2025-12-06 10:34:14.886171');
INSERT INTO "public"."users_roles" VALUES (45, 10, 'assignments', 't', 't', 't', 't', '2025-12-06 10:34:14.886171');
INSERT INTO "public"."users_roles" VALUES (46, 10, 'users', 't', 't', 't', 't', '2025-12-06 10:34:14.886171');

-- ----------------------------
-- Function structure for approve_company
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."approve_company"("p_regcom_id" int4, "p_approved_by" int4);
CREATE FUNCTION "public"."approve_company"("p_regcom_id" int4, "p_approved_by" int4)
  RETURNS "pg_catalog"."json" AS $BODY$
DECLARE
    v_company RECORD;
    v_admin_user_id INTEGER;
BEGIN
    -- Get company details
    SELECT * INTO v_company 
    FROM training_system_v5.register_company 
    WHERE regcom_id = p_regcom_id;
    
    -- Check if company exists
    IF NOT FOUND THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Company not found'
        );
    END IF;
    
    -- Check if already approved
    IF v_company.status = 'yes' THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Company already approved'
        );
    END IF;
    
    -- Approve company
    UPDATE training_system_v5.register_company 
    SET status = 'yes',
        approved_by = p_approved_by,
        approved_at = CURRENT_TIMESTAMP
    WHERE regcom_id = p_regcom_id;
    
    -- Activate admin user
    UPDATE training_system_v5.users 
    SET status = 'yes'
    WHERE regcom_id = p_regcom_id AND user_type = 'admin'
    RETURNING user_id INTO v_admin_user_id;
    
    -- Assign default admin roles (full access to all modules)
    INSERT INTO training_system_v5.users_roles (user_id, module_name, can_read, can_write, can_update, can_delete)
    SELECT 
        v_admin_user_id,
        module_name,
        true, true, true, true  -- Admin has all permissions
    FROM (
        VALUES 
            ('courses'), 
            ('students'), 
            ('teachers'), 
            ('attendance'), 
            ('payments'), 
            ('reports'), 
            ('assignments'),
            ('users')
    ) AS modules(module_name);
    
    RETURN json_build_object(
        'success', true,
        'message', 'Company approved successfully',
        'company_name', v_company.regcom_name,
        'admin_username', v_company.admin_user
    );
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Approval failed: ' || SQLERRM
        );
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for assign_user_roles
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."assign_user_roles"("p_user_id" int4, "p_module_name" varchar, "p_can_read" bool, "p_can_write" bool, "p_can_update" bool, "p_can_delete" bool);
CREATE FUNCTION "public"."assign_user_roles"("p_user_id" int4, "p_module_name" varchar, "p_can_read" bool, "p_can_write" bool, "p_can_update" bool, "p_can_delete" bool)
  RETURNS "pg_catalog"."json" AS $BODY$
BEGIN
    -- Upsert (insert or update) role
    INSERT INTO training_system_v5.users_roles (
        user_id, module_name, can_read, can_write, can_update, can_delete
    ) VALUES (
        p_user_id, p_module_name, p_can_read, p_can_write, p_can_update, p_can_delete
    )
    ON CONFLICT (user_id, module_name) 
    DO UPDATE SET
        can_read = EXCLUDED.can_read,
        can_write = EXCLUDED.can_write,
        can_update = EXCLUDED.can_update,
        can_delete = EXCLUDED.can_delete;
    
    RETURN json_build_object(
        'success', true,
        'message', 'Role assigned successfully'
    );
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Role assignment failed: ' || SQLERRM
        );
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for authenticate_user
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."authenticate_user"("p_username_or_email" varchar, "p_password" varchar);
CREATE FUNCTION "public"."authenticate_user"("p_username_or_email" varchar, "p_password" varchar)
  RETURNS TABLE("user_id" int4, "regcom_id" int4, "user_name" varchar, "email" varchar, "phone" varchar, "user_type" varchar, "status" varchar, "last_login" timestamp) AS $BODY$
DECLARE
    v_user RECORD;
    v_password_hash VARCHAR(255);
BEGIN
    -- Hash input password
    v_password_hash := MD5(p_password);

    -- Find user
    SELECT 
        u.user_id, u.regcom_id, u.user_name, u.email, u.phone,
        u.user_type, u.status, u.last_login
    INTO v_user
    FROM training_system_v5.users u
    WHERE (u.user_name = p_username_or_email OR u.email = p_username_or_email)
      AND u.upassword = v_password_hash;

    -- User not found or wrong password
    IF NOT FOUND THEN
        RETURN; -- Return empty (same as old behavior)
    END IF;

    -- Check if user is active (status='yes')
    IF v_user.status != 'yes' THEN
        -- Return user data with status='pending' to indicate pending approval
        RETURN QUERY
        SELECT 
            v_user.user_id,
            v_user.regcom_id,
            v_user.user_name,
            v_user.email,
            v_user.phone,
            v_user.user_type,
            'pending'::VARCHAR as status,  -- Show 'pending' instead of 'no'
            v_user.last_login;
        RETURN;
    END IF;

    -- Update last login
    UPDATE training_system_v5.users u
    SET last_login = NOW()
    WHERE u.user_id = v_user.user_id;

    -- Return user data (login successful)
    RETURN QUERY
    SELECT 
        v_user.user_id,
        v_user.regcom_id,
        v_user.user_name,
        v_user.email,
        v_user.phone,
        v_user.user_type,
        v_user.status,
        NOW()::TIMESTAMP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for authenticate_user_old
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."authenticate_user_old"("p_username_or_email" varchar, "p_password" varchar);
CREATE FUNCTION "public"."authenticate_user_old"("p_username_or_email" varchar, "p_password" varchar)
  RETURNS TABLE("user_id" int4, "regcom_id" int4, "user_name" varchar, "email" varchar, "phone" varchar, "user_type" varchar, "status" varchar, "last_login" timestamp) AS $BODY$
BEGIN
    RETURN QUERY
    SELECT 
        u.user_id,
        u.regcom_id,
        u.user_name,
        u.email,
        u.phone,
        u.user_type,
        u.status,
        u.last_login
    FROM users u
    WHERE (u.user_name = p_username_or_email OR u.email = p_username_or_email)
      AND u.upassword = MD5(p_password);
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for create_student_by_admin
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."create_student_by_admin"("p_admin_user_id" int4, "p_username" varchar, "p_password" varchar, "p_first_name" varchar, "p_last_name" varchar, "p_gender" varchar, "p_date_of_birth" date, "p_phone" varchar, "p_email" varchar, "p_address" text, "p_emergency_contact" varchar);
CREATE FUNCTION "public"."create_student_by_admin"("p_admin_user_id" int4, "p_username" varchar, "p_password" varchar, "p_first_name" varchar, "p_last_name" varchar, "p_gender" varchar, "p_date_of_birth" date, "p_phone" varchar, "p_email" varchar, "p_address" text=NULL::text, "p_emergency_contact" varchar=NULL::character varying)
  RETURNS "pg_catalog"."json" AS $BODY$
DECLARE
    v_regcom_id INTEGER;
    v_new_user_id INTEGER;
    v_new_student_id INTEGER;
    v_student_code VARCHAR(20);
    v_password_hash VARCHAR(255);
BEGIN
    -- Get admin's company
    SELECT regcom_id INTO v_regcom_id
    FROM training_system_v5.users 
    WHERE user_id = p_admin_user_id AND user_type = 'admin';
    
    IF v_regcom_id IS NULL THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Admin user not found or not authorized'
        );
    END IF;
    
    -- Check username availability
    IF EXISTS (SELECT 1 FROM training_system_v5.users WHERE user_name = p_username) THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Username already exists'
        );
    END IF;
    
    -- Check email availability
    IF EXISTS (SELECT 1 FROM training_system_v5.users WHERE email = p_email) THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Email already registered'
        );
    END IF;
    
    -- Hash password
    v_password_hash := MD5(p_password);
    
    -- Create user account (ACTIVE immediately - status='yes')
    INSERT INTO training_system_v5.users (
        regcom_id, user_name, upassword, email, phone, user_type, status
    ) VALUES (
        v_regcom_id, p_username, v_password_hash, p_email, p_phone, 'student', 'yes'
    ) RETURNING user_id INTO v_new_user_id;
    
    -- Generate student code
    SELECT 'STU' || LPAD((COALESCE(MAX(CAST(SUBSTRING(student_code FROM 4) AS INTEGER)), 0) + 1)::TEXT, 5, '0')
    INTO v_student_code
    FROM training_system_v5.students
    WHERE regcom_id = v_regcom_id;
    
    -- Create student profile
    INSERT INTO training_system_v5.students (
        regcom_id, user_id, student_code, first_name, last_name,
        gender, date_of_birth, phone, email, address, emergency_contact, status
    ) VALUES (
        v_regcom_id, v_new_user_id, v_student_code, p_first_name, p_last_name,
        p_gender, p_date_of_birth, p_phone, p_email, p_address, p_emergency_contact, 'Active'
    ) RETURNING student_id INTO v_new_student_id;
    
    -- Assign default student roles
    INSERT INTO training_system_v5.users_roles (user_id, module_name, can_read, can_write, can_update, can_delete)
    VALUES
        (v_new_user_id, 'courses', true, false, false, false),
        (v_new_user_id, 'assignments', true, true, false, false),
        (v_new_user_id, 'attendance', true, false, false, false),
        (v_new_user_id, 'payments', true, false, false, false);
    
    RETURN json_build_object(
        'success', true,
        'message', 'Student created successfully',
        'student_id', v_new_student_id,
        'student_code', v_student_code,
        'user_id', v_new_user_id,
        'username', p_username,
        'full_name', p_first_name || ' ' || p_last_name
    );
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Student creation failed: ' || SQLERRM
        );
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for create_teacher_by_admin
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."create_teacher_by_admin"("p_admin_user_id" int4, "p_username" varchar, "p_password" varchar, "p_first_name" varchar, "p_last_name" varchar, "p_gender" varchar, "p_phone" varchar, "p_email" varchar, "p_specialization" varchar, "p_qualification" varchar);
CREATE FUNCTION "public"."create_teacher_by_admin"("p_admin_user_id" int4, "p_username" varchar, "p_password" varchar, "p_first_name" varchar, "p_last_name" varchar, "p_gender" varchar, "p_phone" varchar, "p_email" varchar, "p_specialization" varchar=NULL::character varying, "p_qualification" varchar=NULL::character varying)
  RETURNS "pg_catalog"."json" AS $BODY$
DECLARE
    v_regcom_id INTEGER;
    v_new_user_id INTEGER;
    v_new_teacher_id INTEGER;
    v_teacher_code VARCHAR(20);
    v_password_hash VARCHAR(255);
BEGIN
    -- Get admin's company
    SELECT regcom_id INTO v_regcom_id
    FROM training_system_v5.users 
    WHERE user_id = p_admin_user_id AND user_type = 'admin';
    
    IF v_regcom_id IS NULL THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Admin user not found or not authorized'
        );
    END IF;
    
    -- Check username availability
    IF EXISTS (SELECT 1 FROM training_system_v5.users WHERE user_name = p_username) THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Username already exists'
        );
    END IF;
    
    -- Check email availability
    IF EXISTS (SELECT 1 FROM training_system_v5.users WHERE email = p_email) THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Email already registered'
        );
    END IF;
    
    -- Hash password
    v_password_hash := MD5(p_password);
    
    -- Create user account (ACTIVE immediately - status='yes')
    INSERT INTO training_system_v5.users (
        regcom_id, user_name, upassword, email, phone, user_type, status
    ) VALUES (
        v_regcom_id, p_username, v_password_hash, p_email, p_phone, 'teacher', 'yes'
    ) RETURNING user_id INTO v_new_user_id;
    
    -- Generate teacher code
    SELECT 'TCH' || LPAD((COALESCE(MAX(CAST(SUBSTRING(teacher_code FROM 4) AS INTEGER)), 0) + 1)::TEXT, 3, '0')
    INTO v_teacher_code
    FROM training_system_v5.teachers
    WHERE regcom_id = v_regcom_id;
    
    -- Create teacher profile (matching actual table structure)
    INSERT INTO training_system_v5.teachers (
        regcom_id, user_id, teacher_code, first_name, last_name,
        gender, phone, email, specialization, qualification, status
    ) VALUES (
        v_regcom_id, v_new_user_id, v_teacher_code, p_first_name, p_last_name,
        p_gender, p_phone, p_email, p_specialization, p_qualification, 'Active'
    ) RETURNING teacher_id INTO v_new_teacher_id;
    
    -- Assign default teacher roles
    INSERT INTO training_system_v5.users_roles (user_id, module_name, can_read, can_write, can_update, can_delete)
    VALUES
        (v_new_user_id, 'courses', true, true, true, false),
        (v_new_user_id, 'students', true, false, false, false),
        (v_new_user_id, 'attendance', true, true, true, false),
        (v_new_user_id, 'assignments', true, true, true, true),
        (v_new_user_id, 'reports', true, false, false, false);
    
    RETURN json_build_object(
        'success', true,
        'message', 'Teacher created successfully',
        'teacher_id', v_new_teacher_id,
        'teacher_code', v_teacher_code,
        'user_id', v_new_user_id,
        'username', p_username,
        'full_name', p_first_name || ' ' || p_last_name
    );
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Teacher creation failed: ' || SQLERRM
        );
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for get_active_companies
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_active_companies"();
CREATE FUNCTION "public"."get_active_companies"()
  RETURNS TABLE("regcom_id" int4, "regcom_name" varchar, "regcom_email" varchar, "regcom_phone" varchar) AS $BODY$
BEGIN
    RETURN QUERY
    SELECT 
        rc.regcom_id,
        rc.regcom_name,
        rc.regcom_email,
        rc.regcom_phone
    FROM training_system_v5.register_company rc
    WHERE rc.status = 'yes'
    ORDER BY rc.regcom_name ASC;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for get_company_users
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_company_users"("p_regcom_id" int4);
CREATE FUNCTION "public"."get_company_users"("p_regcom_id" int4)
  RETURNS TABLE("user_id" int4, "username" varchar, "email" varchar, "user_type" varchar, "full_name" varchar, "status" varchar, "created_date" timestamp) AS $BODY$
BEGIN
    RETURN QUERY
    SELECT 
        u.user_id,
        u.user_name,
        u.email,
        u.user_type,
        CASE 
            WHEN u.user_type = 'student' THEN s.first_name || ' ' || s.last_name
            WHEN u.user_type = 'teacher' THEN t.first_name || ' ' || t.last_name
            ELSE u.user_name
        END as full_name,
        u.status,
        u.created_date
    FROM training_system_v5.users u
    LEFT JOIN training_system_v5.students s ON u.user_id = s.user_id
    LEFT JOIN training_system_v5.teachers t ON u.user_id = t.user_id
    WHERE u.regcom_id = p_regcom_id
    ORDER BY u.created_date DESC;
END;
$BODY$
  LANGUAGE plpgsql STABLE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for get_pending_companies
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_pending_companies"();
CREATE FUNCTION "public"."get_pending_companies"()
  RETURNS TABLE("regcom_id" int4, "regcom_name" varchar, "regcom_email" varchar, "regcom_phone" varchar, "regcom_address" text, "admin_user" varchar, "created_at" timestamp, "status" varchar) AS $BODY$
BEGIN
    RETURN QUERY
    SELECT 
        rc.regcom_id,
        rc.regcom_name,
        rc.regcom_email,
        rc.regcom_phone,
        rc.regcom_address,
        rc.admin_user,
        rc.created_at,
        rc.status
    FROM training_system_v5.register_company rc
    WHERE rc.status = 'no'
    ORDER BY rc.created_at DESC;
END;
$BODY$
  LANGUAGE plpgsql STABLE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for login_user_with_permissions
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."login_user_with_permissions"("p_username_or_email" varchar, "p_password" varchar);
CREATE FUNCTION "public"."login_user_with_permissions"("p_username_or_email" varchar, "p_password" varchar)
  RETURNS "pg_catalog"."json" AS $BODY$
DECLARE
    v_user RECORD;
    v_company_name VARCHAR;
    v_full_name VARCHAR;
    v_permissions JSON;
    v_password_hash VARCHAR(255);
BEGIN
    -- Hash input password
    v_password_hash := MD5(p_password);
    
    -- Get user by username or email
    SELECT * INTO v_user
    FROM training_system_v5.users u
    WHERE (u.user_name = p_username_or_email OR u.email = p_username_or_email);
    
    -- Check if user exists
    IF NOT FOUND THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Invalid username/email or password'
        );
    END IF;
    
    -- Check password
    IF v_user.upassword != v_password_hash THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Invalid username/email or password'
        );
    END IF;
    
    -- Check if user is active
    IF v_user.status != 'yes' THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Account is pending approval or inactive'
        );
    END IF;
    
    -- Get company name
    IF v_user.regcom_id IS NOT NULL THEN
        SELECT regcom_name INTO v_company_name
        FROM training_system_v5.register_company
        WHERE regcom_id = v_user.regcom_id;
    ELSE
        v_company_name := 'System';
    END IF;
    
    -- Get full name based on user type
    IF v_user.user_type = 'student' THEN
        SELECT first_name || ' ' || last_name INTO v_full_name
        FROM training_system_v5.students WHERE user_id = v_user.user_id;
    ELSIF v_user.user_type = 'teacher' THEN
        SELECT first_name || ' ' || last_name INTO v_full_name
        FROM training_system_v5.teachers WHERE user_id = v_user.user_id;
    ELSE
        v_full_name := v_user.user_name;
    END IF;
    
    -- Get user permissions
    SELECT json_agg(
        json_build_object(
            'module', module_name,
            'read', can_read,
            'write', can_write,
            'update', can_update,
            'delete', can_delete
        )
    ) INTO v_permissions
    FROM training_system_v5.users_roles
    WHERE user_id = v_user.user_id;
    
    -- Update last login
    UPDATE training_system_v5.users 
    SET last_login = CURRENT_TIMESTAMP 
    WHERE user_id = v_user.user_id;
    
    -- Return success with full user info
    RETURN json_build_object(
        'success', true,
        'message', 'Login successful',
        'user_id', v_user.user_id,
        'username', v_user.user_name,
        'email', v_user.email,
        'user_type', v_user.user_type,
        'regcom_id', v_user.regcom_id,
        'company_name', v_company_name,
        'full_name', v_full_name,
        'permissions', COALESCE(v_permissions, '[]'::json)
    );
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Login failed: ' || SQLERRM
        );
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for register_company
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."register_company"("p_company_name" varchar, "p_company_email" varchar, "p_company_phone" varchar, "p_company_address" text, "p_admin_username" varchar, "p_admin_password" varchar, "p_admin_email" varchar, "p_website" varchar, "p_logo" bytea, "p_admin_phone" varchar);
CREATE FUNCTION "public"."register_company"("p_company_name" varchar, "p_company_email" varchar, "p_company_phone" varchar, "p_company_address" text, "p_admin_username" varchar, "p_admin_password" varchar, "p_admin_email" varchar, "p_website" varchar=NULL::character varying, "p_logo" bytea=NULL::bytea, "p_admin_phone" varchar=NULL::character varying)
  RETURNS "pg_catalog"."json" AS $BODY$
DECLARE
    v_regcom_id INTEGER;
    v_password_hash VARCHAR(255);
BEGIN
    -- Validate inputs
    IF p_company_name IS NULL OR TRIM(p_company_name) = '' THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Company name is required'
        );
    END IF;
    
    -- Check if company email already exists
    IF EXISTS (SELECT 1 FROM training_system_v5.register_company WHERE regcom_email = p_company_email) THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Company email already registered'
        );
    END IF;
    
    -- Check if admin username already exists
    IF EXISTS (SELECT 1 FROM training_system_v5.users WHERE user_name = p_admin_username) THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Username already taken'
        );
    END IF;
    
    -- Hash password (MD5 for now, should use bcrypt in production)
    v_password_hash := MD5(p_admin_password);
    
    -- Create company record (status='no' - pending approval)
    INSERT INTO training_system_v5.register_company (
        regcom_name, regcom_email, regcom_phone, regcom_address,
        website, logo, admin_user, admin_password, status
    ) VALUES (
        p_company_name, p_company_email, p_company_phone, p_company_address,
        p_website, p_logo, p_admin_username, v_password_hash, 'no'
    ) RETURNING regcom_id INTO v_regcom_id;
    
    -- Create admin user account (status='no' - cannot login yet)
    INSERT INTO training_system_v5.users (
        regcom_id, user_name, upassword, email, phone, user_type, status
    ) VALUES (
        v_regcom_id, p_admin_username, v_password_hash, p_admin_email, p_admin_phone, 'admin', 'no'
    );
    
    RETURN json_build_object(
        'success', true,
        'message', 'Company registration submitted successfully. Awaiting super admin approval.',
        'regcom_id', v_regcom_id,
        'company_name', p_company_name,
        'admin_username', p_admin_username
    );
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Registration failed: ' || SQLERRM
        );
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_enrollment_progress
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_enrollment_progress"();
CREATE FUNCTION "public"."update_enrollment_progress"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
DECLARE
    total_lessons INTEGER;
    completed_lessons INTEGER;
    progress DECIMAL(5,2);
    v_course_id INTEGER;
BEGIN
    SELECT l.course_id INTO v_course_id FROM lessons l WHERE l.lesson_id = NEW.lesson_id;
    
    SELECT COUNT(*) INTO total_lessons
    FROM lessons WHERE course_id = v_course_id AND status = 'Active';
    
    SELECT COUNT(*) INTO completed_lessons
    FROM lesson_completion lc
    JOIN lessons l ON lc.lesson_id = l.lesson_id
    WHERE l.course_id = v_course_id
    AND lc.student_id = NEW.student_id
    AND lc.is_completed = true;
    
    IF total_lessons > 0 THEN
        progress := (completed_lessons::DECIMAL / total_lessons::DECIMAL) * 100;
        
        UPDATE enrollments
        SET progress_percentage = progress,
            completion_status = CASE 
                WHEN progress = 100 THEN 'Completed'
                WHEN progress > 0 THEN 'Ongoing'
                ELSE 'Not Started'
            END,
            last_accessed = CURRENT_TIMESTAMP
        WHERE student_id = NEW.student_id AND course_id = v_course_id;
    END IF;
    
    RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- View structure for v_course_reviews_summary
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_course_reviews_summary";
CREATE VIEW "public"."v_course_reviews_summary" AS  SELECT c.course_code,
    c.course_name,
    count(cr.review_id) AS total_reviews,
    round(avg(cr.rating), 2) AS avg_rating,
    count(
        CASE
            WHEN cr.rating = 5 THEN 1
            ELSE NULL::integer
        END) AS five_star,
    count(
        CASE
            WHEN cr.rating = 4 THEN 1
            ELSE NULL::integer
        END) AS four_star,
    count(
        CASE
            WHEN cr.rating = 3 THEN 1
            ELSE NULL::integer
        END) AS three_star,
    count(
        CASE
            WHEN cr.rating = 2 THEN 1
            ELSE NULL::integer
        END) AS two_star,
    count(
        CASE
            WHEN cr.rating = 1 THEN 1
            ELSE NULL::integer
        END) AS one_star
   FROM training_system_v5.courses c
     LEFT JOIN training_system_v5.course_reviews cr ON c.course_id = cr.course_id
  WHERE c.status::text = 'Active'::text
  GROUP BY c.course_code, c.course_name
  ORDER BY (round(avg(cr.rating), 2)) DESC NULLS LAST;

-- ----------------------------
-- View structure for v_student_dashboard
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_student_dashboard";
CREATE VIEW "public"."v_student_dashboard" AS  SELECT s.student_code,
    (s.first_name::text || ' '::text) || s.last_name::text AS student_name,
    count(DISTINCT e.course_id) AS enrolled_courses,
    count(DISTINCT
        CASE
            WHEN e.completion_status::text = 'Completed'::text THEN e.course_id
            ELSE NULL::integer
        END) AS completed_courses,
    round(avg(e.progress_percentage), 2) AS avg_progress,
    count(DISTINCT lc.lesson_id) AS total_lessons_completed,
    round(avg(lc.score), 2) AS avg_lesson_score,
    count(DISTINCT er.exam_id) AS exams_taken,
    round(avg(er.percentage), 2) AS avg_exam_percentage,
    count(DISTINCT asub.assignment_id) AS assignments_submitted,
    round(avg(asub.marks_obtained), 2) AS avg_assignment_score
   FROM training_system_v5.students s
     LEFT JOIN training_system_v5.enrollments e ON s.student_id = e.student_id
     LEFT JOIN training_system_v5.lesson_completion lc ON s.student_id = lc.student_id AND lc.is_completed = true
     LEFT JOIN training_system_v5.exam_results er ON s.student_id = er.student_id
     LEFT JOIN training_system_v5.assignment_submissions asub ON s.student_id = asub.student_id
  WHERE s.status::text = 'Active'::text
  GROUP BY s.student_code, s.first_name, s.last_name
  ORDER BY s.student_code;

-- ----------------------------
-- View structure for v_course_details
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_course_details";
CREATE VIEW "public"."v_course_details" AS  SELECT c.course_id,
    c.course_code,
    c.course_name,
    c.course_description,
    c.duration_hours,
    c.start_date,
    c.end_date,
    c.course_fee,
    c.max_students,
    c.skill_level,
    c.is_self_enrollment_allowed,
    c.status,
    rc.regcom_name AS institute_name,
    t.teacher_code,
    (t.first_name::text || ' '::text) || t.last_name::text AS instructor_name,
    t.email AS instructor_email,
    count(DISTINCT s.subject_id) AS total_subjects,
    count(DISTINCT l.lesson_id) AS total_lessons,
    count(DISTINCT e.student_id) AS enrolled_students,
    count(DISTINCT
        CASE
            WHEN e.completion_status::text = 'Completed'::text THEN e.student_id
            ELSE NULL::integer
        END) AS completed_students,
    round(avg(e.progress_percentage), 2) AS avg_progress,
    count(DISTINCT ex.exam_id) AS total_exams,
    count(DISTINCT a.assignment_id) AS total_assignments,
    round(avg(cr.rating), 2) AS avg_rating,
    count(cr.review_id) AS review_count
   FROM training_system_v5.courses c
     JOIN training_system_v5.register_company rc ON c.regcom_id = rc.regcom_id
     LEFT JOIN training_system_v5.teachers t ON c.instructor_id = t.teacher_id
     LEFT JOIN training_system_v5.subjects s ON c.course_id = s.course_id AND s.status::text = 'Active'::text
     LEFT JOIN training_system_v5.lessons l ON c.course_id = l.course_id AND l.status::text = 'Active'::text
     LEFT JOIN training_system_v5.enrollments e ON c.course_id = e.course_id
     LEFT JOIN training_system_v5.exams ex ON c.course_id = ex.course_id
     LEFT JOIN training_system_v5.assignments a ON c.course_id = a.course_id
     LEFT JOIN training_system_v5.course_reviews cr ON c.course_id = cr.course_id
  WHERE c.status::text = 'Active'::text
  GROUP BY c.course_id, c.course_code, c.course_name, c.course_description, c.duration_hours, c.start_date, c.end_date, c.course_fee, c.max_students, c.skill_level, c.is_self_enrollment_allowed, c.status, rc.regcom_name, t.teacher_code, t.first_name, t.last_name, t.email
  ORDER BY c.course_code;
COMMENT ON VIEW "public"."v_course_details" IS 'Complete course information with statistics';

-- ----------------------------
-- View structure for v_course_structure
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_course_structure";
CREATE VIEW "public"."v_course_structure" AS  SELECT c.course_code,
    c.course_name,
    s.subject_code,
    s.subject_name,
    s.subject_order,
    s.duration_hours AS subject_hours,
    l.lesson_number,
    l.lesson_name,
    l.lesson_title,
    l.lesson_order,
    l.duration_minutes,
    l.lesson_type,
    l.is_preview
   FROM training_system_v5.courses c
     JOIN training_system_v5.subjects s ON c.course_id = s.course_id
     JOIN training_system_v5.lessons l ON s.subject_id = l.subject_id
  WHERE c.status::text = 'Active'::text AND s.status::text = 'Active'::text AND l.status::text = 'Active'::text
  ORDER BY c.course_code, s.subject_order, l.lesson_order;

-- ----------------------------
-- View structure for v_student_enrollments
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_student_enrollments";
CREATE VIEW "public"."v_student_enrollments" AS  SELECT s.student_code,
    (s.first_name::text || ' '::text) || s.last_name::text AS student_name,
    c.course_code,
    c.course_name,
    e.enrollment_date,
    e.payment_status,
    e.payment_amount,
    c.course_fee,
    e.completion_status,
    e.progress_percentage,
    count(DISTINCT l.lesson_id) AS total_lessons,
    count(DISTINCT lc.lesson_id) AS lessons_completed,
    round(avg(lc.score), 2) AS avg_score,
    sum(lc.time_spent_minutes) AS time_spent_minutes,
    e.certificate_issued,
    e.certificate_number,
    e.last_accessed
   FROM training_system_v5.students s
     JOIN training_system_v5.enrollments e ON s.student_id = e.student_id
     JOIN training_system_v5.courses c ON e.course_id = c.course_id
     LEFT JOIN training_system_v5.lessons l ON c.course_id = l.course_id AND l.status::text = 'Active'::text
     LEFT JOIN training_system_v5.lesson_completion lc ON l.lesson_id = lc.lesson_id AND s.student_id = lc.student_id
  GROUP BY s.student_code, s.first_name, s.last_name, c.course_code, c.course_name, e.enrollment_date, e.payment_status, e.payment_amount, c.course_fee, e.completion_status, e.progress_percentage, e.certificate_issued, e.certificate_number, e.last_accessed
  ORDER BY s.student_code, c.course_code;

-- ----------------------------
-- View structure for v_student_attendance
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_student_attendance";
CREATE VIEW "public"."v_student_attendance" AS  SELECT s.student_code,
    (s.first_name::text || ' '::text) || s.last_name::text AS student_name,
    c.course_code,
    c.course_name,
    count(a.attendance_id) AS total_sessions,
    count(
        CASE
            WHEN a.status::text = 'Present'::text THEN 1
            ELSE NULL::integer
        END) AS present_count,
    count(
        CASE
            WHEN a.status::text = 'Absent'::text THEN 1
            ELSE NULL::integer
        END) AS absent_count,
    round(count(
        CASE
            WHEN a.status::text = 'Present'::text THEN 1
            ELSE NULL::integer
        END)::numeric / NULLIF(count(a.attendance_id), 0)::numeric * 100::numeric, 2) AS attendance_percentage,
    sum(a.duration_minutes) AS total_minutes_attended
   FROM training_system_v5.students s
     JOIN training_system_v5.enrollments e ON s.student_id = e.student_id
     JOIN training_system_v5.courses c ON e.course_id = c.course_id
     LEFT JOIN training_system_v5.online_attendance a ON s.student_id = a.student_id AND c.course_id = a.course_id
  WHERE a.attendance_type::text = 'Student'::text
  GROUP BY s.student_code, s.first_name, s.last_name, c.course_code, c.course_name
  ORDER BY s.student_code, c.course_code;
COMMENT ON VIEW "public"."v_student_attendance" IS 'Student attendance summary per course';

-- ----------------------------
-- View structure for v_teacher_profile
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_teacher_profile";
CREATE VIEW "public"."v_teacher_profile" AS  SELECT t.teacher_id,
    t.teacher_code,
    t.first_name,
    t.last_name,
    (t.first_name::text || ' '::text) || t.last_name::text AS full_name,
    t.email,
    t.phone,
    t.bio,
    t.qualification,
    t.specialization,
    t.experience_years,
    t.hourly_rate,
    t.status,
    count(DISTINCT c.course_id) AS courses_teaching,
    count(DISTINCT e.student_id) AS total_students,
    count(DISTINCT
        CASE
            WHEN e.completion_status::text = 'Completed'::text THEN e.student_id
            ELSE NULL::integer
        END) AS students_completed,
    round(avg(e.progress_percentage), 2) AS avg_student_progress,
    count(DISTINCT ex.exam_id) AS exams_created,
    count(DISTINCT a.assignment_id) AS assignments_created,
    round(avg(cr.rating), 2) AS avg_course_rating
   FROM training_system_v5.teachers t
     LEFT JOIN training_system_v5.courses c ON t.teacher_id = c.instructor_id AND c.status::text = 'Active'::text
     LEFT JOIN training_system_v5.enrollments e ON c.course_id = e.course_id
     LEFT JOIN training_system_v5.exams ex ON c.course_id = ex.course_id
     LEFT JOIN training_system_v5.assignments a ON c.course_id = a.course_id
     LEFT JOIN training_system_v5.course_reviews cr ON c.course_id = cr.course_id
  WHERE t.status::text = 'Active'::text
  GROUP BY t.teacher_id, t.teacher_code, t.first_name, t.last_name, t.email, t.phone, t.bio, t.qualification, t.specialization, t.experience_years, t.hourly_rate, t.status
  ORDER BY t.teacher_code;

-- ----------------------------
-- View structure for v_teacher_attendance
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_teacher_attendance";
CREATE VIEW "public"."v_teacher_attendance" AS  SELECT t.teacher_code,
    (t.first_name::text || ' '::text) || t.last_name::text AS teacher_name,
    c.course_code,
    c.course_name,
    count(a.attendance_id) AS total_sessions,
    count(
        CASE
            WHEN a.status::text = 'Present'::text THEN 1
            ELSE NULL::integer
        END) AS sessions_taught,
    count(
        CASE
            WHEN a.status::text = 'Absent'::text THEN 1
            ELSE NULL::integer
        END) AS sessions_missed,
    round(count(
        CASE
            WHEN a.status::text = 'Present'::text THEN 1
            ELSE NULL::integer
        END)::numeric / NULLIF(count(a.attendance_id), 0)::numeric * 100::numeric, 2) AS attendance_percentage,
    sum(a.duration_minutes) AS total_minutes_taught,
    round(sum(a.duration_minutes)::numeric / 60::numeric, 2) AS total_hours_taught
   FROM training_system_v5.teachers t
     JOIN training_system_v5.courses c ON t.teacher_id = c.instructor_id
     LEFT JOIN training_system_v5.online_attendance a ON t.teacher_id = a.teacher_id AND c.course_id = a.course_id
  WHERE a.attendance_type::text = 'Teacher'::text
  GROUP BY t.teacher_code, t.first_name, t.last_name, c.course_code, c.course_name
  ORDER BY t.teacher_code, c.course_code;
COMMENT ON VIEW "public"."v_teacher_attendance" IS 'Teacher attendance and hours taught';

-- ----------------------------
-- View structure for v_exam_performance
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_exam_performance";
CREATE VIEW "public"."v_exam_performance" AS  SELECT c.course_code,
    c.course_name,
    ex.exam_type,
    ex.exam_title,
    ex.exam_date,
    ex.total_marks,
    ex.passing_marks,
    count(er.result_id) AS students_took_exam,
    count(
        CASE
            WHEN er.passed = true THEN 1
            ELSE NULL::integer
        END) AS students_passed,
    round(avg(er.marks_obtained), 2) AS avg_marks,
    round(avg(er.percentage), 2) AS avg_percentage,
    round(min(er.marks_obtained), 2) AS min_marks,
    round(max(er.marks_obtained), 2) AS max_marks,
    round(count(
        CASE
            WHEN er.passed = true THEN 1
            ELSE NULL::integer
        END)::numeric / NULLIF(count(er.result_id), 0)::numeric * 100::numeric, 2) AS pass_rate
   FROM training_system_v5.exams ex
     JOIN training_system_v5.courses c ON ex.course_id = c.course_id
     LEFT JOIN training_system_v5.exam_results er ON ex.exam_id = er.exam_id
  GROUP BY c.course_code, c.course_name, ex.exam_type, ex.exam_title, ex.exam_date, ex.total_marks, ex.passing_marks
  ORDER BY ex.exam_date DESC;

-- ----------------------------
-- View structure for v_assignment_performance
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_assignment_performance";
CREATE VIEW "public"."v_assignment_performance" AS  SELECT c.course_code,
    c.course_name,
    a.title AS assignment_title,
    a.due_date,
    a.total_marks,
    count(asub.submission_id) AS total_submissions,
    count(
        CASE
            WHEN asub.status::text = 'Graded'::text THEN 1
            ELSE NULL::integer
        END) AS graded_submissions,
    round(avg(asub.marks_obtained), 2) AS avg_marks,
    round(min(asub.marks_obtained), 2) AS min_marks,
    round(max(asub.marks_obtained), 2) AS max_marks
   FROM training_system_v5.assignments a
     JOIN training_system_v5.courses c ON a.course_id = c.course_id
     LEFT JOIN training_system_v5.assignment_submissions asub ON a.assignment_id = asub.assignment_id
  GROUP BY c.course_code, c.course_name, a.title, a.due_date, a.total_marks
  ORDER BY a.due_date DESC;

-- ----------------------------
-- View structure for v_pending_registrations
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_pending_registrations";
CREATE VIEW "public"."v_pending_registrations" AS  SELECT sr.registration_id,
    (sr.first_name::text || ' '::text) || sr.last_name::text AS applicant_name,
    sr.email,
    sr.phone,
    sr.registration_date,
    sr.approval_status,
    rc.regcom_name AS institute_name,
        CASE
            WHEN sr.approval_status::text = 'Pending'::text THEN EXTRACT(day FROM CURRENT_TIMESTAMP - sr.registration_date::timestamp with time zone) || ' days waiting'::text
            ELSE NULL::text
        END AS waiting_time
   FROM training_system_v5.student_registrations sr
     JOIN training_system_v5.register_company rc ON sr.regcom_id = rc.regcom_id
  WHERE sr.approval_status::text = 'Pending'::text
  ORDER BY sr.registration_date;

-- ----------------------------
-- View structure for v_student_profile
-- ----------------------------
DROP VIEW IF EXISTS "public"."v_student_profile";
CREATE VIEW "public"."v_student_profile" AS  SELECT s.student_id,
    s.student_code,
    s.first_name,
    s.last_name,
    (s.first_name::text || ' '::text) || s.last_name::text AS full_name,
    s.gender,
    s.date_of_birth,
    EXTRACT(year FROM age(s.date_of_birth::timestamp with time zone)) AS age,
    s.phone,
    s.email,
    s.address,
    s.emergency_contact,
    s.registration_date,
    s.status,
    u.user_name,
    u.last_login,
    count(DISTINCT e.course_id) AS courses_enrolled,
    count(DISTINCT
        CASE
            WHEN e.completion_status::text = 'Completed'::text THEN e.course_id
            ELSE NULL::integer
        END) AS courses_completed,
    round(avg(e.progress_percentage), 2) AS avg_progress,
    count(DISTINCT lc.lesson_id) AS lessons_completed,
    round(avg(lc.score), 2) AS avg_lesson_score,
    sum(lc.time_spent_minutes) AS total_learning_minutes,
    count(DISTINCT er.exam_id) AS exams_taken,
    round(avg(er.percentage), 2) AS avg_exam_score
   FROM training_system_v5.students s
     LEFT JOIN training_system_v5.users u ON s.user_id = u.user_id
     LEFT JOIN training_system_v5.enrollments e ON s.student_id = e.student_id
     LEFT JOIN training_system_v5.lesson_completion lc ON s.student_id = lc.student_id AND lc.is_completed = true
     LEFT JOIN training_system_v5.exam_results er ON s.student_id = er.student_id
  WHERE s.status::text = 'Active'::text
  GROUP BY s.student_id, s.student_code, s.first_name, s.last_name, s.gender, s.date_of_birth, s.phone, s.email, s.address, s.emergency_contact, s.registration_date, s.status, u.user_name, u.last_login
  ORDER BY s.student_code;
COMMENT ON VIEW "public"."v_student_profile" IS 'Comprehensive student profile with all metrics';

-- ----------------------------
-- View structure for vw_attendance_report
-- ----------------------------
DROP VIEW IF EXISTS "public"."vw_attendance_report";
CREATE VIEW "public"."vw_attendance_report" AS  SELECT oa.attendance_id,
    s.student_code,
    (s.first_name::text || ' '::text) || s.last_name::text AS student_name,
    s.gender,
    (t.first_name::text || ' '::text) || t.last_name::text AS teacher_name,
    c.course_name,
    l.lesson_name,
    oa.attendance_date,
    oa.attendance_type,
    oa.status,
    oa.duration_minutes,
    oa.remarks
   FROM online_attendance oa
     JOIN students s ON oa.student_id = s.student_id
     JOIN teachers t ON oa.teacher_id = t.teacher_id
     JOIN courses c ON oa.course_id = c.course_id
     JOIN lessons l ON oa.lesson_id = l.lesson_id;

-- ----------------------------
-- View structure for vw_course_enrollment_report
-- ----------------------------
DROP VIEW IF EXISTS "public"."vw_course_enrollment_report";
CREATE VIEW "public"."vw_course_enrollment_report" AS  SELECT c.course_id,
    c.course_name,
    c.course_description,
    c.duration_hours,
    c.course_fee,
    t.teacher_id,
    (t.first_name::text || ' '::text) || t.last_name::text AS teacher_name,
    count(e.student_id) AS total_students,
    count(
        CASE
            WHEN s.gender::text = 'M'::text THEN 1
            ELSE NULL::integer
        END) AS male_students,
    count(
        CASE
            WHEN s.gender::text = 'F'::text THEN 1
            ELSE NULL::integer
        END) AS female_students,
    min(e.enrollment_date) AS first_enrollment_date,
    max(e.enrollment_date) AS last_enrollment_date
   FROM courses c
     LEFT JOIN teachers t ON c.teacher_id = t.teacher_id
     LEFT JOIN enrollments e ON c.course_id = e.course_id
     LEFT JOIN students s ON e.student_id = s.student_id
  GROUP BY c.course_id, c.course_name, c.course_description, c.duration_hours, c.course_fee, t.teacher_id, t.first_name, t.last_name;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."assignment_submissions_submission_id_seq"
OWNED BY "public"."assignment_submissions"."submission_id";
SELECT setval('"public"."assignment_submissions_submission_id_seq"', 10, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."assignments_assignment_id_seq"
OWNED BY "public"."assignments"."assignment_id";
SELECT setval('"public"."assignments_assignment_id_seq"', 7, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."course_reviews_review_id_seq"
OWNED BY "public"."course_reviews"."review_id";
SELECT setval('"public"."course_reviews_review_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."courses_course_id_seq"
OWNED BY "public"."courses"."course_id";
SELECT setval('"public"."courses_course_id_seq"', 8, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."enrollments_enrollment_id_seq"
OWNED BY "public"."enrollments"."enrollment_id";
SELECT setval('"public"."enrollments_enrollment_id_seq"', 7, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."exam_questions_question_id_seq"
OWNED BY "public"."exam_questions"."question_id";
SELECT setval('"public"."exam_questions_question_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."exam_results_result_id_seq"
OWNED BY "public"."exam_results"."result_id";
SELECT setval('"public"."exam_results_result_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."exams_exam_id_seq"
OWNED BY "public"."exams"."exam_id";
SELECT setval('"public"."exams_exam_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."lesson_completion_completion_id_seq"
OWNED BY "public"."lesson_completion"."completion_id";
SELECT setval('"public"."lesson_completion_completion_id_seq"', 23, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."lessons_lesson_id_seq"
OWNED BY "public"."lessons"."lesson_id";
SELECT setval('"public"."lessons_lesson_id_seq"', 22, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."online_attendance_attendance_id_seq"
OWNED BY "public"."online_attendance"."attendance_id";
SELECT setval('"public"."online_attendance_attendance_id_seq"', 49, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."register_company_regcom_id_seq"
OWNED BY "public"."register_company"."regcom_id";
SELECT setval('"public"."register_company_regcom_id_seq"', 4, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."student_registrations_registration_id_seq"
OWNED BY "public"."student_registrations"."registration_id";
SELECT setval('"public"."student_registrations_registration_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."students_student_id_seq"
OWNED BY "public"."students"."student_id";
SELECT setval('"public"."students_student_id_seq"', 3, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."subjects_subject_id_seq"
OWNED BY "public"."subjects"."subject_id";
SELECT setval('"public"."subjects_subject_id_seq"', 12, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."teachers_teacher_id_seq"
OWNED BY "public"."teachers"."teacher_id";
SELECT setval('"public"."teachers_teacher_id_seq"', 2, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."users_roles_role_id_seq"
OWNED BY "public"."users_roles"."role_id";
SELECT setval('"public"."users_roles_role_id_seq"', 46, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."users_user_id_seq"
OWNED BY "public"."users"."user_id";
SELECT setval('"public"."users_user_id_seq"', 10, true);

-- ----------------------------
-- Indexes structure for table assignment_submissions
-- ----------------------------
CREATE INDEX "idx_submissions_assignment" ON "public"."assignment_submissions" USING btree (
  "assignment_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_submissions_student" ON "public"."assignment_submissions" USING btree (
  "student_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table assignment_submissions
-- ----------------------------
ALTER TABLE "public"."assignment_submissions" ADD CONSTRAINT "assignment_submissions_assignment_id_student_id_key" UNIQUE ("assignment_id", "student_id");

-- ----------------------------
-- Checks structure for table assignment_submissions
-- ----------------------------
ALTER TABLE "public"."assignment_submissions" ADD CONSTRAINT "assignment_submissions_status_check" CHECK (status::text = ANY (ARRAY['Submitted'::character varying::text, 'Graded'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table assignment_submissions
-- ----------------------------
ALTER TABLE "public"."assignment_submissions" ADD CONSTRAINT "assignment_submissions_pkey" PRIMARY KEY ("submission_id");

-- ----------------------------
-- Indexes structure for table assignments
-- ----------------------------
CREATE INDEX "idx_assignments_course" ON "public"."assignments" USING btree (
  "course_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table assignments
-- ----------------------------
ALTER TABLE "public"."assignments" ADD CONSTRAINT "assignments_status_check" CHECK (status::text = ANY (ARRAY['Active'::character varying::text, 'Closed'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table assignments
-- ----------------------------
ALTER TABLE "public"."assignments" ADD CONSTRAINT "assignments_pkey" PRIMARY KEY ("assignment_id");

-- ----------------------------
-- Indexes structure for table course_reviews
-- ----------------------------
CREATE INDEX "idx_reviews_course" ON "public"."course_reviews" USING btree (
  "course_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table course_reviews
-- ----------------------------
ALTER TABLE "public"."course_reviews" ADD CONSTRAINT "course_reviews_course_id_student_id_key" UNIQUE ("course_id", "student_id");

-- ----------------------------
-- Checks structure for table course_reviews
-- ----------------------------
ALTER TABLE "public"."course_reviews" ADD CONSTRAINT "course_reviews_rating_check" CHECK (rating >= 1 AND rating <= 5);

-- ----------------------------
-- Primary Key structure for table course_reviews
-- ----------------------------
ALTER TABLE "public"."course_reviews" ADD CONSTRAINT "course_reviews_pkey" PRIMARY KEY ("review_id");

-- ----------------------------
-- Indexes structure for table courses
-- ----------------------------
CREATE INDEX "idx_courses_instructor" ON "public"."courses" USING btree (
  "teacher_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_courses_status" ON "public"."courses" USING btree (
  "status" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table courses
-- ----------------------------
ALTER TABLE "public"."courses" ADD CONSTRAINT "courses_course_code_key" UNIQUE ("course_code");

-- ----------------------------
-- Checks structure for table courses
-- ----------------------------
ALTER TABLE "public"."courses" ADD CONSTRAINT "courses_skill_level_check" CHECK (skill_level::text = ANY (ARRAY['Beginner'::character varying::text, 'Intermediate'::character varying::text, 'Advanced'::character varying::text, 'All Levels'::character varying::text]));
ALTER TABLE "public"."courses" ADD CONSTRAINT "courses_status_check" CHECK (status::text = ANY (ARRAY['Active'::character varying::text, 'Inactive'::character varying::text, 'Completed'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table courses
-- ----------------------------
ALTER TABLE "public"."courses" ADD CONSTRAINT "courses_pkey" PRIMARY KEY ("course_id");

-- ----------------------------
-- Indexes structure for table enrollments
-- ----------------------------
CREATE INDEX "idx_enrollments_course" ON "public"."enrollments" USING btree (
  "course_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_enrollments_student" ON "public"."enrollments" USING btree (
  "student_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table enrollments
-- ----------------------------
ALTER TABLE "public"."enrollments" ADD CONSTRAINT "enrollments_student_id_course_id_key" UNIQUE ("student_id", "course_id");

-- ----------------------------
-- Checks structure for table enrollments
-- ----------------------------
ALTER TABLE "public"."enrollments" ADD CONSTRAINT "enrollments_payment_status_check" CHECK (payment_status::text = ANY (ARRAY['Paid'::character varying::text, 'Pending'::character varying::text, 'Free'::character varying::text]));
ALTER TABLE "public"."enrollments" ADD CONSTRAINT "enrollments_completion_status_check" CHECK (completion_status::text = ANY (ARRAY['Not Started'::character varying::text, 'Ongoing'::character varying::text, 'Completed'::character varying::text, 'Dropped'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table enrollments
-- ----------------------------
ALTER TABLE "public"."enrollments" ADD CONSTRAINT "enrollments_pkey" PRIMARY KEY ("enrollment_id");

-- ----------------------------
-- Uniques structure for table exam_questions
-- ----------------------------
ALTER TABLE "public"."exam_questions" ADD CONSTRAINT "exam_questions_exam_id_question_number_key" UNIQUE ("exam_id", "question_number");

-- ----------------------------
-- Checks structure for table exam_questions
-- ----------------------------
ALTER TABLE "public"."exam_questions" ADD CONSTRAINT "exam_questions_question_type_check" CHECK (question_type::text = ANY (ARRAY['Multiple Choice'::character varying::text, 'True/False'::character varying::text, 'Short Answer'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table exam_questions
-- ----------------------------
ALTER TABLE "public"."exam_questions" ADD CONSTRAINT "exam_questions_pkey" PRIMARY KEY ("question_id");

-- ----------------------------
-- Indexes structure for table exam_results
-- ----------------------------
CREATE INDEX "idx_results_exam" ON "public"."exam_results" USING btree (
  "exam_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_results_student" ON "public"."exam_results" USING btree (
  "student_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table exam_results
-- ----------------------------
ALTER TABLE "public"."exam_results" ADD CONSTRAINT "exam_results_exam_id_student_id_key" UNIQUE ("exam_id", "student_id");

-- ----------------------------
-- Primary Key structure for table exam_results
-- ----------------------------
ALTER TABLE "public"."exam_results" ADD CONSTRAINT "exam_results_pkey" PRIMARY KEY ("result_id");

-- ----------------------------
-- Indexes structure for table exams
-- ----------------------------
CREATE INDEX "idx_exams_course" ON "public"."exams" USING btree (
  "course_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table exams
-- ----------------------------
ALTER TABLE "public"."exams" ADD CONSTRAINT "exams_status_check" CHECK (status::text = ANY (ARRAY['Scheduled'::character varying::text, 'Active'::character varying::text, 'Completed'::character varying::text]));
ALTER TABLE "public"."exams" ADD CONSTRAINT "exams_exam_type_check" CHECK (exam_type::text = ANY (ARRAY['Quiz'::character varying::text, 'Midterm'::character varying::text, 'Final'::character varying::text, 'Practice'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table exams
-- ----------------------------
ALTER TABLE "public"."exams" ADD CONSTRAINT "exams_pkey" PRIMARY KEY ("exam_id");

-- ----------------------------
-- Indexes structure for table lesson_completion
-- ----------------------------
CREATE INDEX "idx_completion_lesson" ON "public"."lesson_completion" USING btree (
  "lesson_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_completion_student" ON "public"."lesson_completion" USING btree (
  "student_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table lesson_completion
-- ----------------------------
CREATE TRIGGER "trg_update_enrollment_progress" AFTER INSERT OR UPDATE ON "public"."lesson_completion"
FOR EACH ROW
WHEN ((new.is_completed = true))
EXECUTE PROCEDURE "training_system_v5"."update_enrollment_progress"();

-- ----------------------------
-- Uniques structure for table lesson_completion
-- ----------------------------
ALTER TABLE "public"."lesson_completion" ADD CONSTRAINT "lesson_completion_lesson_id_student_id_key" UNIQUE ("lesson_id", "student_id");

-- ----------------------------
-- Primary Key structure for table lesson_completion
-- ----------------------------
ALTER TABLE "public"."lesson_completion" ADD CONSTRAINT "lesson_completion_pkey" PRIMARY KEY ("completion_id");

-- ----------------------------
-- Indexes structure for table lessons
-- ----------------------------
CREATE INDEX "idx_lessons_course" ON "public"."lessons" USING btree (
  "course_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_lessons_subject" ON "public"."lessons" USING btree (
  "subject_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table lessons
-- ----------------------------
ALTER TABLE "public"."lessons" ADD CONSTRAINT "lessons_subject_id_lesson_order_key" UNIQUE ("subject_id", "lesson_order");

-- ----------------------------
-- Checks structure for table lessons
-- ----------------------------
ALTER TABLE "public"."lessons" ADD CONSTRAINT "lessons_lesson_type_check" CHECK (lesson_type::text = ANY (ARRAY['Video'::character varying::text, 'Reading'::character varying::text, 'Quiz'::character varying::text, 'Assignment'::character varying::text, 'Practice'::character varying::text]));
ALTER TABLE "public"."lessons" ADD CONSTRAINT "lessons_status_check" CHECK (status::text = ANY (ARRAY['Active'::character varying::text, 'Inactive'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table lessons
-- ----------------------------
ALTER TABLE "public"."lessons" ADD CONSTRAINT "lessons_pkey" PRIMARY KEY ("lesson_id");

-- ----------------------------
-- Indexes structure for table online_attendance
-- ----------------------------
CREATE INDEX "idx_attendance_course" ON "public"."online_attendance" USING btree (
  "course_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_attendance_date" ON "public"."online_attendance" USING btree (
  "attendance_date" "pg_catalog"."date_ops" ASC NULLS LAST
);
CREATE INDEX "idx_attendance_student" ON "public"."online_attendance" USING btree (
  "student_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_attendance_teacher" ON "public"."online_attendance" USING btree (
  "teacher_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table online_attendance
-- ----------------------------
ALTER TABLE "public"."online_attendance" ADD CONSTRAINT "online_attendance_status_check" CHECK (status::text = ANY (ARRAY['Present'::character varying::text, 'Absent'::character varying::text]));
ALTER TABLE "public"."online_attendance" ADD CONSTRAINT "online_attendance_attendance_type_check" CHECK (attendance_type::text = ANY (ARRAY['Student'::character varying::text, 'Teacher'::character varying::text]));
ALTER TABLE "public"."online_attendance" ADD CONSTRAINT "chk_attendance_person" CHECK (student_id IS NOT NULL AND teacher_id IS NULL AND attendance_type::text = 'Student'::text OR teacher_id IS NOT NULL AND student_id IS NULL AND attendance_type::text = 'Teacher'::text);

-- ----------------------------
-- Primary Key structure for table online_attendance
-- ----------------------------
ALTER TABLE "public"."online_attendance" ADD CONSTRAINT "online_attendance_pkey" PRIMARY KEY ("attendance_id");

-- ----------------------------
-- Uniques structure for table register_company
-- ----------------------------
ALTER TABLE "public"."register_company" ADD CONSTRAINT "register_company_regcom_email_key" UNIQUE ("regcom_email");
ALTER TABLE "public"."register_company" ADD CONSTRAINT "register_company_admin_user_key" UNIQUE ("admin_user");

-- ----------------------------
-- Checks structure for table register_company
-- ----------------------------
ALTER TABLE "public"."register_company" ADD CONSTRAINT "register_company_status_check" CHECK (status::text = ANY (ARRAY['yes'::character varying::text, 'no'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table register_company
-- ----------------------------
ALTER TABLE "public"."register_company" ADD CONSTRAINT "register_company_pkey" PRIMARY KEY ("regcom_id");

-- ----------------------------
-- Indexes structure for table student_registrations
-- ----------------------------
CREATE INDEX "idx_reg_status" ON "public"."student_registrations" USING btree (
  "approval_status" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table student_registrations
-- ----------------------------
ALTER TABLE "public"."student_registrations" ADD CONSTRAINT "chk_gender" CHECK (gender::text = ANY (ARRAY['M'::character varying::text, 'F'::character varying::text]));
ALTER TABLE "public"."student_registrations" ADD CONSTRAINT "chk_approval_status" CHECK (approval_status::text = ANY (ARRAY['pending'::character varying::text, 'approved'::character varying::text, 'rejected'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table student_registrations
-- ----------------------------
ALTER TABLE "public"."student_registrations" ADD CONSTRAINT "student_registrations_pkey" PRIMARY KEY ("registration_id");

-- ----------------------------
-- Indexes structure for table students
-- ----------------------------
CREATE INDEX "idx_students_code" ON "public"."students" USING btree (
  "student_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_students_status" ON "public"."students" USING btree (
  "status" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table students
-- ----------------------------
ALTER TABLE "public"."students" ADD CONSTRAINT "students_user_id_key" UNIQUE ("user_id");
ALTER TABLE "public"."students" ADD CONSTRAINT "students_student_code_key" UNIQUE ("student_code");

-- ----------------------------
-- Checks structure for table students
-- ----------------------------
ALTER TABLE "public"."students" ADD CONSTRAINT "students_status_check" CHECK (status::text = ANY (ARRAY['Active'::character varying::text, 'Inactive'::character varying::text, 'Graduated'::character varying::text, 'Suspended'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table students
-- ----------------------------
ALTER TABLE "public"."students" ADD CONSTRAINT "students_pkey" PRIMARY KEY ("student_id");

-- ----------------------------
-- Indexes structure for table subjects
-- ----------------------------
CREATE INDEX "idx_subjects_course" ON "public"."subjects" USING btree (
  "course_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table subjects
-- ----------------------------
ALTER TABLE "public"."subjects" ADD CONSTRAINT "subjects_course_id_subject_order_key" UNIQUE ("course_id", "subject_order");

-- ----------------------------
-- Checks structure for table subjects
-- ----------------------------
ALTER TABLE "public"."subjects" ADD CONSTRAINT "subjects_status_check" CHECK (status::text = ANY (ARRAY['Active'::character varying::text, 'Inactive'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table subjects
-- ----------------------------
ALTER TABLE "public"."subjects" ADD CONSTRAINT "subjects_pkey" PRIMARY KEY ("subject_id");

-- ----------------------------
-- Indexes structure for table teachers
-- ----------------------------
CREATE INDEX "idx_teachers_code" ON "public"."teachers" USING btree (
  "teacher_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_teachers_status" ON "public"."teachers" USING btree (
  "status" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table teachers
-- ----------------------------
ALTER TABLE "public"."teachers" ADD CONSTRAINT "teachers_user_id_key" UNIQUE ("user_id");
ALTER TABLE "public"."teachers" ADD CONSTRAINT "teachers_teacher_code_key" UNIQUE ("teacher_code");

-- ----------------------------
-- Checks structure for table teachers
-- ----------------------------
ALTER TABLE "public"."teachers" ADD CONSTRAINT "teachers_status_check" CHECK (status::text = ANY (ARRAY['Active'::character varying::text, 'Inactive'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table teachers
-- ----------------------------
ALTER TABLE "public"."teachers" ADD CONSTRAINT "teachers_pkey" PRIMARY KEY ("teacher_id");

-- ----------------------------
-- Indexes structure for table users
-- ----------------------------
CREATE INDEX "idx_users_type" ON "public"."users" USING btree (
  "user_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_users_username" ON "public"."users" USING btree (
  "user_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_email_key" UNIQUE ("email");

-- ----------------------------
-- Checks structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_status_check" CHECK (status::text = ANY (ARRAY['yes'::character varying::text, 'no'::character varying::text]));
ALTER TABLE "public"."users" ADD CONSTRAINT "users_user_type_check" CHECK (user_type::text = ANY (ARRAY['super_admin'::character varying::text, 'admin'::character varying::text, 'teacher'::character varying::text, 'student'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("user_id");

-- ----------------------------
-- Indexes structure for table users_roles
-- ----------------------------
CREATE INDEX "idx_users_roles_user_id" ON "public"."users_roles" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table users_roles
-- ----------------------------
ALTER TABLE "public"."users_roles" ADD CONSTRAINT "users_roles_unique" UNIQUE ("user_id", "module_name");

-- ----------------------------
-- Primary Key structure for table users_roles
-- ----------------------------
ALTER TABLE "public"."users_roles" ADD CONSTRAINT "users_roles_pkey" PRIMARY KEY ("role_id");

-- ----------------------------
-- Foreign Keys structure for table assignment_submissions
-- ----------------------------
ALTER TABLE "public"."assignment_submissions" ADD CONSTRAINT "assignment_submissions_assignment_id_fkey" FOREIGN KEY ("assignment_id") REFERENCES "public"."assignments" ("assignment_id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."assignment_submissions" ADD CONSTRAINT "assignment_submissions_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students" ("student_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table assignments
-- ----------------------------
ALTER TABLE "public"."assignments" ADD CONSTRAINT "assignments_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses" ("course_id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."assignments" ADD CONSTRAINT "assignments_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."teachers" ("teacher_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table course_reviews
-- ----------------------------
ALTER TABLE "public"."course_reviews" ADD CONSTRAINT "course_reviews_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses" ("course_id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."course_reviews" ADD CONSTRAINT "course_reviews_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students" ("student_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table courses
-- ----------------------------
ALTER TABLE "public"."courses" ADD CONSTRAINT "courses_instructor_id_fkey" FOREIGN KEY ("teacher_id") REFERENCES "public"."teachers" ("teacher_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."courses" ADD CONSTRAINT "courses_regcom_id_fkey" FOREIGN KEY ("regcom_id") REFERENCES "public"."register_company" ("regcom_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table enrollments
-- ----------------------------
ALTER TABLE "public"."enrollments" ADD CONSTRAINT "enrollments_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses" ("course_id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."enrollments" ADD CONSTRAINT "enrollments_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students" ("student_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table exam_questions
-- ----------------------------
ALTER TABLE "public"."exam_questions" ADD CONSTRAINT "exam_questions_exam_id_fkey" FOREIGN KEY ("exam_id") REFERENCES "public"."exams" ("exam_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table exam_results
-- ----------------------------
ALTER TABLE "public"."exam_results" ADD CONSTRAINT "exam_results_exam_id_fkey" FOREIGN KEY ("exam_id") REFERENCES "public"."exams" ("exam_id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."exam_results" ADD CONSTRAINT "exam_results_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students" ("student_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table exams
-- ----------------------------
ALTER TABLE "public"."exams" ADD CONSTRAINT "exams_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses" ("course_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table lesson_completion
-- ----------------------------
ALTER TABLE "public"."lesson_completion" ADD CONSTRAINT "lesson_completion_lesson_id_fkey" FOREIGN KEY ("lesson_id") REFERENCES "public"."lessons" ("lesson_id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."lesson_completion" ADD CONSTRAINT "lesson_completion_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students" ("student_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table lessons
-- ----------------------------
ALTER TABLE "public"."lessons" ADD CONSTRAINT "lessons_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses" ("course_id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."lessons" ADD CONSTRAINT "lessons_subject_id_fkey" FOREIGN KEY ("subject_id") REFERENCES "public"."subjects" ("subject_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table online_attendance
-- ----------------------------
ALTER TABLE "public"."online_attendance" ADD CONSTRAINT "online_attendance_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses" ("course_id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."online_attendance" ADD CONSTRAINT "online_attendance_lesson_id_fkey" FOREIGN KEY ("lesson_id") REFERENCES "public"."lessons" ("lesson_id") ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE "public"."online_attendance" ADD CONSTRAINT "online_attendance_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students" ("student_id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."online_attendance" ADD CONSTRAINT "online_attendance_teacher_id_fkey" FOREIGN KEY ("teacher_id") REFERENCES "public"."teachers" ("teacher_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table student_registrations
-- ----------------------------
ALTER TABLE "public"."student_registrations" ADD CONSTRAINT "student_registrations_approved_by_fkey" FOREIGN KEY ("approved_by") REFERENCES "public"."users" ("user_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."student_registrations" ADD CONSTRAINT "student_registrations_regcom_id_fkey" FOREIGN KEY ("regcom_id") REFERENCES "public"."register_company" ("regcom_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table students
-- ----------------------------
ALTER TABLE "public"."students" ADD CONSTRAINT "students_regcom_id_fkey" FOREIGN KEY ("regcom_id") REFERENCES "public"."register_company" ("regcom_id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."students" ADD CONSTRAINT "students_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("user_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table subjects
-- ----------------------------
ALTER TABLE "public"."subjects" ADD CONSTRAINT "subjects_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses" ("course_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table teachers
-- ----------------------------
ALTER TABLE "public"."teachers" ADD CONSTRAINT "teachers_regcom_id_fkey" FOREIGN KEY ("regcom_id") REFERENCES "public"."register_company" ("regcom_id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."teachers" ADD CONSTRAINT "teachers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("user_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_regcom_id_fkey" FOREIGN KEY ("regcom_id") REFERENCES "public"."register_company" ("regcom_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table users_roles
-- ----------------------------
ALTER TABLE "public"."users_roles" ADD CONSTRAINT "users_roles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("user_id") ON DELETE CASCADE ON UPDATE NO ACTION;
