-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script 11 : Génération de données aléatoires (DBMS_RANDOM)
-- VERSION FINALE - SANS AUCUNE ERREUR
-- ============================================================

SET SERVEROUTPUT ON;

PROMPT ============================================================
PROMPT  Generation de donnees aleatoires
PROMPT ============================================================

-- ============================================================
-- Désactivation des triggers
-- ============================================================

PROMPT >> Desactivation des triggers...

BEGIN
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_MAJ_MONTANT_COMMANDE DISABLE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_MAJ_STOCK DISABLE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- ============================================================
-- 1. CATEGORIES aléatoires (5)
-- ============================================================

PROMPT >> Generation des categories...

BEGIN
    FOR i IN 1..5 LOOP
        INSERT INTO CATEGORIES (id_categorie, nom_categorie, description, date_creation)
        VALUES (SEQ_CATEGORIES.NEXTVAL, 
                'Categorie_' || DBMS_RANDOM.STRING('U', TRUNC(DBMS_RANDOM.VALUE(5,15))), 
                'Description aleatoire ' || DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.VALUE(20,100))), 
                SYSDATE);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('>> ' || SQL%ROWCOUNT || ' categories aleatoires ajoutees');
END;
/

-- ============================================================
-- 2. FOURNISSEURS aléatoires (10)
-- ============================================================

PROMPT >> Generation des fournisseurs...

BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO FOURNISSEURS (id_fournisseur, nom, email, telephone, adresse, pays, date_ajout)
        VALUES (SEQ_FOURNISSEURS.NEXTVAL, 
                'Fournisseur_' || DBMS_RANDOM.STRING('U', TRUNC(DBMS_RANDOM.VALUE(5,12))), 
                LOWER(DBMS_RANDOM.STRING('L',8)) || '@fournisseur.com', 
                '+224 ' || TRUNC(DBMS_RANDOM.VALUE(60000000,69999999)), 
                'Adresse aleatoire ' || TRUNC(DBMS_RANDOM.VALUE(1,999)), 
                CASE TRUNC(DBMS_RANDOM.VALUE(1,6)) 
                    WHEN 1 THEN 'Guinee' 
                    WHEN 2 THEN 'Senegal' 
                    WHEN 3 THEN 'Cote d''Ivoire' 
                    WHEN 4 THEN 'Mali' 
                    ELSE 'France' 
                END, 
                SYSDATE);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('>> ' || SQL%ROWCOUNT || ' fournisseurs aleatoires ajoutes');
END;
/

-- ============================================================
-- 3. PRODUITS aléatoires (50)
-- ============================================================

PROMPT >> Generation des produits...

BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
        VALUES (SEQ_PRODUITS.NEXTVAL, 
                'Produit_' || DBMS_RANDOM.STRING('U', TRUNC(DBMS_RANDOM.VALUE(5,20))), 
                'Description du produit ' || i, 
                ROUND(DBMS_RANDOM.VALUE(1000,500000),-2), 
                TRUNC(DBMS_RANDOM.VALUE(0,500)), 
                TRUNC(DBMS_RANDOM.VALUE(1,14)), 
                TRUNC(DBMS_RANDOM.VALUE(1,17)), 
                SYSDATE, 
                'O');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('>> ' || SQL%ROWCOUNT || ' produits aleatoires ajoutes');
END;
/

-- ============================================================
-- 4. CLIENTS aléatoires (100)
-- ============================================================

PROMPT >> Generation des clients...

BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
        VALUES (SEQ_CLIENTS.NEXTVAL, 
                'Nom_' || DBMS_RANDOM.STRING('U', TRUNC(DBMS_RANDOM.VALUE(3,10))), 
                'Prenom_' || DBMS_RANDOM.STRING('U', TRUNC(DBMS_RANDOM.VALUE(3,10))), 
                LOWER(DBMS_RANDOM.STRING('L',6)) || '_' || i || '@client.com', 
                '+224 ' || TRUNC(DBMS_RANDOM.VALUE(60000000,69999999)), 
                TRUNC(DBMS_RANDOM.VALUE(1,200)) || ' Rue de la Paix', 
                CASE TRUNC(DBMS_RANDOM.VALUE(1,6)) 
                    WHEN 1 THEN 'Conakry' 
                    WHEN 2 THEN 'Kankan' 
                    WHEN 3 THEN 'Labe' 
                    WHEN 4 THEN 'N''Zerekore' 
                    ELSE 'Kindia' 
                END, 
                'Guinee', 
                SYSDATE, 
                'O');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('>> ' || SQL%ROWCOUNT || ' clients aleatoires ajoutes');
END;
/

-- ============================================================
-- 5. COMMANDES aléatoires (200)
-- ============================================================

PROMPT >> Generation des commandes...

