@echo off
REM ============================================================
REM SAUVEGARDE AUTOMATIQUE PLANIFIEE - Oracle E-Commerce
REM Version corrigee - Avec gestion des erreurs
REM ============================================================
TITLE Sauvegarde Auto - Oracle E-Commerce

echo ========================================
echo SAUVEGARDE AUTOMATIQUE
echo ========================================

REM Format date sans wmic
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do (
    set jour=%%a
    set mois=%%b
    set annee=%%c
)

REM Enlever les espaces potentiels
set jour=%jour: =%
set mois=%mois: =%
set annee=%annee: =%

set DATE=%annee%%mois%%jour%
set LOG_DIR=C:\oracle\backup\logs
set BACKUP_DIR=C:\oracle\backup\auto\%DATE%

echo Date: %DATE%
echo Dossier backup: %BACKUP_DIR%
echo Dossier logs: %LOG_DIR%
echo.

REM Creation des dossiers
if not exist "%LOG_DIR%" (
    mkdir "%LOG_DIR%"
    echo Dossier logs cree
)
if not exist "%BACKUP_DIR%" (
    mkdir "%BACKUP_DIR%"
    echo Dossier backup cree
)

set LOG_FILE=%LOG_DIR%\backup_auto_%DATE%.log

echo ======================================== >> "%LOG_FILE%"
echo [%DATE%] Debut sauvegarde auto >> "%LOG_FILE%"
echo ======================================== >> "%LOG_FILE%"

REM ============================================================
REM 1. Sauvegarde RMAN (chaud)
REM ============================================================
echo [%DATE%] Sauvegarde RMAN en cours... >> "%LOG_FILE%"
echo [%DATE%] Sauvegarde RMAN en cours...
(
echo CONNECT TARGET /
echo BACKUP DATABASE PLUS ARCHIVELOG FORMAT '%BACKUP_DIR%\hot_%%U.bkp';
echo BACKUP CURRENT CONTROLFILE FORMAT '%BACKUP_DIR%\control_%%U.bkp';
echo DELETE NOPROMPT ARCHIVELOG ALL BACKED UP 1 TIMES TO DISK;
echo EXIT;
) | rman >> "%LOG_FILE%" 2>&1

if %ERRORLEVEL% EQU 0 (
    echo [%DATE%] Sauvegarde RMAN reussie >> "%LOG_FILE%"
    echo [%DATE%] Sauvegarde RMAN reussie
) else (
    echo [%DATE%] ERREUR sauvegarde RMAN (code: %ERRORLEVEL%) >> "%LOG_FILE%"
    echo [%DATE%] ERREUR sauvegarde RMAN
)

REM ============================================================
REM 2. Export Data Pump
REM ============================================================
echo [%DATE%] Export Data Pump en cours... >> "%LOG_FILE%"
echo [%DATE%] Export Data Pump en cours...

REM Verifier que le repertoire existe
sqlplus -S ecom/123@//localhost:1521/XEPDB1 @backup_config.sql > nul

expdp ecom/123@//localhost:1521/XEPDB1 ^
      DIRECTORY=DATA_PUMP_DIR ^
      DUMPFILE=auto_export_%DATE%.dmp ^
      LOGFILE=auto_export_%DATE%.log ^
      SCHEMAS=ecom ^
      COMPRESSION=ALL >> "%LOG_FILE%" 2>&1

if %ERRORLEVEL% EQU 0 (
    echo [%DATE%] Export Data Pump reussi >> "%LOG_FILE%"
    echo [%DATE%] Export Data Pump reussi
) else (
    echo [%DATE%] ERREUR Export Data Pump (code: %ERRORLEVEL%) >> "%LOG_FILE%"
    echo [%DATE%] ERREUR Export Data Pump
)

REM ============================================================
REM 3. Nettoyage des sauvegardes de plus de 30 jours
REM ============================================================
echo [%DATE%] Nettoyage des anciennes sauvegardes... >> "%LOG_FILE%"
echo [%DATE%] Nettoyage des anciennes sauvegardes...

if exist "C:\oracle\backup\auto" (
    forfiles /p C:\oracle\backup\auto /s /m *.* /d -30 /c "cmd /c del @file" >> "%LOG_FILE%" 2>&1
    echo [%DATE%] Nettoyage termine >> "%LOG_FILE%"
) else (
    echo [%DATE%] Dossier auto non trouve >> "%LOG_FILE%"
)

REM ============================================================
REM Fin
REM ============================================================
echo ======================================== >> "%LOG_FILE%"
echo [%DATE%] Sauvegarde automatique terminee >> "%LOG_FILE%"
echo ======================================== >> "%LOG_FILE%"

echo.
echo ========================================
echo SAUVEGARDE TERMINEE
echo ========================================
echo Log: %LOG_FILE%
echo.
pause