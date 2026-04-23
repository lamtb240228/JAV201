@echo off
REM ========================================
REM Start Tomcat Server
REM ========================================

set CATALINA_HOME=C:\apache-tomcat-10.1.50

if not exist "%CATALINA_HOME%" (
    echo [ERROR] Tomcat not found at %CATALINA_HOME%
    echo Please run setup-tomcat.bat first
    pause
    exit /b 1
)

echo ========================================
echo Starting Tomcat 10.1.50
echo ========================================
echo.
echo Server will start on: http://localhost:8080
echo Application URL: http://localhost:8080/FPL_JAV201_Assignment/home
echo.
echo Press Ctrl+C in the Tomcat window to stop
echo ========================================
echo.

REM Start Tomcat
call "%CATALINA_HOME%\bin\startup.bat"

echo.
echo [INFO] Tomcat is starting...
echo [INFO] Check the Tomcat console window for startup progress
echo [INFO] Wait 5-10 seconds, then open: http://localhost:8080/FPL_JAV201_Assignment/home
echo.
pause
