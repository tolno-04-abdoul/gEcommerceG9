-- Configuration Oracle pour sauvegarde automatique
ALTER SYSTEM SET db_recovery_file_dest_size = 50G SCOPE=BOTH;
ALTER SYSTEM SET db_recovery_file_dest = 'C:\oracle\fast_recovery_area' SCOPE=BOTH;
CREATE OR REPLACE DIRECTORY DATA_PUMP_DIR AS 'C:\oracle\backup\datapump';
GRANT READ, WRITE ON DIRECTORY DATA_PUMP_DIR TO svc_ecommerce;
CREATE OR REPLACE DIRECTORY EXPORT_DIR AS 'C:\oracle\backup\exports';
GRANT READ, WRITE ON DIRECTORY EXPORT_DIR TO svc_ecommerce;
PROMPT >> Configuration terminee