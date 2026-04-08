@echo off
REM ============================================================
REM EXPORT DATA PUMP - E-COMMERCE
REM Version corrigee - Avec gestion des erreurs
REM ============================================================
TITLE Export Data Pump - Oracle E-Commerce

echo ========================================
echo EXPORT DATA PUMP
echo ========================================
echo.

REM Format date sans wmic
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do (
    set jour=%%a
    set mois=%%b
    set annee=%%c
)

REM Supprimer les espaces potentiels
set jour=%jour: =%
set mois=%mois: =%
set annee=%annee: =%

set DATE=%annee%%mois%%jour%

echo Date: %DATE%
echo.

REM Créer le repertoire Oracle si non existant
echo Configuration du repertoire Data Pump...
sqlplus -S / as sysdba @backup_config.sql > nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Repertoire DATA_PUMP_DIR configure
) else (
    echo ERREUR: Configuration du repertoire
)

echo.
echo Export en cours...

REM Export
expdp ecom/123@//localhost:1521/XEPDB1 ^
      DIRECTORY=DATA_PUMP_DIR ^
      DUMPFILE=ecommerce_export_%DATE%.dmp ^
      LOGFILE=export_%DATE%.log ^
      SCHEMAS=ecom ^
      COMPRESSION=ALL

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo EXPORT REUSSI !
    echo ========================================
    echo Fichier: ecommerce_export_%DATE%.dmp
    echo Log: export_%DATE%.log
) else (
    echo.
    echo ========================================
    echo ERREUR DURANT L'EXPORT
    echo ========================================
    echo Veuillez consulter export_%DATE%.log
)

echo.
pause