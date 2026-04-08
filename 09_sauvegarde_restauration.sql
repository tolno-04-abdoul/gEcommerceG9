-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script 09 : Sauvegarde et restauration (RMAN)
-- Version corrigée - Avec utilisateur ecom
-- ============================================================

SET SERVEROUTPUT ON;

PROMPT ============================================================
PROMPT  Configuration de la sauvegarde et restauration
PROMPT ============================================================

-- ============================================================
-- 1. Vérifier le mode ARCHIVELOG
-- ============================================================

PROMPT >> Verification du mode ARCHIVELOG...

SELECT LOG_MODE FROM V$DATABASE;

-- ============================================================
-- 2. Configuration du répertoire Data Pump
-- ============================================================

PROMPT >> Configuration du repertoire DATA_PUMP_DIR...

BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE DIRECTORY DATA_PUMP_DIR AS ''C:\oracle\backup\datapump''';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

GRANT READ, WRITE ON DIRECTORY DATA_PUMP_DIR TO ecom;

PROMPT >> Repertoire DATA_PUMP_DIR cree.

-- ============================================================
-- 3. Scripts RMAN (à exécuter dans RMAN, pas dans SQL*Plus)
-- ============================================================

PROMPT ============================================================
PROMPT  Scripts RMAN (a executer dans RMAN)
PROMPT ============================================================

PROMPT .
PROMPT -- Sauvegarde a chaud (base en fonctionnement) --
PROMPT RUN {
PROMPT    ALLOCATE CHANNEL ch1 DEVICE TYPE DISK;
PROMPT    BACKUP DATABASE PLUS ARCHIVELOG;
PROMPT    BACKUP CURRENT CONTROLFILE;
PROMPT    RELEASE CHANNEL ch1;
PROMPT }
PROMPT .

PROMPT -- Sauvegarde a froid (base arretee) --
PROMPT SHUTDOWN IMMEDIATE;
PROMPT STARTUP MOUNT;
PROMPT BACKUP DATABASE;
PROMPT BACKUP CURRENT CONTROLFILE;
PROMPT ALTER DATABASE OPEN;
PROMPT .

PROMPT -- Restauration complete --
PROMPT STARTUP NOMOUNT;
PROMPT RESTORE CONTROLFILE FROM '...';
PROMPT ALTER DATABASE MOUNT;
PROMPT RESTORE DATABASE;
PROMPT RECOVER DATABASE;
PROMPT ALTER DATABASE OPEN RESETLOGS;
PROMPT .

-- ============================================================
-- 4. Commande Data Pump (à exécuter dans CMD)
-- ============================================================

PROMPT ============================================================
PROMPT  Commande Data Pump (a executer dans CMD)
PROMPT ============================================================
PROMPT .
PROMPT expdp ecom/123@//localhost:1521/XEPDB1 ^
PROMPT       DIRECTORY=DATA_PUMP_DIR ^
PROMPT       DUMPFILE=ecommerce_export_%DATE%.dmp ^
PROMPT       LOGFILE=export_%DATE%.log ^
PROMPT       SCHEMAS=ecom ^
PROMPT       COMPRESSION=ALL
PROMPT .

-- ============================================================
-- 5. Vérification du répertoire
-- ============================================================

PROMPT >> Verification du repertoire...

SELECT directory_name, directory_path 
FROM dba_directories 
WHERE directory_name = 'DATA_PUMP_DIR';

PROMPT ============================================================
PROMPT  Scripts de sauvegarde prets !
PROMPT ============================================================