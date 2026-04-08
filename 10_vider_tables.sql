-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script 10 : Vider toutes les tables (TRUNCATE)
-- Version corrigée - Sans suppression des sequences
-- ============================================================

SET SERVEROUTPUT ON;

PROMPT ============================================================
PROMPT  Vidage complet de toutes les tables
PROMPT ============================================================

-- ============================================================
-- 1. Désactiver les contraintes d'intégrité
-- ============================================================

PROMPT >> Desactivation des contraintes...

BEGIN
    FOR c IN (SELECT constraint_name, table_name 
              FROM user_constraints 
              WHERE constraint_type = 'R') LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE ' || c.table_name || 
                          ' DISABLE CONSTRAINT ' || c.constraint_name;
    END LOOP;
END;
/

PROMPT >> Contraintes desactivees.

-- ============================================================
-- 2. Vider toutes les tables (TRUNCATE)
-- ============================================================

PROMPT >> Vidage des tables...

TRUNCATE TABLE LOG_COMMANDES;
PROMPT >> LOG_COMMANDES videe.

TRUNCATE TABLE LIVRAISONS;
PROMPT >> LIVRAISONS videe.

TRUNCATE TABLE PAIEMENTS;
PROMPT >> PAIEMENTS videe.

TRUNCATE TABLE LIGNES_COMMANDE;
PROMPT >> LIGNES_COMMANDE videe.

TRUNCATE TABLE COMMANDES;
PROMPT >> COMMANDES videe.

TRUNCATE TABLE PRODUITS;
PROMPT >> PRODUITS videe.

TRUNCATE TABLE CLIENTS;
PROMPT >> CLIENTS videe.

TRUNCATE TABLE FOURNISSEURS;
PROMPT >> FOURNISSEURS videe.

TRUNCATE TABLE CATEGORIES;
PROMPT >> CATEGORIES videe.

-- ============================================================
-- 3. Réactiver les contraintes
-- ============================================================

PROMPT >> Reactivation des contraintes...

BEGIN
    FOR c IN (SELECT constraint_name, table_name 
              FROM user_constraints 
              WHERE constraint_type = 'R') LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE ' || c.table_name || 
                          ' ENABLE CONSTRAINT ' || c.constraint_name;
    END LOOP;
END;
/

PROMPT >> Contraintes reactivees.

-- ============================================================
-- 4. Validation
-- ============================================================

COMMIT;

PROMPT ============================================================
PROMPT  Vidage termine avec succes !
PROMPT ============================================================