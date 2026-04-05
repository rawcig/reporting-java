@echo off
SETLOCAL
SET PROJECT_DIR=%~dp0
SET CP=%PROJECT_DIR%target\classes;%PROJECT_DIR%lib\jasperreports-6.21.3.jar;%PROJECT_DIR%lib\jasperreports-fonts-6.21.3.jar;%PROJECT_DIR%lib\commons-digester-2.1.jar;%PROJECT_DIR%lib\commons-collections4-4.4.jar;%PROJECT_DIR%lib\commons-logging-1.3.5.jar;%PROJECT_DIR%lib\commons-beanutils-1.11.0.jar;%PROJECT_DIR%lib\postgresql-42.7.7.jar;%PROJECT_DIR%lib\flatlaf-3.5.jar
java -cp "%CP%" org.example.Main
ENDLOCAL
