-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script 04 : Insertion des données de base
-- Version corrigée - Données complètes
-- ============================================================

SET SERVEROUTPUT ON;

PROMPT ============================================================
PROMPT  Insertion des donnees de base
PROMPT ============================================================

-- ============================================================
-- 1. CATEGORIES (8)
-- ============================================================
INSERT INTO CATEGORIES (id_categorie, nom_categorie, description, date_creation)
VALUES (SEQ_CATEGORIES.NEXTVAL, 'Électronique', 'Appareils électroniques et accessoires', SYSDATE);

INSERT INTO CATEGORIES (id_categorie, nom_categorie, description, date_creation)
VALUES (SEQ_CATEGORIES.NEXTVAL, 'Vêtements', 'Mode homme, femme et enfant', SYSDATE);

INSERT INTO CATEGORIES (id_categorie, nom_categorie, description, date_creation)
VALUES (SEQ_CATEGORIES.NEXTVAL, 'Alimentation', 'Produits alimentaires et boissons', SYSDATE);

INSERT INTO CATEGORIES (id_categorie, nom_categorie, description, date_creation)
VALUES (SEQ_CATEGORIES.NEXTVAL, 'Maison et Jardin', 'Mobilier et articles de maison', SYSDATE);

INSERT INTO CATEGORIES (id_categorie, nom_categorie, description, date_creation)
VALUES (SEQ_CATEGORIES.NEXTVAL, 'Informatique', 'Ordinateurs, composants et logiciels', SYSDATE);

INSERT INTO CATEGORIES (id_categorie, nom_categorie, description, date_creation)
VALUES (SEQ_CATEGORIES.NEXTVAL, 'Sport et Loisirs', 'Équipements sportifs et de loisirs', SYSDATE);

INSERT INTO CATEGORIES (id_categorie, nom_categorie, description, date_creation)
VALUES (SEQ_CATEGORIES.NEXTVAL, 'Beauté et Santé', 'Cosmétiques et produits de santé', SYSDATE);

INSERT INTO CATEGORIES (id_categorie, nom_categorie, description, date_creation)
VALUES (SEQ_CATEGORIES.NEXTVAL, 'Livres et Médias', 'Livres, films et musique', SYSDATE);

COMMIT;
PROMPT >> 8 categories inserees.

-- ============================================================
-- 2. FOURNISSEURS (6)
-- ============================================================
INSERT INTO FOURNISSEURS (id_fournisseur, nom, email, telephone, adresse, pays, date_ajout)
VALUES (SEQ_FOURNISSEURS.NEXTVAL, 'TechSupply SA', 'contact@techsupply.com', '+224 620 111 001', 'Zone Industrielle, Conakry', 'Guinée', SYSDATE);

INSERT INTO FOURNISSEURS (id_fournisseur, nom, email, telephone, adresse, pays, date_ajout)
VALUES (SEQ_FOURNISSEURS.NEXTVAL, 'AfriMode SARL', 'info@afrimode.com', '+224 620 222 002', 'Madina, Conakry', 'Guinée', SYSDATE);

INSERT INTO FOURNISSEURS (id_fournisseur, nom, email, telephone, adresse, pays, date_ajout)
VALUES (SEQ_FOURNISSEURS.NEXTVAL, 'Dakar Import Export', 'dakar@importexport.sn', '+221 77 333 0003', '23 Rue du Commerce, Dakar', 'Sénégal', SYSDATE);

INSERT INTO FOURNISSEURS (id_fournisseur, nom, email, telephone, adresse, pays, date_ajout)
VALUES (SEQ_FOURNISSEURS.NEXTVAL, 'GlobalTech CI', 'globaltech@ci.com', '+225 07 444 0004', 'Plateau, Abidjan', 'Côte d''Ivoire', SYSDATE);

