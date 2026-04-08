@echo off
REM ============================================================
REM INSTALLATION DE LA PLANIFICATION DE SAUVEGARDE
REM Execute en tant qu'Administrateur
REM ============================================================

echo ========================================
echo INSTALLATION PLANIFICATION SAUVEGARDE
echo ========================================
echo.

REM Verifier les droits administrateur
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERREUR: Executer ce script en tant qu'Administrateur
    pause
    exit /b 1
)

REM Creer la tache planifiee (sauvegarde quotidienne a 2h du matin)
schtasks /create ^
    /tn "Oracle_ECommerce_Backup" ^
    /tr "C:\Users\TOLNO\Desktop\gEcommerceG9\scripts\backup_auto.bat" ^
    /sc daily ^
    /st 02:00 ^
    /ru SYSTEM ^
    /f

if %ERRORLEVEL% EQU 0 (
    echo [OK] Tache planifiee creee : Tous les jours a 02:00
) else (
    echo [ERREUR] Echec de la creation de la tache planifiee
)

echo.
echo ========================================
echo Pour voir la tache : taskschd.msc
echo ========================================
pause