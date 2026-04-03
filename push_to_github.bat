@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title AfroCuisto Web - Push GitHub

echo.
echo  ==========================================
echo    AfroCuisto Web - Deploiement GitHub
echo  ==========================================
echo.

cd /d "d:\AfriHub\afrocuisto-web-site"

if not exist "vite.config.ts" (
    echo [ERREUR] Mauvais dossier. vite.config.ts introuvable.
    pause
    exit /b 1
)

echo [1/4] Fichiers modifies :
git status --short
echo.

git diff --quiet HEAD 2>nul
set CHANGED=%errorlevel%
git ls-files --others --exclude-standard > tmp_untracked.txt 2>nul
for %%F in (tmp_untracked.txt) do set SIZE=%%~zF
del tmp_untracked.txt >nul 2>nul

if %CHANGED%==0 if %SIZE%==0 (
    echo [INFO] Aucun changement. Tout est a jour !
    pause
    exit /b 0
)

echo [2/4] Message de commit (Entree = message par defaut) :
set "COMMIT_MSG="
set /p "COMMIT_MSG=  >>> "
if "!COMMIT_MSG!"=="" set "COMMIT_MSG=chore: mise a jour site web"

echo.
echo [3/4] Commit : !COMMIT_MSG!
git add -A
git commit -m "!COMMIT_MSG!"

if !errorlevel! neq 0 (
    echo [ERREUR] Commit echoue.
    pause
    exit /b 1
)

echo.
echo [4/4] Push vers GitHub...
git push origin main

if !errorlevel!==0 (
    echo.
    echo  OK - Push reussi ! Cloudflare va rebuilder automatiquement.
    echo  Suivi : https://dash.cloudflare.com
    echo.
) else (
    echo.
    echo [ERREUR] Push echoue. Verifiez vos credentials GitHub.
    echo.
)

pause