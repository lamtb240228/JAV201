@echo off
REM ========================================
REM Stop Tomcat Server
REM ========================================

set CATALINA_HOME=C:\apache-tomcat-10.1.50

if not exist "%CATALINA_HOME%" (
    echo [ERROR] Tomcat not found at %CATALINA_HOME%
    pause
    exit /b 1
)

echo ========================================
echo Stopping Tomcat 10.1.50
echo ========================================
echo.

call "%CATALINA_HOME%\bin\shutdown.bat"

echo.
echo [INFO] Tomcat shutdown initiated
echo [INFO] Wait a few seconds for complete shutdown
echo.
pause
