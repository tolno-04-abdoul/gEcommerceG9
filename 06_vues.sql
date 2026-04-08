-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script 06 : Vues simples et vues matérialisées
-- Version corrigée - Avec suppression avant création
-- ============================================================

SET SERVEROUTPUT ON;

PROMPT ============================================================
PROMPT  Creation des vues simples et materialisees
PROMPT ============================================================

-- ============================================================
-- 1. VUES SIMPLES
-- ============================================================

PROMPT >> Creation des vues simples...

CREATE OR REPLACE VIEW VW_COMMANDES_DETAIL AS
SELECT c.id_commande, c.date_commande, c.statut AS statut_commande,
       cl.id_client, cl.nom || ' ' || cl.prenom AS nom_client, cl.email, cl.ville,
       c.montant_total, c.adresse_livraison
FROM COMMANDES c 
JOIN CLIENTS cl ON c.id_client = cl.id_client;

CREATE OR REPLACE VIEW VW_CATALOGUE_PRODUITS AS
SELECT p.id_produit, p.nom_produit, p.prix_unitaire, p.stock, p.actif,
       cat.nom_categorie, f.nom AS fournisseur, f.pays AS pays_fournisseur
FROM PRODUITS p
JOIN CATEGORIES cat ON p.id_categorie = cat.id_categorie
JOIN FOURNISSEURS f ON p.id_fournisseur = f.id_fournisseur;

CREATE OR REPLACE VIEW VW_PAIEMENTS_SUIVI AS
SELECT p.id_paiement, p.reference, p.date_paiement, p.montant, p.mode_paiement, p.statut AS statut_paiement,
       c.id_commande, c.statut AS statut_commande, cl.nom || ' ' || cl.prenom AS client
FROM PAIEMENTS p
JOIN COMMANDES c ON p.id_commande = c.id_commande
JOIN CLIENTS cl ON c.id_client = cl.id_client;

CREATE OR REPLACE VIEW VW_STOCK_FAIBLE AS
SELECT p.id_produit, p.nom_produit, p.stock, cat.nom_categorie, 
       f.nom AS fournisseur, f.email AS contact_fournisseur
FROM PRODUITS p
JOIN CATEGORIES cat ON p.id_categorie = cat.id_categorie
JOIN FOURNISSEURS f ON p.id_fournisseur = f.id_fournisseur
WHERE p.stock < 20 
ORDER BY p.stock ASC;

CREATE OR REPLACE VIEW VW_LIGNES_DETAIL AS
SELECT l.id_ligne, l.id_commande, p.nom_produit, l.quantite, l.prix_unitaire,
       l.quantite * l.prix_unitaire AS sous_total, cat.nom_categorie
FROM LIGNES_COMMANDE l
JOIN PRODUITS p ON l.id_produit = p.id_produit
JOIN CATEGORIES cat ON p.id_categorie = cat.id_categorie;

PROMPT >> 5 vues simples creees.

-- ============================================================
-- 2. VUES MATÉRIALISÉES
-- ============================================================

PROMPT >> Suppression des vues materialisees existantes...

BEGIN
    EXECUTE IMMEDIATE 'DROP MATERIALIZED VIEW MV_CA_PAR_MOIS';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP MATERIALIZED VIEW MV_TOP_PRODUITS';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP MATERIALIZED VIEW MV_STATS_CLIENTS';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

PROMPT >> Creation des vues materialisees...

CREATE MATERIALIZED VIEW MV_CA_PAR_MOIS
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT TO_CHAR(date_commande, 'YYYY-MM') AS mois,
       COUNT(id_commande) AS nb_commandes,
       SUM(montant_total) AS chiffre_affaires,
       ROUND(AVG(montant_total), 2) AS panier_moyen
FROM COMMANDES 
WHERE statut NOT IN ('ANNULEE')
GROUP BY TO_CHAR(date_commande, 'YYYY-MM') 
ORDER BY mois DESC;

CREATE MATERIALIZED VIEW MV_TOP_PRODUITS
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT p.id_produit, p.nom_produit, cat.nom_categorie,
       SUM(l.quantite) AS total_vendu,
       SUM(l.quantite * l.prix_unitaire) AS revenu_total,
       RANK() OVER (ORDER BY SUM(l.quantite) DESC) AS rang
FROM LIGNES_COMMANDE l
JOIN PRODUITS p ON l.id_produit = p.id_produit
JOIN CATEGORIES cat ON p.id_categorie = cat.id_categorie
GROUP BY p.id_produit, p.nom_produit, cat.nom_categorie;

CREATE MATERIALIZED VIEW MV_STATS_CLIENTS
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT cl.id_client, cl.nom || ' ' || cl.prenom AS client, cl.ville,
       COUNT(DISTINCT c.id_commande) AS nb_commandes,
       NVL(SUM(c.montant_total), 0) AS total_depense,
       MAX(c.date_commande) AS derniere_commande,
       CASE 
           WHEN SUM(c.montant_total) > 2000000 THEN 'VIP'
           WHEN SUM(c.montant_total) > 500000 THEN 'PREMIUM'
           ELSE 'STANDARD' 
       END AS segment_client
FROM CLIENTS cl
LEFT JOIN COMMANDES c ON cl.id_client = c.id_client AND c.statut NOT IN ('ANNULEE')
GROUP BY cl.id_client, cl.nom, cl.prenom, cl.ville;

PROMPT >> 3 vues materialisees creees.

PROMPT ============================================================
PROMPT  Vues et vues materialisees creees avec succes !
PROMPT ============================================================