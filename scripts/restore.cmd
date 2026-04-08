@echo off
REM ============================================================
REM RESTAURATION COMPLETE - RMAN
REM Version corrigee - Oracle E-Commerce
REM ============================================================
TITLE Restauration - Oracle E-Commerce

echo ========================================
echo RESTAURATION COMPLETE - RMAN
echo ========================================
echo.
echo ATTENTION : Cette operation va effacer toutes les donnees actuelles !
echo.

set /p CONFIRM="Etes-vous certain de vouloir continuer ? (O/N): "
if /i not "%CONFIRM%"=="O" (
    echo Operation annulee.
    pause
    exit /b 0
)

echo.
echo ========================================
echo LISTE DES SAUVEGARDES DISPONIBLES
echo ========================================
echo.

REM Afficher les dossiers de sauvegarde disponibles
if exist "C:\oracle\backup\cold\" (
    echo Dossiers de sauvegarde trouves:
    dir /b /ad C:\oracle\backup\cold\
) else (
    echo Aucun dossier de sauvegarde trouve dans C:\oracle\backup\cold\
)

echo.
set /p BACKUP_DATE="Entrez la date de sauvegarde (format YYYY-MM-DD, ex: 2026-4-7): "
set BACKUP_DIR=C:\oracle\backup\cold\%BACKUP_DATE%

echo.
echo Dossier de sauvegarde: %BACKUP_DIR%
echo.

if not exist "%BACKUP_DIR%" (
    echo ERREUR: Dossier %BACKUP_DIR% inexistant !
    echo.
    echo Veuillez verifier la date et reessayer.
    pause
    exit /b 1
)

REM Vérifier que le fichier controlfile existe
if not exist "%BACKUP_DIR%\ctrl_%BACKUP_DATE%.bkp" (
    echo ERREUR: Fichier controlfile introuvable !
    echo Fichier attendu: %BACKUP_DIR%\ctrl_%BACKUP_DATE%.bkp
    pause
    exit /b 1
)

echo Fichiers de sauvegarde trouves.
echo.
echo Debut de la restauration...
echo.

REM Script RMAN
(
echo CONNECT TARGET /
echo STARTUP NOMOUNT;
echo RESTORE CONTROLFILE FROM '%BACKUP_DIR%\ctrl_%BACKUP_DATE%.bkp';
echo ALTER DATABASE MOUNT;
echo RESTORE DATABASE;
echo RECOVER DATABASE;
echo ALTER DATABASE OPEN RESETLOGS;
echo EXIT;
) | rman

echo.
if %ERRORLEVEL% EQU 0 (
    echo ========================================
    echo RESTAURATION TERMINEE AVEC SUCCES !
    echo ========================================
) else (
    echo ========================================
    echo ERREUR DURANT LA RESTAURATION
    echo ========================================
    echo Verifiez les logs pour plus de details.
)

echo.
pause