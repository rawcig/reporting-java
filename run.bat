@echo off
SETLOCAL
SET P=%~dp0

:MENU
cls
echo ╔══════════════════════════════════════════════════════════╗
echo ║         TRAINING MANAGEMENT - REPORTING SYSTEM          ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo Please select an option:
echo.
echo   [1] Run Dashboard Application (Main UI)
echo   [2] Run All Report Tests (Generate + Export)
echo   [3] Run Basic Report Generation Test
echo   [4] Run Filtered Report Test
echo   [5] Run PDF Export Test
echo   [6] Clean and Rebuild
echo   [7] Exit
echo.
echo ────────────────────────────────────────────────────────────
set /p choice="Enter your choice (1-7): "

if "%choice%"=="1" goto RUN_APP
if "%choice%"=="2" goto RUN_ALL_TESTS
if "%choice%"=="3" goto RUN_BASIC_TEST
if "%choice%"=="4" goto RUN_FILTERED_TEST
if "%choice%"=="5" goto RUN_PDF_TEST
if "%choice%"=="6" goto REBUILD
if "%choice%"=="7" goto EXIT

echo Invalid choice! Please try again.
timeout /t 2 /nobreak >nul
goto MENU

:RUN_APP
cls
echo Starting Dashboard Application...
echo.
java --enable-native-access=ALL-UNNAMED -cp "%P%target\classes;%P%lib\*" org.example.Main
goto MENU

:RUN_ALL_TESTS
cls
echo ════════════════════════════════════════════════════════════
echo   COMPREHENSIVE REPORT TEST
echo   - Generate all reports
echo   - Export to PDF
echo   - Export to Excel
echo   - Export to HTML
echo ════════════════════════════════════════════════════════════
echo.
java --enable-native-access=ALL-UNNAMED -cp "%P%target\classes;%P%lib\*" org.example.TestAllReports
echo.
pause
goto MENU

:RUN_BASIC_TEST
cls
echo ════════════════════════════════════════════════════════════
echo   BASIC REPORT GENERATION TEST
echo ════════════════════════════════════════════════════════════
echo.
java --enable-native-access=ALL-UNNAMED -cp "%P%target\classes;%P%lib\*" org.example.TestReports
echo.
pause
goto MENU

:RUN_FILTERED_TEST
cls
echo ════════════════════════════════════════════════════════════
echo   FILTERED REPORT TEST
echo ════════════════════════════════════════════════════════════
echo.
java --enable-native-access=ALL-UNNAMED -cp "%P%target\classes;%P%lib\*" org.example.TestFilteredReports
echo.
pause
goto MENU

:RUN_PDF_TEST
cls
echo ════════════════════════════════════════════════════════════
echo   PDF EXPORT TEST
echo ════════════════════════════════════════════════════════════
echo.
java --enable-native-access=ALL-UNNAMED -cp "%P%target\classes;%P%lib\*" org.example.TestPdfExport
echo.
pause
goto MENU

:REBUILD
cls
echo ════════════════════════════════════════════════════════════
echo   CLEAN AND REBUILD
echo ════════════════════════════════════════════════════════════
echo.
echo Cleaning old compiled reports...
rmdir /s /q "%P%target\classes\reports" 2>nul
rmdir /s /q "%P%target\classes\org" 2>nul
del /q "%P%target\classes\*.class" 2>nul
echo.
call "%P%build.bat"
echo.
echo Build completed!
pause
goto MENU

:EXIT
cls
echo Goodbye!
timeout /t 1 /nobreak >nul
exit /b 0
