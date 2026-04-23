@echo off
REM ========================================
REM Complete Development Workflow
REM ========================================

echo ========================================
echo FPL_JAV201_Assignment - Dev Workflow
echo ========================================
echo.

:menu
echo Choose an option:
echo.
echo [1] Setup Tomcat 10.1.50 (First time only)
echo [2] Build and Deploy
echo [3] Start Tomcat (Normal Mode)
echo [4] Start Tomcat (Debug Mode - Port 8000)
echo [5] Stop Tomcat
echo [6] View Logs
echo [7] Clean Build
echo [8] Open Application in Browser
echo [9] Exit
echo.
set /p choice="Enter your choice (1-9): "

if "%choice%"=="1" goto setup
if "%choice%"=="2" goto build
if "%choice%"=="3" goto start
if "%choice%"=="4" goto debug
if "%choice%"=="5" goto stop
if "%choice%"=="6" goto logs
if "%choice%"=="7" goto clean
if "%choice%"=="8" goto browser
if "%choice%"=="9" goto end

echo Invalid choice. Please try again.
echo.
goto menu

:setup
echo.
echo Running Tomcat setup...
call setup-tomcat.bat
goto menu

:build
echo.
echo Building and deploying...
call build-and-deploy.bat
goto menu

:start
echo.
echo Starting Tomcat (Normal Mode)...
call start-tomcat.bat
goto menu

:debug
echo.
echo Starting Tomcat (Debug Mode on port 8000)...
echo.
echo After Tomcat starts:
echo 1. Open VS Code
echo 2. Press F5
echo 3. Select "Debug Tomcat (Attach)"
echo.
set CATALINA_HOME=C:\apache-tomcat-10.1.50
if exist "%CATALINA_HOME%\bin\catalina.bat" (
    call "%CATALINA_HOME%\bin\catalina.bat" jpda start
) else (
    echo [ERROR] Tomcat not found. Run option 1 first.
    pause
)
goto menu

:stop
echo.
echo Stopping Tomcat...
call stop-tomcat.bat
goto menu

:logs
echo.
echo Opening logs directory...
set CATALINA_HOME=C:\apache-tomcat-10.1.50
if exist "%CATALINA_HOME%\logs" (
    explorer "%CATALINA_HOME%\logs"
    echo.
    echo Latest log file:
    dir /b /o-d "%CATALINA_HOME%\logs\*.log" | findstr /n "^" | findstr "^1:"
) else (
    echo [ERROR] Tomcat not found. Run option 1 first.
    pause
)
goto menu

:clean
echo.
echo Cleaning project...
call mvnw.cmd clean
echo.
echo Clean complete!
pause
goto menu

:browser
echo.
echo Opening application in browser...
start http://localhost:8080/FPL_JAV201_Assignment/home
goto menu

:end
echo.
echo Goodbye!
exit /b 0
