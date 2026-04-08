-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script 05 : Index pour l'optimisation des performances
-- Version corrigée - Avec suppression avant création
-- ============================================================

SET SERVEROUTPUT ON;

PROMPT ============================================================
PROMPT  Creation des index
PROMPT ============================================================

-- ============================================================
-- 1. Index sur clés étrangères
-- ============================================================

PROMPT >> Creation des index sur cles etrangeres...

DROP INDEX idx_produits_categorie;
CREATE INDEX idx_produits_categorie ON PRODUITS(id_categorie);

DROP INDEX idx_produits_fournisseur;
CREATE INDEX idx_produits_fournisseur ON PRODUITS(id_fournisseur);

DROP INDEX idx_commandes_client;
CREATE INDEX idx_commandes_client ON COMMANDES(id_client);

DROP INDEX idx_lignes_commande;
CREATE INDEX idx_lignes_commande ON LIGNES_COMMANDE(id_commande);

DROP INDEX idx_lignes_produit;
CREATE INDEX idx_lignes_produit ON LIGNES_COMMANDE(id_produit);

DROP INDEX idx_paiements_commande;
CREATE INDEX idx_paiements_commande ON PAIEMENTS(id_commande);

DROP INDEX idx_livraisons_commande;
CREATE INDEX idx_livraisons_commande ON LIVRAISONS(id_commande);

-- ============================================================
-- 2. Index sur colonnes fréquentes (WHERE / ORDER BY)
-- ============================================================

PROMPT >> Creation des index sur colonnes frequentes...

DROP INDEX idx_clients_email;
CREATE UNIQUE INDEX idx_clients_email ON CLIENTS(email);

DROP INDEX idx_produits_nom;
CREATE INDEX idx_produits_nom ON PRODUITS(nom_produit);

DROP INDEX idx_produits_prix;
CREATE INDEX idx_produits_prix ON PRODUITS(prix_unitaire);

DROP INDEX idx_commandes_statut;
CREATE INDEX idx_commandes_statut ON COMMANDES(statut);

DROP INDEX idx_commandes_date;
CREATE INDEX idx_commandes_date ON COMMANDES(date_commande DESC);

DROP INDEX idx_paiements_statut;
CREATE INDEX idx_paiements_statut ON PAIEMENTS(statut);

DROP INDEX idx_paiements_mode;
CREATE INDEX idx_paiements_mode ON PAIEMENTS(mode_paiement);

DROP INDEX idx_livraisons_suivi;
CREATE UNIQUE INDEX idx_livraisons_suivi ON LIVRAISONS(numero_suivi);

DROP INDEX idx_livraisons_statut;
CREATE INDEX idx_livraisons_statut ON LIVRAISONS(statut);

-- ============================================================
-- 3. Index composites
-- ============================================================

PROMPT >> Creation des index composites...

DROP INDEX idx_cmd_client_statut;
CREATE INDEX idx_cmd_client_statut ON COMMANDES(id_client, statut);

DROP INDEX idx_ligne_cmd_prod;
CREATE INDEX idx_ligne_cmd_prod ON LIGNES_COMMANDE(id_commande, id_produit);

PROMPT ============================================================
PROMPT  Index crees avec succes !
PROMPT ============================================================