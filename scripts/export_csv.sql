-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script d'export CSV
-- Version corrigee
-- ============================================================

SET SERVEROUTPUT ON;
SET PAGESIZE 0
SET FEEDBACK OFF
SET HEADING OFF
SET COLSEP ';'
SET LINESIZE 1000
SET TRIMSPOOL ON

PROMPT ============================================================
PROMPT  Export des donnees vers CSV
PROMPT ============================================================

-- ============================================================
-- Export des produits
-- ============================================================

PROMPT >> Export des produits en cours...

SPOOL export_produits.csv
SELECT id_produit || ';' || 
       nom_produit || ';' || 
       NVL(description,'') || ';' || 
       prix_unitaire || ';' || 
       stock || ';' || 
       id_categorie || ';' || 
       id_fournisseur 
FROM PRODUITS;
SPOOL OFF

PROMPT >> Export des produits termine : export_produits.csv

-- ============================================================
-- Export des clients
-- ============================================================

PROMPT >> Export des clients en cours...

SPOOL export_clients.csv
SELECT id_client || ';' || 
       nom || ';' || 
       prenom || ';' || 
       email || ';' || 
       NVL(telephone,'') || ';' || 
       NVL(adresse,'') || ';' || 
       ville || ';' || 
       pays 
FROM CLIENTS;
SPOOL OFF

PROMPT >> Export des clients termine : export_clients.csv

-- ============================================================
-- Fin
-- ============================================================

PROMPT ============================================================
PROMPT  Exports termines avec succes !
PROMPT ============================================================