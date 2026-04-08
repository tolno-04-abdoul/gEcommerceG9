-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script 07 : Triggers
-- Version corrigée - Avec suppression avant création
-- ============================================================

SET SERVEROUTPUT ON;

PROMPT ============================================================
PROMPT  Creation des triggers
PROMPT ============================================================

-- ============================================================
-- Suppression des triggers existants
-- ============================================================

PROMPT >> Suppression des triggers existants...

BEGIN
    EXECUTE IMMEDIATE 'DROP TRIGGER TRG_MAJ_STOCK';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TRIGGER TRG_MAJ_MONTANT_COMMANDE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TRIGGER TRG_AUDIT_STATUT_COMMANDE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- ============================================================
-- TRIGGER 1 : Mise à jour automatique du stock après commande
-- ============================================================

PROMPT >> Creation du trigger TRG_MAJ_STOCK...

CREATE OR REPLACE TRIGGER TRG_MAJ_STOCK
AFTER INSERT ON LIGNES_COMMANDE
FOR EACH ROW
DECLARE
    v_stock NUMBER;
BEGIN
    -- Mise à jour du stock
    UPDATE PRODUITS 
    SET stock = stock - :NEW.quantite 
    WHERE id_produit = :NEW.id_produit;
    
    -- Vérification du stock négatif
    SELECT stock INTO v_stock 
    FROM PRODUITS 
    WHERE id_produit = :NEW.id_produit;
    
    IF v_stock < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'Stock insuffisant pour le produit ID=' || :NEW.id_produit || 
            '. Stock restant: ' || v_stock);
    END IF;
END;
/

-- ============================================================
-- TRIGGER 2 : Mise à jour du montant total de la commande
-- ============================================================

PROMPT >> Creation du trigger TRG_MAJ_MONTANT_COMMANDE...

CREATE OR REPLACE TRIGGER TRG_MAJ_MONTANT_COMMANDE
AFTER INSERT OR UPDATE OR DELETE ON LIGNES_COMMANDE
FOR EACH ROW
BEGIN
    IF INSERTING OR UPDATING THEN
        UPDATE COMMANDES 
        SET montant_total = (
            SELECT NVL(SUM(quantite * prix_unitaire), 0) 
            FROM LIGNES_COMMANDE 
            WHERE id_commande = :NEW.id_commande
        )
        WHERE id_commande = :NEW.id_commande;
    END IF;
    
    IF DELETING THEN
        UPDATE COMMANDES 
        SET montant_total = (
            SELECT NVL(SUM(quantite * prix_unitaire), 0) 
            FROM LIGNES_COMMANDE 
            WHERE id_commande = :OLD.id_commande
        )
        WHERE id_commande = :OLD.id_commande;
    END IF;
END;
/

-- ============================================================
-- TRIGGER 3 : Journalisation des changements de statut
-- ============================================================

PROMPT >> Creation du trigger TRG_AUDIT_STATUT_COMMANDE...

CREATE OR REPLACE TRIGGER TRG_AUDIT_STATUT_COMMANDE
AFTER UPDATE OF statut ON COMMANDES
FOR EACH ROW
WHEN (OLD.statut != NEW.statut)
BEGIN
    INSERT INTO LOG_COMMANDES (id_commande, ancien_statut, nouveau_statut)
    VALUES (:OLD.id_commande, :OLD.statut, :NEW.statut);
END;
/

-- ============================================================
-- Vérification des triggers
-- ============================================================

PROMPT >> Verification des triggers...

SELECT trigger_name, status 
FROM user_triggers 
WHERE trigger_name IN ('TRG_MAJ_STOCK', 'TRG_MAJ_MONTANT_COMMANDE', 'TRG_AUDIT_STATUT_COMMANDE');

PROMPT ============================================================
PROMPT  Triggers crees avec succes !
PROMPT ============================================================