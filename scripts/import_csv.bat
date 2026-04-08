@echo off
REM ============================================================
REM IMPORT CSV VIA SQL*LOADER - Oracle E-Commerce
REM Version corrigee - Avec utilisateur ecom
REM ============================================================
TITLE Import CSV - Oracle E-Commerce

echo ========================================
echo IMPORT DE DONNEES VIA SQL*LOADER
echo ========================================
echo.

REM Configuration
SET USER=ecom
SET PASS=123
SET DB=//localhost:1521/XEPDB1

echo Utilisateur: %USER%
echo Base: %DB%
echo.

REM Verification que le fichier CSV existe
IF NOT EXIST "produits.csv" (
    echo ERREUR: Fichier produits.csv introuvable !
    echo.
    echo Veuillez placer le fichier produits.csv dans le dossier courant.
    echo Format attendu: nom_produit;description;prix_unitaire;stock;id_categorie;id_fournisseur
    pause
    exit /b 1
)

echo Fichier produits.csv trouve.
echo Import en cours...
echo.

REM Import avec SQL*Loader
sqlldr %USER%/%PASS%@%DB% control=import_csv.ctl log=import_produits.log bad=import_produits.bad

echo.
if %ERRORLEVEL% EQU 0 (
    echo ========================================
    echo IMPORT REUSSI !
    echo ========================================
    echo Log: import_produits.log
    echo.
    echo Verifier les donnees avec:
    echo SELECT COUNT(*) FROM PRODUITS;
) else (
    echo ========================================
    echo ERREUR DURANT L'IMPORT
    echo ========================================
    echo Consultez import_produits.log pour plus de details.
)

echo.
pause