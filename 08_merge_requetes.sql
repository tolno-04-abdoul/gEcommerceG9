-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script 08 : Requête MERGE et requêtes avancées
-- Version corrigée - Avec suppression avant création
-- ============================================================

SET SERVEROUTPUT ON;

PROMPT ============================================================
PROMPT  Requete MERGE et requetes avancees
PROMPT ============================================================

-- ============================================================
-- 1. Table source temporaire pour MERGE
-- ============================================================

PROMPT >> Creation de la table temporaire PRODUITS_STAGING...

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PRODUITS_STAGING';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE GLOBAL TEMPORARY TABLE PRODUITS_STAGING (
    id_produit      NUMBER(10),
    nom_produit     VARCHAR2(200),
    prix_unitaire   NUMBER(12,2),
    stock           NUMBER(10),
    id_categorie    NUMBER(10),
    id_fournisseur  NUMBER(10)
) ON COMMIT DELETE ROWS;

PROMPT >> Insertion des donnees test...

-- Données test
INSERT INTO PRODUITS_STAGING (id_produit, nom_produit, prix_unitaire, stock, id_categorie, id_fournisseur)
VALUES (1, 'Smartphone Samsung A54', 780000, 60, 1, 6);

INSERT INTO PRODUITS_STAGING (id_produit, nom_produit, prix_unitaire, stock, id_categorie, id_fournisseur)
VALUES (3, 'Laptop HP 15s', 2450000, 25, 5, 5);

INSERT INTO PRODUITS_STAGING (id_produit, nom_produit, prix_unitaire, stock, id_categorie, id_fournisseur)
VALUES (21, 'Tablette iPad 10"', 1200000, 30, 1, 6);

INSERT INTO PRODUITS_STAGING (id_produit, nom_produit, prix_unitaire, stock, id_categorie, id_fournisseur)
VALUES (22, 'Casque Gaming RGB', 145000, 55, 1, 6);

COMMIT;
PROMPT >> 4 lignes inserees dans PRODUITS_STAGING.

-- ============================================================
-- 2. Requête MERGE (Upsert)
-- ============================================================

PROMPT >> Execution du MERGE...

MERGE INTO PRODUITS p
USING PRODUITS_STAGING src 
ON (p.id_produit = src.id_produit)
WHEN MATCHED THEN 
    UPDATE SET 
        p.prix_unitaire = src.prix_unitaire, 
        p.stock = src.stock, 
        p.nom_produit = src.nom_produit
WHEN NOT MATCHED THEN 
    INSERT (id_produit, nom_produit, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
    VALUES (SEQ_PRODUITS.NEXTVAL, src.nom_produit, src.prix_unitaire, src.stock, 
            src.id_categorie, src.id_fournisseur, SYSDATE, 'O');

COMMIT;
PROMPT >> MERGE execute avec succes.

-- ============================================================
-- 3. Requêtes avancées
-- ============================================================

PROMPT ============================================================
PROMPT  1. Chiffre d'affaires par categorie
PROMPT ============================================================

SELECT cat.nom_categorie, 
       COUNT(DISTINCT c.id_commande) AS nb_commandes,
       SUM(l.quantite) AS quantite_vendue, 
       SUM(l.quantite * l.prix_unitaire) AS chiffre_affaires
FROM LIGNES_COMMANDE l
JOIN PRODUITS p ON l.id_produit = p.id_produit
JOIN CATEGORIES cat ON p.id_categorie = cat.id_categorie
JOIN COMMANDES c ON l.id_commande = c.id_commande
WHERE c.statut NOT IN ('ANNULEE')
GROUP BY cat.nom_categorie 
ORDER BY chiffre_affaires DESC;

PROMPT ============================================================
PROMPT  2. Clients sans commande
PROMPT ============================================================

SELECT cl.id_client, cl.nom, cl.prenom, cl.email, cl.ville
FROM CLIENTS cl 
WHERE NOT EXISTS (SELECT 1 FROM COMMANDES c WHERE c.id_client = cl.id_client);

PROMPT ============================================================
PROMPT  3. Commandes avec paiement en attente
PROMPT ============================================================

SELECT c.id_commande, 
       cl.nom || ' ' || cl.prenom AS client, 
       c.montant_total, 
       c.date_commande, 
       NVL(p.statut, 'AUCUN PAIEMENT') AS statut_paiement
FROM COMMANDES c
JOIN CLIENTS cl ON c.id_client = cl.id_client
LEFT JOIN PAIEMENTS p ON c.id_commande = p.id_commande
WHERE NVL(p.statut, 'EN_ATTENTE') = 'EN_ATTENTE' 
ORDER BY c.date_commande;

PROMPT ============================================================
PROMPT  4. Classement clients par depenses (RANK)
PROMPT ============================================================

SELECT cl.nom || ' ' || cl.prenom AS client, 
       cl.ville, 
       SUM(c.montant_total) AS total_depense,
       RANK() OVER (ORDER BY SUM(c.montant_total) DESC) AS rang,
       NTILE(4) OVER (ORDER BY SUM(c.montant_total) DESC) AS quartile
FROM CLIENTS cl
JOIN COMMANDES c ON cl.id_client = c.id_client
WHERE c.statut != 'ANNULEE'
GROUP BY cl.id_client, cl.nom, cl.prenom, cl.ville;

PROMPT ============================================================
PROMPT  Script termine avec succes !
PROMPT ============================================================