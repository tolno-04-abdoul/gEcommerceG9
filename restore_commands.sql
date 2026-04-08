-- Commandes RMAN pour restauration (à exécuter dans RMAN)
-- CONNECT TARGET /
-- STARTUP NOMOUNT;
-- RESTORE CONTROLFILE FROM 'C:\oracle\backup\cold\ctrl_YYYYMMDD.bkp';
-- ALTER DATABASE MOUNT;
-- RESTORE DATABASE;
-- RECOVER DATABASE;
-- ALTER DATABASE OPEN RESETLOGS;
-- EXIT;
PROMPT Ce script est pour RMAN, pas pour SQL*Plus. Utilisez restore.cmd