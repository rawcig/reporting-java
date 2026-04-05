@echo off
REM Download dependencies from Maven Central and compile
SETLOCAL

SET PROJECT_DIR=d:\r\SU-35-Y3-S2\JAVA-II\final\reporting-project
SET LIB_DIR=%PROJECT_DIR%\lib
SET SRC_DIR=%PROJECT_DIR%\src\main\java
SET RES_DIR=%PROJECT_DIR%\src\main\resources
SET OUT_DIR=%PROJECT_DIR%\target\classes

REM Create lib and output directories
if not exist "%LIB_DIR%" mkdir "%LIB_DIR%"
if not exist "%OUT_DIR%" mkdir "%OUT_DIR%"

REM Download JARs if not present
if not exist "%LIB_DIR%\jasperreports-6.21.3.jar" (
    echo Downloading jasperreports...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/net/sf/jasperreports/jasperreports/6.21.3/jasperreports-6.21.3.jar' -OutFile '%LIB_DIR%\jasperreports-6.21.3.jar'"
)

if not exist "%LIB_DIR%\jasperreports-fonts-6.21.3.jar" (
    echo Downloading jasperreports-fonts...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/net/sf/jasperreports/jasperreports-fonts/6.21.3/jasperreports-fonts-6.21.3.jar' -OutFile '%LIB_DIR%\jasperreports-fonts-6.21.3.jar'"
)

if not exist "%LIB_DIR%\postgresql-42.7.7.jar" (
    echo Downloading postgresql jdbc...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/org/postgresql/postgresql/42.7.7/postgresql-42.7.7.jar' -OutFile '%LIB_DIR%\postgresql-42.7.7.jar'"
)

if not exist "%LIB_DIR%\flatlaf-3.5.jar" (
    echo Downloading flatlaf...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/com/formdev/flatlaf/3.5/flatlaf-3.5.jar' -OutFile '%LIB_DIR%\flatlaf-3.5.jar'"
)

if not exist "%LIB_DIR%\commons-digester-2.1.jar" (
    echo Downloading commons-digester...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/commons-digester/commons-digester/2.1/commons-digester-2.1.jar' -OutFile '%LIB_DIR%\commons-digester-2.1.jar'"
)

if not exist "%LIB_DIR%\commons-collections4-4.4.jar" (
    echo Downloading commons-collections4...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/org/apache/commons/commons-collections4/4.4/commons-collections4-4.4.jar' -OutFile '%LIB_DIR%\commons-collections4-4.4.jar'"
)

if not exist "%LIB_DIR%\commons-logging-1.3.5.jar" (
    echo Downloading commons-logging...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/commons-logging/commons-logging/1.3.5/commons-logging-1.3.5.jar' -OutFile '%LIB_DIR%\commons-logging-1.3.5.jar'"
)

if not exist "%LIB_DIR%\commons-beanutils-1.11.0.jar" (
    echo Downloading commons-beanutils...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/commons-beanutils/commons-beanutils/1.11.0/commons-beanutils-1.11.0.jar' -OutFile '%LIB_DIR%\commons-beanutils-1.11.0.jar'"
)

REM Build classpath
SET CP=%LIB_DIR%\jasperreports-6.21.3.jar;%LIB_DIR%\jasperreports-fonts-6.21.3.jar;%LIB_DIR%\commons-digester-2.1.jar;%LIB_DIR%\commons-collections4-4.4.jar;%LIB_DIR%\commons-logging-1.3.5.jar;%LIB_DIR%\commons-beanutils-1.11.0.jar;%LIB_DIR%\postgresql-42.7.7.jar;%LIB_DIR%\flatlaf-3.5.jar

REM Compile
echo Compiling Java sources...
javac -encoding UTF-8 -source 25 -target 25 -cp "%CP%" -d "%OUT_DIR%" -sourcepath "%SRC_DIR%" "%SRC_DIR%\org\example\Main.java" "%SRC_DIR%\org\example\model\ReportType.java" "%SRC_DIR%\org\example\util\DBConnection.java" "%SRC_DIR%\org\example\service\ReportGenerator.java" "%SRC_DIR%\org\example\ui\DashboardFrame.java"

if %ERRORLEVEL% EQU 0 (
    REM Copy resources
    xcopy /E /I /Y "%RES_DIR%\*" "%OUT_DIR%\"
    echo.
    echo ============================
    echo BUILD SUCCESSFUL
    echo ============================
    echo To run: java -cp "%OUT_DIR%;%CP%" org.example.Main
) else (
    echo.
    echo ============================
    echo BUILD FAILED
    echo ============================
)

ENDLOCAL