INSERT INTO FOURNISSEURS (id_fournisseur, nom, email, telephone, adresse, pays, date_ajout)
VALUES (SEQ_FOURNISSEURS.NEXTVAL, 'EuroDistrib France', 'eurodistrib@france.fr', '+33 1 55 666 005', '12 Av. de la République, Paris', 'France', SYSDATE);

INSERT INTO FOURNISSEURS (id_fournisseur, nom, email, telephone, adresse, pays, date_ajout)
VALUES (SEQ_FOURNISSEURS.NEXTVAL, 'ChinaSource Ltd', 'source@chinasource.cn', '+86 10 777 0006', 'Shenzhen Industrial Park', 'Chine', SYSDATE);

COMMIT;
PROMPT >> 6 fournisseurs inseres.

-- ============================================================
-- 3. PRODUITS (20)
-- ============================================================
INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Smartphone Samsung A54', '6.4" 128GB 5G', 750000, 50, 1, 6, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Laptop HP 15s', 'Core i5 8GB 512GB SSD', 2500000, 20, 5, 5, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Écouteurs Bluetooth JBL', 'Sans fil, 30h batterie', 180000, 80, 1, 6, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Souris sans fil Logitech', 'Ergonomique, DPI 1600', 65000, 150, 5, 5, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Clavier mécanique', 'RGB, Switch bleu', 120000, 60, 5, 6, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'T-shirt homme coton', 'Taille M, blanc', 25000, 200, 2, 2, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Robe femme imprimée', 'Taille 38, multicolore', 75000, 120, 2, 2, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Chaussures running', 'Nike Air, pointure 42', 320000, 40, 6, 4, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Sac à dos école', '25L imperméable', 85000, 70, 2, 3, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Riz parfumé 25kg', 'Riz thaïlandais premium', 185000, 300, 3, 3, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Huile végétale 5L', '100% naturelle', 45000, 250, 3, 1, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Canapé 3 places', 'Tissu gris, confortable', 1800000, 8, 4, 4, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Table basse bois', 'Bois massif, 120x60cm', 650000, 15, 4, 1, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Ballon de football', 'FIFA Quality Pro', 95000, 100, 6, 3, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Tapis de yoga', '6mm antidérapant', 55000, 80, 6, 6, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Crème solaire SPF50', '200ml protection totale', 28000, 180, 7, 5, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Parfum Oud intense', '100ml Eau de parfum', 220000, 50, 7, 4, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Roman "L''Aventure"', 'Bestseller 2024', 18000, 200, 8, 3, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Écran PC 24"', 'Full HD IPS 75Hz', 890000, 25, 1, 6, SYSDATE, 'O');

INSERT INTO PRODUITS (id_produit, nom_produit, description, prix_unitaire, stock, id_categorie, id_fournisseur, date_ajout, actif)
VALUES (SEQ_PRODUITS.NEXTVAL, 'Chargeur rapide 65W', 'USB-C universel', 35000, 200, 1, 6, SYSDATE, 'O');

COMMIT;
PROMPT >> 20 produits inseres.

