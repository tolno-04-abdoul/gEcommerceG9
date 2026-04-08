@echo off
REM ============================================================
REM SAUVEGARDE A CHAUD - RMAN (Date au format YYYY-MM-DD)
REM Version corrigee
REM ============================================================
TITLE Sauvegarde a chaud - Oracle E-Commerce

echo ========================================
echo SAUVEGARDE A CHAUD - RMAN
echo ========================================
echo.

REM Récupérer la date au format YYYY-MM-DD
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do (
    set jour=%%a
    set mois=%%b
    set annee=%%c
)

REM Supprimer les espaces potentiels
set jour=%jour: =%
set mois=%mois: =%
set annee=%annee: =%

REM Corriger si jour/mois sont sur 1 chiffre
if %jour:~0,1%==0 set jour=%jour:~1%
if %mois:~0,1%==0 set mois=%mois:~1%

set DATE=%annee%-%mois%-%jour%
set BACKUP_DIR=C:\oracle\backup\hot\%DATE%

echo Date: %DATE%
echo Dossier: %BACKUP_DIR%
echo.

REM Créer le dossier si nécessaire
if not exist "%BACKUP_DIR%" (
    mkdir "%BACKUP_DIR%"
    echo Dossier cree
    echo.
)

REM Script RMAN
(
echo CONNECT TARGET /
echo BACKUP DATABASE PLUS ARCHIVELOG FORMAT '%BACKUP_DIR%\hot_%DATE%_%%U.bkp';
echo BACKUP CURRENT CONTROLFILE FORMAT '%BACKUP_DIR%\ctrl_hot_%DATE%.bkp';
echo DELETE NOPROMPT ARCHIVELOG ALL BACKED UP 1 TIMES TO DISK;
echo EXIT;
) | rman

echo.
echo ========================================
echo SAUVEGARDE TERMINEE
echo ========================================
pause