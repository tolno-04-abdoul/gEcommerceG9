@ECHO OFF
REM ============================================================
REM PROJET FINAL ORACLE - GESTION E-COMMERCE
REM Script de rechargement automatique des donnees
REM Version corrigee
REM ============================================================

TITLE Rechargement Base E-Commerce
ECHO ============================================================
ECHO  IST MAMOU - Projet Oracle E-Commerce
ECHO  Script de rechargement automatique des donnees
ECHO  %DATE% %TIME%
ECHO ============================================================
ECHO.

REM ---- CONFIGURATION ----
SET ORACLE_USER=ecom
SET ORACLE_PASS=123
SET CONNECTION_STRING=//localhost:1521/XEPDB1
SET SCRIPTS_DIR=C:\Users\TOLNO\Desktop\gEcommerceG9
SET LOG_DIR=%SCRIPTS_DIR%\logs

REM Creation du dossier de logs
IF NOT EXIST "%LOG_DIR%" MKDIR "%LOG_DIR%"

REM Générer un nom de fichier de log avec date au format YYYY-MM-DD
FOR /f "tokens=1-3 delims=/ " %%a IN ('date /t') DO (
    set jour=%%a
    set mois=%%b
    set annee=%%c
)

REM Supprimer les espaces potentiels
set jour=%jour: =%
set mois=%mois: =%
set annee=%annee: =%

REM Supprimer les zeros au début si necessaire
if %jour:~0,1%==0 set jour=%jour:~1%
if %mois:~0,1%==0 set mois=%mois:~1%

FOR /f "tokens=1-2 delims=: " %%a IN ('time /t') DO SET TIME_LOG=%%a%%b

set DATE_LOG=%annee%-%mois%-%jour%
SET LOG_FILE=%LOG_DIR%\reload_%DATE_LOG%_%TIME_LOG%.log

ECHO Log file: %LOG_FILE%
ECHO.

REM ============================================================
REM 1. Vidage des tables
REM ============================================================
ECHO [1/5] Vidage des tables en cours...
sqlplus -S %ORACLE_USER%/%ORACLE_PASS%@%CONNECTION_STRING% @"%SCRIPTS_DIR%\10_vider_tables.sql" >> "%LOG_FILE%" 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO [ERREUR] Echec du vidage des tables. Voir %LOG_FILE%
    TYPE "%LOG_FILE%"
    PAUSE
    EXIT /B 1
)
ECHO [OK] Tables videes.
ECHO.

REM ============================================================
REM 2. Creation des sequences
REM ============================================================
ECHO [2/5] Creation des sequences...
sqlplus -S %ORACLE_USER%/%ORACLE_PASS%@%CONNECTION_STRING% @"%SCRIPTS_DIR%\02_sequences.sql" >> "%LOG_FILE%" 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO [ERREUR] Echec de la creation des sequences. Voir %LOG_FILE%
    TYPE "%LOG_FILE%"
    PAUSE
    EXIT /B 1
)
ECHO [OK] Sequences creees.
ECHO.

REM ============================================================
REM 3. Insertion des donnees de base
REM ============================================================
ECHO [3/5] Insertion des donnees de base...
sqlplus -S %ORACLE_USER%/%ORACLE_PASS%@%CONNECTION_STRING% @"%SCRIPTS_DIR%\04_insertion_donnees.sql" >> "%LOG_FILE%" 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO [ERREUR] Echec de l'insertion des donnees de base. Voir %LOG_FILE%
    TYPE "%LOG_FILE%"
    PAUSE
    EXIT /B 1
)
ECHO [OK] Donnees de base inserees.
ECHO.

REM ============================================================
REM 4. Generation donnees aleatoires
REM ============================================================
ECHO [4/5] Generation donnees aleatoires...
sqlplus -S %ORACLE_USER%/%ORACLE_PASS%@%CONNECTION_STRING% @"%SCRIPTS_DIR%\11_generation_aleatoire.sql" >> "%LOG_FILE%" 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO [ERREUR] Echec de la generation des donnees aleatoires. Voir %LOG_FILE%
    TYPE "%LOG_FILE%"
    PAUSE
    EXIT /B 1
)
ECHO [OK] Donnees aleatoires generees.
ECHO.

REM ============================================================
REM 5. Rafraichissement vues materialisees
REM ============================================================
ECHO [5/5] Rafraichissement vues materialisees...
sqlplus -S %ORACLE_USER%/%ORACLE_PASS%@%CONNECTION_STRING% @"%SCRIPTS_DIR%\refresh_mv.sql" >> "%LOG_FILE%" 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO [ERREUR] Echec du rafraichissement des vues. Voir %LOG_FILE%
    TYPE "%LOG_FILE%"
    PAUSE
    EXIT /B 1
)
ECHO [OK] Vues actualisees.
ECHO.

REM ============================================================
REM Fin
REM ============================================================
ECHO ============================================================
ECHO  RECHARGEMENT TERMINE AVEC SUCCES !
ECHO  Log : %LOG_FILE%
ECHO ============================================================
PAUSE