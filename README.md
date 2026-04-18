# Reporting Project - Setup & Running Instructions

## Prerequisites

1. **Java 25** (or compatible version)
2. **PostgreSQL Database** running on `localhost:5432`
3. **Database**: `online_short_course_db` (or update `db.properties`)

---

## Step 1: Configure Database Connection

Edit `src\main\resources\db.properties` with your actual database credentials:

```properties
db.url=jdbc:postgresql://localhost:5432/your_database_name
db.username=your_username
db.password=your_password
db.driver=org.postgresql.Driver
```

**Important**: Never commit `db.properties` with real credentials to version control!

---

## Step 2: Build the Project

Run the build script from the project root directory:

```batch
build.bat
```

This will:
- Download required JAR dependencies to `lib/` folder
- Compile all Java source files
- Copy resources (`.jrxml` reports, `db.properties`) to `target/classes/`

**Expected output:**
```
Compiling Java sources...

============================
BUILD SUCCESSFUL
============================
```

---

## Step 3: Run the Application

### Option A: Run the GUI Application

```batch
run.bat
```

This launches the main dashboard with report generation UI.

### Option B: Run Tests (Command Line)

To verify all reports work correctly:

```batch
java -cp "target\classes;lib\*" org.example.TestReports
```

To test reports with filters:

```batch
java -cp "target\classes;lib\*" org.example.TestFilteredReports
```

---

## Available Reports

| # | Report Name | Type |
|---|-------------|------|
| 1 | Student Enrollment Report | Main (Flat detail with summary) |
| 2 | Course Performance Report | Grouped by Institute |
| 3 | Student Detail Report | Sub-Report |
| 4 | Attendance Cross-Tab Report | Matrix/Crosstab |
| 6 | Student Attendance Report | Flat detail |
| 7 | Exam & Assignment Report | Combined (UNION) |

---

## Troubleshooting

### Database Connection Failed

**Error**: `Cannot reach the database server`

**Solutions**:
1. Ensure PostgreSQL service is running
2. Verify `db.properties` has correct host, port, database name
3. Check username and password
4. Confirm firewall allows connections on port 5432

### Report Template Not Found

**Error**: `Report template not found: reports/xxx.jrxml`

**Solution**: Rebuild the project:
```batch
rmdir /S /Q target
build.bat
```

### FlatLaf Native Access Warning

**Warning**: `Use --enable-native-access=ALL-UNNAMED`

**Solution**: The `run.bat` script already includes this flag. If running manually:
```batch
java --enable-native-access=ALL-UNNAMED -cp "target\classes;lib\*" org.example.Main
```

### Reports Generate But Show No Data

**Cause**: Database tables are empty or filters are too restrictive

**Solution**: 
1. Check that your database has data in the required tables
2. Try generating reports without filters first
3. Use the test class to verify reports work without UI

---

## Project Structure

```
reporting-project/
├── src/
│   └── main/
│       ├── java/org/example/
│       │   ├── Main.java              # Application entry point
│       │   ├── model/
│       │   │   └── ReportType.java    # Report definitions
│       │   ├── service/
│       │   │   └── ReportGenerator.java  # Report generation logic
│       │   ├── ui/
│       │   │   ├── DashboardFrame.java   # Main UI
│       │   │   ├── ReportPreviewFrame.java  # Report viewer
│       │   │   └── FilterDialog.java     # Filter dialog
│       │   └── util/
│       │       └── DBConnection.java     # Database connection
│       └── resources/
│           ├── reports/                  # JRXML report templates
│           ├── db.properties             # Database config (create from example)
│           └── db.properties.example     # Template for db.properties
├── lib/                                  # JAR dependencies (auto-downloaded)
├── target/
│   └── classes/                          # Compiled output
├── build.bat                             # Build script
├── run.bat                               # Run script
└── README.md                             # This file
```

---

## Quick Test Checklist

Run these commands in order to verify everything works:

```batch
# 1. Build
build.bat

# 2. Test database connection and all reports
java -cp "target\classes;lib\*" org.example.TestReports

# 3. Test filtered reports
java -cp "target\classes;lib\*" org.example.TestFilteredReports

# 4. Launch GUI
run.bat
```

All tests should show `[PASS]` for every report.
