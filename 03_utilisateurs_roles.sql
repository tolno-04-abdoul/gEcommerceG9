-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script 03 : Gestion des utilisateurs et rôles
-- !! Exécuter en tant que DBA (SYSDBA) !!
-- Version corrigée - Mots de passe simplifiés
-- ============================================================

SET SERVEROUTPUT ON;

PROMPT ============================================================
PROMPT  Creation des roles et utilisateurs
PROMPT ============================================================

-- Suppression des rôles si existants
BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE data_analyst';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE data_integration';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

PROMPT >> Creation des roles...

-- Rôle data_analyst : lecture et analyse
CREATE ROLE data_analyst;
GRANT CREATE SESSION   TO data_analyst;
GRANT SELECT ANY TABLE TO data_analyst;
GRANT CREATE VIEW      TO data_analyst;

-- Rôle data_integration : intégration des données
CREATE ROLE data_integration;
GRANT CREATE SESSION    TO data_integration;
GRANT SELECT ANY TABLE  TO data_integration;
GRANT INSERT ANY TABLE  TO data_integration;
GRANT UPDATE ANY TABLE  TO data_integration;
GRANT DELETE ANY TABLE  TO data_integration;
GRANT CREATE SEQUENCE   TO data_integration;
GRANT CREATE PROCEDURE  TO data_integration;
GRANT CREATE TRIGGER    TO data_integration;
GRANT CREATE TABLE      TO data_integration;
GRANT CREATE VIEW       TO data_integration;

PROMPT >> Creation des comptes de service...

-- Compte de service pour l'application (mots de passe simplifiés)
BEGIN
    EXECUTE IMMEDIATE 'DROP USER ecom CASCADE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE USER ecom IDENTIFIED BY 123
    DEFAULT TABLESPACE USERS
    QUOTA UNLIMITED ON USERS;

GRANT CONNECT, RESOURCE TO ecom;
GRANT data_integration TO ecom;
GRANT CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE TRIGGER TO ecom;

-- Compte de service pour les rapports
BEGIN
    EXECUTE IMMEDIATE 'DROP USER report CASCADE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE USER report IDENTIFIED BY 123
    DEFAULT TABLESPACE USERS
    QUOTA 100M ON USERS;

GRANT CONNECT, RESOURCE TO report;
GRANT data_analyst TO report;

PROMPT >> Creation des utilisateurs nominatifs...

-- Membre 1 : TOLNO
BEGIN
    EXECUTE IMMEDIATE 'DROP USER tolno CASCADE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE USER tolno IDENTIFIED BY 123
    DEFAULT TABLESPACE USERS
    QUOTA 50M ON USERS;

GRANT CONNECT, RESOURCE TO tolno;
GRANT data_analyst, data_integration TO tolno;

-- Membre 2 : AMINATA
BEGIN
    EXECUTE IMMEDIATE 'DROP USER aminata CASCADE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE USER aminata IDENTIFIED BY 123
    DEFAULT TABLESPACE USERS
    QUOTA 50M ON USERS;

GRANT CONNECT, RESOURCE TO aminata;
GRANT data_analyst TO aminata;

-- Membre 3 : SOULEYMANE
BEGIN
    EXECUTE IMMEDIATE 'DROP USER souleymane CASCADE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE USER souleymane IDENTIFIED BY 123
    DEFAULT TABLESPACE USERS
    QUOTA 50M ON USERS;

GRANT CONNECT, RESOURCE TO souleymane;
GRANT data_analyst TO souleymane;

-- Membre 4 : MOUSSA
BEGIN
    EXECUTE IMMEDIATE 'DROP USER moussa CASCADE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE USER moussa IDENTIFIED BY 123
    DEFAULT TABLESPACE USERS
    QUOTA 50M ON USERS;

GRANT CONNECT, RESOURCE TO moussa;
GRANT data_analyst TO moussa;

PROMPT ============================================================
PROMPT  Verification des utilisateurs
PROMPT ============================================================

SELECT username, account_status, created
FROM dba_users
WHERE username IN ('ECOM','REPORT','TOLNO','AMINATA','SOULEYMANE','MOUSSA')
ORDER BY created;

PROMPT >> Script termine avec succes !