@echo off
SETLOCAL

SET PROJ=d:\r\SU-35-Y3-S2\JAVA-II\final\reporting-project
SET LIB=%PROJ%\lib
SET SRC=%PROJ%\src\main\java
SET RES=%PROJ%\src\main\resources
SET OUT=%PROJ%\target\classes

if not exist "%LIB%" mkdir "%LIB%"
if not exist "%OUT%" mkdir "%OUT%"

call :dl jasperreports-6.21.3.jar https://repo1.maven.org/maven2/net/sf/jasperreports/jasperreports/6.21.3/jasperreports-6.21.3.jar
call :dl jasperreports-fonts-6.21.3.jar https://repo1.maven.org/maven2/net/sf/jasperreports/jasperreports-fonts/6.21.3/jasperreports-fonts-6.21.3.jar
call :dl postgresql-42.7.7.jar https://repo1.maven.org/maven2/org/postgresql/postgresql/42.7.7/postgresql-42.7.7.jar
call :dl flatlaf-3.5.jar https://repo1.maven.org/maven2/com/formdev/flatlaf/3.5/flatlaf-3.5.jar
call :dl commons-digester-2.1.jar https://repo1.maven.org/maven2/commons-digester/commons-digester/2.1/commons-digester-2.1.jar
call :dl commons-collections4-4.4.jar https://repo1.maven.org/maven2/org/apache/commons/commons-collections4/4.4/commons-collections4-4.4.jar
call :dl commons-logging-1.3.5.jar https://repo1.maven.org/maven2/commons-logging/commons-logging/1.3.5/commons-logging-1.3.5.jar
call :dl commons-beanutils-1.11.0.jar https://repo1.maven.org/maven2/commons-beanutils/commons-beanutils/1.11.0/commons-beanutils-1.11.0.jar
call :dl itext-2.1.7.jar https://repo1.maven.org/maven2/com/github/librepdf/openpdf/1.3.30/openpdf-1.3.30.jar
call :dl pdfbox-2.0.32.jar https://repo1.maven.org/maven2/org/apache/pdfbox/pdfbox/2.0.32/pdfbox-2.0.32.jar
call :dl fontbox-2.0.32.jar https://repo1.maven.org/maven2/org/apache/pdfbox/fontbox/2.0.32/fontbox-2.0.32.jar
call :dl commons-io-2.16.1.jar https://repo1.maven.org/maven2/commons-io/commons-io/2.16.1/commons-io-2.16.1.jar
call :dl poi-5.3.0.jar https://repo1.maven.org/maven2/org/apache/poi/poi/5.3.0/poi-5.3.0.jar
call :dl poi-ooxml-5.3.0.jar https://repo1.maven.org/maven2/org/apache/poi/poi-ooxml/5.3.0/poi-ooxml-5.3.0.jar
call :dl poi-ooxml-lite-5.3.0.jar https://repo1.maven.org/maven2/org/apache/poi/poi-ooxml-lite/5.3.0/poi-ooxml-lite-5.3.0.jar
call :dl commons-compress-1.27.1.jar https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.27.1/commons-compress-1.27.1.jar
call :dl xmlbeans-5.2.1.jar https://repo1.maven.org/maven2/org/apache/xmlbeans/xmlbeans/5.2.1/xmlbeans-5.2.1.jar
call :dl curvesapi-1.08.jar https://repo1.maven.org/maven2/com/github/virtuald/curvesapi/1.08/curvesapi-1.08.jar
call :dl SparseBitSet-1.3.jar https://repo1.maven.org/maven2/com/zaxxer/SparseBitSet/1.3/SparseBitSet-1.3.jar
call :dl bcpkix-jdk18on-1.78.jar https://repo1.maven.org/maven2/org/bouncycastle/bcpkix-jdk18on/1.78/bcpkix-jdk18on-1.78.jar
call :dl bcprov-jdk18on-1.78.jar https://repo1.maven.org/maven2/org/bouncycastle/bcprov-jdk18on/1.78/bcprov-jdk18on-1.78.jar

SET CP=%LIB%\jasperreports-6.21.3.jar;%LIB%\jasperreports-fonts-6.21.3.jar;%LIB%\commons-digester-2.1.jar;%LIB%\commons-collections4-4.4.jar;%LIB%\commons-logging-1.3.5.jar;%LIB%\commons-beanutils-1.11.0.jar;%LIB%\itext-2.1.7.jar;%LIB%\pdfbox-2.0.32.jar;%LIB%\fontbox-2.0.32.jar;%LIB%\commons-io-2.16.1.jar;%LIB%\poi-5.3.0.jar;%LIB%\poi-ooxml-5.3.0.jar;%LIB%\poi-ooxml-lite-5.3.0.jar;%LIB%\commons-compress-1.27.1.jar;%LIB%\xmlbeans-5.2.1.jar;%LIB%\curvesapi-1.08.jar;%LIB%\SparseBitSet-1.3.jar;%LIB%\bcpkix-jdk18on-1.78.jar;%LIB%\bcprov-jdk18on-1.78.jar;%LIB%\postgresql-42.7.7.jar;%LIB%\flatlaf-3.5.jar

echo Compiling Java sources...
REM Compile all Java sources recursively
javac -encoding UTF-8 -source 25 -target 25 -cp "%CP%" -d "%OUT%" -sourcepath "%SRC%" ^
  "%SRC%\org\example\Main.java" ^
  "%SRC%\org\example\model\ReportType.java" ^
  "%SRC%\org\example\util\DBConnection.java" ^
  "%SRC%\org\example\service\ReportGenerator.java" ^
  "%SRC%\org\example\ui\DashboardFrame.java" ^
  "%SRC%\org\example\ui\ReportPreviewFrame.java" ^
  "%SRC%\org\example\ui\FilterDialog.java" ^
  "%SRC%\org\example\TestReports.java" ^
  "%SRC%\org\example\TestPdfExport.java" ^
  "%SRC%\org\example\TestFilteredReports.java" ^
  "%SRC%\org\example\TestAllReports.java"

if %ERRORLEVEL% EQU 0 (
    xcopy /E /I /Y "%RES%\*" "%OUT%\" >nul
    echo.
    echo ============================
    echo BUILD SUCCESSFUL
    echo ============================
) else (
    echo.
    echo ============================
    echo BUILD FAILED
    echo ============================
)
ENDLOCAL
goto :eof

:dl
if not exist "%LIB%\%~1" (
    echo Downloading %~1...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%~2' -OutFile '%LIB%\%~1'"
)
goto :eof
