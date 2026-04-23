@echo off
REM ========================================
REM Build and Deploy Project
REM ========================================

echo ========================================
echo Building FPL_JAV201_Assignment
echo ========================================
echo.
echo [STEP 1/2] Cleaning and packaging...
echo.

call mvnw.cmd clean package -DskipTests

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Build failed!
    pause
    exit /b 1
)

echo.
echo [SUCCESS] Build complete!
echo.
echo WAR file location:
echo %CD%\target\FPL_JAV201_Assignment-1.0-SNAPSHOT.war
echo.

set CATALINA_HOME=C:\apache-tomcat-10.1.50

if exist "%CATALINA_HOME%" (
    echo [STEP 2/2] Copying WAR to Tomcat webapps...
    copy /Y "target\FPL_JAV201_Assignment-1.0-SNAPSHOT.war" "%CATALINA_HOME%\webapps\FPL_JAV201_Assignment.war"
    
    if %ERRORLEVEL% EQU 0 (
        echo [SUCCESS] Deployed to Tomcat!
        echo.
        echo If Tomcat is running, the app will auto-deploy in a few seconds
        echo Access: http://localhost:8080/FPL_JAV201_Assignment/home
    )
) else (
    echo [INFO] Tomcat not found at %CATALINA_HOME%
    echo [INFO] Run setup-tomcat.bat to install Tomcat
    echo [INFO] Or manually deploy the WAR file from target folder
)

echo.
echo ========================================
pause
