@echo off
echo ============================================
echo   Hybrid AI Dispatch - Quick Setup
echo ============================================
echo.
echo This script will help you install Node.js and start the dashboard.
echo.
echo Step 1: Install Node.js
echo ----------------------
echo Please follow these steps:
echo.
echo 1. Open your web browser
echo 2. Go to: https://nodejs.org/
echo 3. Click "Download Node.js (LTS)" - the big green button
echo 4. Run the downloaded installer (node-v20.x.x-x64.msi)
echo 5. Click "Next" through the installer
echo 6. IMPORTANT: Make sure "Add to PATH" is checked
echo 7. Click "Install"
echo 8. Close this window and open a NEW Command Prompt
echo.
echo Step 2: After Node.js is installed
echo -----------------------------------
echo Open a NEW Command Prompt and run:
echo.
echo   cd "C:\AI System Dispatcher"
echo   npm install
echo   npm run dev
echo.
echo Then open your browser to: http://localhost:3000
echo.
echo ============================================
echo Press any key to open the Node.js download page...
pause
start https://nodejs.org/
