@echo off
color 0B
echo ===================================================
echo     CRIME PATTERN ANALYSIS SYSTEM - LAUNCHER
echo ===================================================
echo.
echo Preparing the application for the examiner...
echo.

REM Check if Node is installed
node -v >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js is not installed. Please install Node.js to run this application.
    pause
    exit
)

REM Check if Python is installed (required for ML)
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [WARNING] Python is not installed. Machine learning features might not work.
)

REM Build the frontend into a dist folder if it doesn't exist
IF NOT EXIST "dist\index.html" (
    echo [INFO] Building the frontend application. This may take a moment...
    powershell.exe -ExecutionPolicy Bypass -File .\deploy.ps1
) ELSE (
    echo [INFO] Frontend build found.
)

echo.
echo [INFO] Installing server dependencies...
cd server
call npm install

echo.
echo [INFO] Starting the Crime Analysis Server...
echo [INFO] A web browser window will open automatically.
echo.

REM Wait a couple of seconds, then open the browser
start "" http://localhost:5000

REM Start the Node server
node index.js

pause
