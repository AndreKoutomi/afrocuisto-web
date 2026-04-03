@echo off
title AfroCuisto - Site Web (port 3010)
color 0E

echo ============================================
echo    AFROCUISTO - SITE WEB VITRINE
echo    Demarrage du serveur de developpement...
echo    Port : http://localhost:3010
echo ============================================
echo.

cd /d "%~dp0"

echo Verification des dependances...
if not exist "node_modules" (
    echo Installation des dependances npm...
    npm install
    echo.
)

echo Lancement du serveur Vite...
echo.
npm run dev

pause
