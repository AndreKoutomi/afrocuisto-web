@echo off
SETLOCAL EnableDelayedExpansion

:: --------------------------------------------------------------------------
:: SCRIPT DE DÉMARRAGE AFROCUISTO WEB SITE (HAUTE PERFORMANCE)
:: --------------------------------------------------------------------------

COLOR 0A
title AfroCuisto - Dev Server [Port 3010]

echo.
echo  ==============================================================
echo     DEMARRAGE DU SERVEUR DE DEVELOPPEMENT AFROCUISTO WEB
echo  ==============================================================
echo.

:: Chemin vers le site web
set SITE_DIR=afrocuisto-web-site

if not exist %SITE_DIR% (
    COLOR 0C
    echo [ERREUR] Dossier '%SITE_DIR%' introuvable.
    echo Assurez-vous d'executer ce script depuis la racine du projet.
    pause
    exit /b 1
)

cd %SITE_DIR%

echo [INFO] Verification des dependances...
if not exist node_modules (
    echo [ALERTE] 'node_modules' absent. Installation en cours...
    call npm install
)

echo.
echo [LANCEMENT] Demarrage de Vite sur le port 3010...
echo.

:: Execution du serveur dev
call npm run dev

if %ERRORLEVEL% neq 0 (
    COLOR 0C
    echo.
    echo [ERREUR] Le serveur s'est arrete de maniere inattendue.
    pause
)

ENDLOCAL
