@echo off
SETLOCAL
SET P=%~dp0
java --enable-native-access=ALL-UNNAMED -cp "%P%target\classes;%P%lib\*" org.example.Main
ENDLOCAL