-- ============================================================
-- 4. CLIENTS (15)
-- ============================================================
INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Diallo', 'Mamadou', 'mamadou.diallo@gmail.com', '+224 621 001 001', 'Kipé, Ratoma', 'Conakry', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Bah', 'Fatoumata', 'faty.bah@yahoo.fr', '+224 622 002 002', 'Dixinn, Commune', 'Conakry', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Camara', 'Ibrahim', 'ibrahim.camara@outlook.com', '+224 623 003 003', 'Matoto Centre', 'Conakry', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Sow', 'Aissatou', 'aissatou.sow@gmail.com', '+224 624 004 004', 'Madina Marché', 'Conakry', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Touré', 'Ousmane', 'ousmane.toure@gmail.com', '+224 625 005 005', 'Kaloum Centre-Ville', 'Conakry', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Barry', 'Kadiatou', 'kadi.barry@hotmail.com', '+224 626 006 006', 'Hamdallaye', 'Conakry', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Kouyaté', 'Lansana', 'lansana.kouyate@gmail.com', '+224 627 007 007', 'Centre ville', 'Kankan', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Sylla', 'Mariama', 'mariama.sylla@gmail.com', '+224 628 008 008', 'Quartier Mosquée', 'Labé', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Condé', 'Sékou', 'sekou.conde@gmail.com', '+224 629 009 009', 'Sandervalia', 'Conakry', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Traoré', 'Aminata', 'aminata.traore@gmail.com', '+224 620 010 010', 'Belle Vue', 'N''Zérékoré', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Keïta', 'Alpha', 'alpha.keita@gmail.com', '+224 621 011 011', 'Almamya', 'Conakry', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Guilavogui', 'Noel', 'noel.guilavogui@gmail.com', '+224 622 012 012', 'Quartier Centre', 'N''Zérékoré', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Bangoura', 'Mariame', 'mariame.bangoura@gmail.com', '+224 623 013 013', 'Coleah', 'Conakry', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Koïvogui', 'Emmanuel', 'em.koivogui@gmail.com', '+224 624 014 014', 'Quartier Lac', 'Kindia', 'Guinée', SYSDATE, 'O');

INSERT INTO CLIENTS (id_client, nom, prenom, email, telephone, adresse, ville, pays, date_creation, actif)
VALUES (SEQ_CLIENTS.NEXTVAL, 'Haidara', 'Moussa', 'moussa.haidara@gmail.com', '+224 625 015 015', 'Zone Industrielle', 'Conakry', 'Guinée', SYSDATE, 'O');

COMMIT;
PROMPT >> 15 clients inseres.

-- ============================================================
-- 5. COMMANDES (12)
-- ============================================================
INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 1, SYSDATE-30, 'LIVREE', 0, 'Kipé, Ratoma, Conakry');

INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 2, SYSDATE-25, 'LIVREE', 0, 'Dixinn, Conakry');

INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 3, SYSDATE-20, 'EXPEDIEE', 0, 'Matoto, Conakry');

INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 4, SYSDATE-15, 'CONFIRMEE', 0, 'Madina, Conakry');

INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 5, SYSDATE-10, 'CONFIRMEE', 0, 'Kaloum, Conakry');

INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 6, SYSDATE-7, 'EN_ATTENTE', 0, 'Hamdallaye, Conakry');

INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 7, SYSDATE-5, 'EN_ATTENTE', 0, 'Centre, Kankan');

INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 1, SYSDATE-3, 'EN_ATTENTE', 0, 'Kipé, Ratoma, Conakry');

INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 8, SYSDATE-2, 'EN_ATTENTE', 0, 'Labé Centre');

INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 9, SYSDATE-1, 'EN_ATTENTE', 0, 'Sandervalia, Conakry');

INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 10, SYSDATE, 'EN_ATTENTE', 0, 'Belle Vue, N''Zérékoré');

INSERT INTO COMMANDES (id_commande, id_client, date_commande, statut, montant_total, adresse_livraison)
VALUES (SEQ_COMMANDES.NEXTVAL, 2, SYSDATE-45, 'ANNULEE', 0, 'Dixinn, Conakry');

COMMIT;
PROMPT >> 12 commandes inserees.

-- ============================================================
-- 6. LIGNES_COMMANDE (17)
-- ============================================================
INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1000, 1, 1, 750000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1000, 2, 2, 180000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1001, 3, 1, 2500000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1001, 4, 1, 65000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1002, 5, 1, 120000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1002, 6, 3, 25000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1003, 7, 2, 75000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1003, 8, 1, 320000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1004, 10, 2, 185000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1004, 11, 1, 45000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1005, 19, 1, 890000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1005, 20, 2, 35000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1006, 16, 3, 28000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1007, 14, 2, 95000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1008, 9, 1, 85000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1009, 17, 1, 220000);

INSERT INTO LIGNES_COMMANDE (id_ligne, id_commande, id_produit, quantite, prix_unitaire)
VALUES (SEQ_LIGNES_COMMANDE.NEXTVAL, 1010, 18, 5, 18000);