BEGIN
    FOR i IN 1..200 LOOP
        INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
        VALUES (SEQ_COMMANDES.NEXTVAL, 
                TRUNC(DBMS_RANDOM.VALUE(1,116)), 
                SYSDATE - TRUNC(DBMS_RANDOM.VALUE(0,365)), 
                CASE TRUNC(DBMS_RANDOM.VALUE(1,6)) 
                    WHEN 1 THEN 'EN_ATTENTE' 
                    WHEN 2 THEN 'CONFIRMEE' 
                    WHEN 3 THEN 'EXPEDIEE' 
                    WHEN 4 THEN 'LIVREE' 
                    ELSE 'ANNULEE' 
                END, 
                0, 
                'Adresse livraison aleatoire ' || TRUNC(DBMS_RANDOM.VALUE(1,500)));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('>> ' || SQL%ROWCOUNT || ' commandes aleatoires ajoutees');
END;
/

-- ============================================================
-- 6. LIGNES_COMMANDE aléatoires (500) - Version robuste
-- ============================================================

PROMPT >> Generation des lignes de commande...

DECLARE
    TYPE t_ids_produits IS TABLE OF PRODUITS.id_produit%TYPE;
    TYPE t_ids_commandes IS TABLE OF COMMANDES.id_commande%TYPE;
    v_produits t_ids_produits;
    v_commandes t_ids_commandes;
    v_idx_p NUMBER;
    v_idx_c NUMBER;
BEGIN
    SELECT id_produit BULK COLLECT INTO v_produits FROM PRODUITS;
    SELECT id_commande BULK COLLECT INTO v_commandes FROM COMMANDES;
    
    FOR i IN 1..500 LOOP
        v_idx_p := TRUNC(DBMS_RANDOM.VALUE(1, v_produits.COUNT + 1));
        v_idx_c := TRUNC(DBMS_RANDOM.VALUE(1, v_commandes.COUNT + 1));
        
        INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
        VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 
                v_commandes(v_idx_c),
                v_produits(v_idx_p),
                TRUNC(DBMS_RANDOM.VALUE(1,10)), 
                ROUND(DBMS_RANDOM.VALUE(500,500000),-2));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('>> 500 lignes de commande aleatoires ajoutees');
END;
/

-- ============================================================
-- 7. Mise à jour des montants totaux
-- ============================================================

PROMPT >> Mise a jour des montants totaux...

BEGIN
    FOR cmd IN (SELECT id_commande FROM COMMANDES) LOOP
        UPDATE COMMANDES c 
        SET montant_total = (SELECT NVL(SUM(quantite * prix_unitaire),0) 
                             FROM LIGNES_COMMANDE l 
                             WHERE l.id_commande = cmd.id_commande) 
        WHERE c.id_commande = cmd.id_commande;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('>> Montants totaux mis a jour');
END;
/

-- ============================================================
-- 8. PAIEMENTS aléatoires (150)
-- ============================================================

PROMPT >> Generation des paiements...

DECLARE
    v_counter NUMBER := 0;
BEGIN
    FOR i IN 1..150 LOOP
        INSERT INTO PAIEMENTS (id_paiement, id_commande, date_paiement, montant, mode_paiement, statut, reference)
        SELECT SEQ_PAIEMENTS.NEXTVAL,
               id_commande,
               SYSDATE - TRUNC(DBMS_RANDOM.VALUE(0,365)),
               ROUND(DBMS_RANDOM.VALUE(1000,500000),-2),
               CASE TRUNC(DBMS_RANDOM.VALUE(1,5)) 
                   WHEN 1 THEN 'CARTE' 
                   WHEN 2 THEN 'VIREMENT' 
                   WHEN 3 THEN 'MOBILE_MONEY' 
                   ELSE 'ESPECES' 
               END,
               CASE TRUNC(DBMS_RANDOM.VALUE(1,5)) 
                   WHEN 1 THEN 'VALIDE' 
                   WHEN 2 THEN 'EN_ATTENTE' 
                   ELSE 'REFUSE' 
               END,
               'REF_' || DBMS_RANDOM.STRING('X',10)
        FROM (SELECT id_commande FROM COMMANDES ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM = 1;
        
        v_counter := v_counter + 1;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('>> ' || v_counter || ' paiements aleatoires ajoutes');
END;
/

-- ============================================================
-- Réactivation des triggers
-- ============================================================

PROMPT >> Reactivation des triggers...

BEGIN
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_MAJ_MONTANT_COMMANDE ENABLE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_MAJ_STOCK ENABLE';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- ============================================================
-- 9. Rafraîchissement des vues matérialisées
-- ============================================================

PROMPT >> Rafraichissement des vues materialisees...

BEGIN
    DBMS_MVIEW.REFRESH('MV_CA_PAR_MOIS', 'C');
    DBMS_MVIEW.REFRESH('MV_TOP_PRODUITS', 'C');
    DBMS_MVIEW.REFRESH('MV_STATS_CLIENTS', 'C');
    DBMS_OUTPUT.PUT_LINE('>> Vues materialisees rafraichies');
END;
/

PROMPT ============================================================
PROMPT  GENERATION ALEATOIRE TERMINEE !
PROMPT ============================================================