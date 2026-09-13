@echo off
REM ============================================================
REM  Shopizer 2.17.0 - Build & Run
REM  Build toan bo module va chay ung dung Spring Boot (sm-shop)
REM ============================================================
setlocal
cd /d "%~dp0"

echo.
echo [1/2] Building project (skip tests)...
call mvnw.cmd -pl sm-shop -am clean package -DskipTests
if errorlevel 1 (
    echo BUILD FAILED!
    pause
    exit /b 1
)

echo.
echo [2/2] Starting Shopizer (Spring Boot)...
echo Web: http://localhost:8080
echo Admin: http://localhost:8080/admin
echo.
call mvnw.cmd -pl sm-shop spring-boot:run -DskipTests

endlocal