COMMIT;
PROMPT >> 17 lignes de commande inserees.

-- ============================================================
-- 7. Mise à jour des montants totaux des commandes
-- ============================================================
UPDATE COMMANDES c 
SET montant_total = (
    SELECT NVL(SUM(quantite * prix_unitaire), 0)
    FROM LIGNES_COMMANDE l
    WHERE l.id_commande = c.id_commande
);

COMMIT;
PROMPT >> Montants totaux mis a jour.

-- ============================================================
-- 8. PAIEMENTS (6)
-- ============================================================
INSERT INTO PAIEMENTS (id_paiement, id_commande, date_paiement, montant, mode_paiement, statut, reference)
VALUES (SEQ_PAIEMENTS.NEXTVAL, 1000, SYSDATE-29, 1110000, 'MOBILE_MONEY', 'VALIDE', 'PAY-MM-202401-001');

INSERT INTO PAIEMENTS (id_paiement, id_commande, date_paiement, montant, mode_paiement, statut, reference)
VALUES (SEQ_PAIEMENTS.NEXTVAL, 1001, SYSDATE-24, 2565000, 'VIREMENT', 'VALIDE', 'PAY-VIR-202401-002');

INSERT INTO PAIEMENTS (id_paiement, id_commande, date_paiement, montant, mode_paiement, statut, reference)
VALUES (SEQ_PAIEMENTS.NEXTVAL, 1002, SYSDATE-19, 195000, 'CARTE', 'VALIDE', 'PAY-CB-202401-003');

INSERT INTO PAIEMENTS (id_paiement, id_commande, date_paiement, montant, mode_paiement, statut, reference)
VALUES (SEQ_PAIEMENTS.NEXTVAL, 1003, SYSDATE-14, 470000, 'MOBILE_MONEY', 'VALIDE', 'PAY-MM-202401-004');

INSERT INTO PAIEMENTS (id_paiement, id_commande, date_paiement, montant, mode_paiement, statut, reference)
VALUES (SEQ_PAIEMENTS.NEXTVAL, 1004, SYSDATE-9, 415000, 'ESPECES', 'VALIDE', 'PAY-ESP-202401-005');

INSERT INTO PAIEMENTS (id_paiement, id_commande, date_paiement, montant, mode_paiement, statut, reference)
VALUES (SEQ_PAIEMENTS.NEXTVAL, 1005, SYSDATE-6, 960000, 'CARTE', 'EN_ATTENTE', 'PAY-CB-202401-006');

COMMIT;
PROMPT >> 6 paiements inseres.

-- ============================================================
-- 9. LIVRAISONS (3)
-- ============================================================
INSERT INTO LIVRAISONS (id_livraison, id_commande, date_expedition, date_livraison, transporteur, numero_suivi, statut)
VALUES (SEQ_LIVRAISONS.NEXTVAL, 1000, SYSDATE-28, SYSDATE-25, 'Chronopost Guinée', 'CHRON-GN-00001', 'LIVRE');

INSERT INTO LIVRAISONS (id_livraison, id_commande, date_expedition, date_livraison, transporteur, numero_suivi, statut)
VALUES (SEQ_LIVRAISONS.NEXTVAL, 1001, SYSDATE-23, SYSDATE-19, 'DHL Express', 'DHL-GN-00002', 'LIVRE');

INSERT INTO LIVRAISONS (id_livraison, id_commande, date_expedition, date_livraison, transporteur, numero_suivi, statut)
VALUES (SEQ_LIVRAISONS.NEXTVAL, 1002, SYSDATE-18, NULL, 'Colissimo Afrique', 'COL-AF-00003', 'EN_TRANSIT');

COMMIT;
PROMPT >> 3 livraisons inserees.

PROMPT ============================================================
PROMPT  Insertion des donnees de base terminee !
PROMPT ============================================================