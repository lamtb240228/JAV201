@echo off
REM ========================================
REM Tomcat 10.1.50 Setup Script
REM ========================================

setlocal enabledelayedexpansion

set TOMCAT_VERSION=10.1.50
set TOMCAT_DIR=C:\apache-tomcat-%TOMCAT_VERSION%
set DOWNLOAD_URL=https://archive.apache.org/dist/tomcat/tomcat-10/v%TOMCAT_VERSION%/bin/apache-tomcat-%TOMCAT_VERSION%-windows-x64.zip
set TEMP_ZIP=%TEMP%\apache-tomcat-%TOMCAT_VERSION%.zip

echo ========================================
echo Tomcat 10.1.50 Setup
echo ========================================
echo.

REM Check if Tomcat already exists
if exist "%TOMCAT_DIR%" (
    echo [INFO] Tomcat 10.1.50 already installed at %TOMCAT_DIR%
    echo.
    goto :configure
)

echo [STEP 1/4] Downloading Tomcat 10.1.50...
echo URL: %DOWNLOAD_URL%
echo.

REM Download using PowerShell
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%TEMP_ZIP%' -UseBasicParsing}"

if not exist "%TEMP_ZIP%" (
    echo [ERROR] Failed to download Tomcat
    pause
    exit /b 1
)

echo [SUCCESS] Download complete
echo.

echo [STEP 2/4] Extracting Tomcat...
powershell -Command "Expand-Archive -Path '%TEMP_ZIP%' -DestinationPath 'C:\' -Force"

REM Rename extracted folder
if exist "C:\apache-tomcat-%TOMCAT_VERSION%" (
    echo [SUCCESS] Tomcat extracted to %TOMCAT_DIR%
) else (
    echo [ERROR] Extraction failed
    pause
    exit /b 1
)

REM Clean up
del "%TEMP_ZIP%"
echo.

:configure
echo [STEP 3/4] Configuring Tomcat for Jakarta EE...

REM Set CATALINA_HOME
setx CATALINA_HOME "%TOMCAT_DIR%" >nul 2>&1

REM Create setenv.bat for Java options
(
echo @echo off
echo set "JAVA_OPTS=-Dfile.encoding=UTF-8 -Xms512m -Xmx1024m"
echo set "CATALINA_OPTS=-Dfile.encoding=UTF-8"
) > "%TOMCAT_DIR%\bin\setenv.bat"

echo [SUCCESS] Environment configured
echo.

echo [STEP 4/4] Setting up project deployment...

REM Create context.xml for auto-deployment
set CONTEXT_DIR=%TOMCAT_DIR%\conf\Catalina\localhost
if not exist "%CONTEXT_DIR%" mkdir "%CONTEXT_DIR%"

(
echo ^<?xml version="1.0" encoding="UTF-8"?^>
echo ^<Context path="/FPL_JAV201_Assignment" docBase="%CD%\target\FPL_JAV201_Assignment-1.0-SNAPSHOT" reloadable="true"^>
echo     ^<WatchedResource^>WEB-INF/web.xml^</WatchedResource^>
echo     ^<WatchedResource^>WEB-INF/classes/^</WatchedResource^>
echo ^</Context^>
) > "%CONTEXT_DIR%\FPL_JAV201_Assignment.xml"

echo [SUCCESS] Deployment configured
echo.

echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Tomcat Location: %TOMCAT_DIR%
echo CATALINA_HOME: %TOMCAT_DIR%
echo.
echo Next steps:
echo 1. Build your project: mvnw.cmd clean package
echo 2. Start Tomcat: %TOMCAT_DIR%\bin\startup.bat
echo 3. Access: http://localhost:8080/FPL_JAV201_Assignment/home
echo.
echo Or use the provided scripts:
echo - build.bat (to build the project)
echo - start-tomcat.bat (to start Tomcat)
echo - stop-tomcat.bat (to stop Tomcat)
echo ========================================
pause
