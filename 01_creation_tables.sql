-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script 01 : Création des tables
-- ============================================================

-- Suppression des tables si elles existent déjà (ordre inverse des dépendances)
BEGIN
    FOR t IN (SELECT table_name FROM user_tables 
              WHERE table_name IN ('PAIEMENTS','LIGNES_COMMANDE','COMMANDES',
                                   'PRODUITS','CATEGORIES','CLIENTS','FOURNISSEURS','LIVRAISONS','LOG_COMMANDES')) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/

-- TABLE : CATEGORIES
CREATE TABLE CATEGORIES (
    id_categorie   NUMBER(10)       NOT NULL,
    nom_categorie  VARCHAR2(100)    NOT NULL,
    description    VARCHAR2(255),
    date_creation  DATE             DEFAULT SYSDATE,
    CONSTRAINT pk_categories PRIMARY KEY (id_categorie)
);

-- TABLE : FOURNISSEURS
CREATE TABLE FOURNISSEURS (
    id_fournisseur  NUMBER(10)      NOT NULL,
    nom             VARCHAR2(100)   NOT NULL,
    email           VARCHAR2(150)   UNIQUE NOT NULL,
    telephone       VARCHAR2(20),
    adresse         VARCHAR2(255),
    pays            VARCHAR2(100),
    date_ajout      DATE            DEFAULT SYSDATE,
    CONSTRAINT pk_fournisseurs PRIMARY KEY (id_fournisseur)
);

-- TABLE : PRODUITS
CREATE TABLE PRODUITS (
    id_produit      NUMBER(10)      NOT NULL,
    nom_produit     VARCHAR2(200)   NOT NULL,
    description     VARCHAR2(500),
    prix_unitaire   NUMBER(12,2)    NOT NULL,
    stock           NUMBER(10)      DEFAULT 0,
    id_categorie    NUMBER(10)      NOT NULL,
    id_fournisseur  NUMBER(10)      NOT NULL,
    date_ajout      DATE            DEFAULT SYSDATE,
    actif           CHAR(1)         DEFAULT 'O' CHECK (actif IN ('O','N')),
    CONSTRAINT pk_produits       PRIMARY KEY (id_produit),
    CONSTRAINT fk_prod_categorie FOREIGN KEY (id_categorie)   REFERENCES CATEGORIES(id_categorie),
    CONSTRAINT fk_prod_fourn     FOREIGN KEY (id_fournisseur) REFERENCES FOURNISSEURS(id_fournisseur),
    CONSTRAINT ck_prix           CHECK (prix_unitaire > 0),
    CONSTRAINT ck_stock          CHECK (stock >= 0)
);

-- TABLE : CLIENTS
CREATE TABLE CLIENTS (
    id_client     NUMBER(10)      NOT NULL,
    nom           VARCHAR2(100)   NOT NULL,
    prenom        VARCHAR2(100)   NOT NULL,
    email         VARCHAR2(150)   UNIQUE NOT NULL,
    telephone     VARCHAR2(20),
    adresse       VARCHAR2(255),
    ville         VARCHAR2(100),
    pays          VARCHAR2(100)   DEFAULT 'Guinée',
    date_creation DATE            DEFAULT SYSDATE,
    actif         CHAR(1)         DEFAULT 'O' CHECK (actif IN ('O','N')),
    CONSTRAINT pk_clients PRIMARY KEY (id_client)
);

-- TABLE : COMMANDES
CREATE TABLE COMMANDES (
    id_commande      NUMBER(10)     NOT NULL,
    id_client        NUMBER(10)     NOT NULL,
    date_commande    DATE           DEFAULT SYSDATE,
    statut           VARCHAR2(30)   DEFAULT 'EN_ATTENTE'
                     CHECK (statut IN ('EN_ATTENTE','CONFIRMEE','EXPEDIEE','LIVREE','ANNULEE')),
    montant_total    NUMBER(14,2)   DEFAULT 0,
    adresse_livraison VARCHAR2(255),
    CONSTRAINT pk_commandes    PRIMARY KEY (id_commande),
    CONSTRAINT fk_cmd_client   FOREIGN KEY (id_client) REFERENCES CLIENTS(id_client)
);

-- TABLE : LIGNES_COMMANDE
CREATE TABLE LIGNES_COMMANDE (
    id_ligne       NUMBER(10)    NOT NULL,
    id_commande    NUMBER(10)    NOT NULL,
    id_produit     NUMBER(10)    NOT NULL,
    quantite       NUMBER(8)     NOT NULL,
    prix_unitaire  NUMBER(12,2)  NOT NULL,
    sous_total     NUMBER(14,2)  GENERATED ALWAYS AS (quantite * prix_unitaire) VIRTUAL,
    CONSTRAINT pk_lignes       PRIMARY KEY (id_ligne),
    CONSTRAINT fk_ligne_cmd    FOREIGN KEY (id_commande) REFERENCES COMMANDES(id_commande),
    CONSTRAINT fk_ligne_prod   FOREIGN KEY (id_produit)  REFERENCES PRODUITS(id_produit),
    CONSTRAINT ck_qte          CHECK (quantite > 0)
);

-- TABLE : PAIEMENTS
CREATE TABLE PAIEMENTS (
    id_paiement     NUMBER(10)    NOT NULL,
    id_commande     NUMBER(10)    NOT NULL,
    date_paiement   DATE          DEFAULT SYSDATE,
    montant         NUMBER(14,2)  NOT NULL,
    mode_paiement   VARCHAR2(50)  CHECK (mode_paiement IN ('CARTE','VIREMENT','MOBILE_MONEY','ESPECES')),
    statut          VARCHAR2(20)  DEFAULT 'EN_ATTENTE'
                    CHECK (statut IN ('EN_ATTENTE','VALIDE','REFUSE','REMBOURSE')),
    reference       VARCHAR2(100) UNIQUE,
    CONSTRAINT pk_paiements   PRIMARY KEY (id_paiement),
    CONSTRAINT fk_paie_cmd    FOREIGN KEY (id_commande) REFERENCES COMMANDES(id_commande)
);

-- TABLE : LIVRAISONS
CREATE TABLE LIVRAISONS (
    id_livraison     NUMBER(10)   NOT NULL,
    id_commande      NUMBER(10)   NOT NULL,
    date_expedition  DATE,
    date_livraison   DATE,
    transporteur     VARCHAR2(100),
    numero_suivi     VARCHAR2(100) UNIQUE,
    statut           VARCHAR2(30)  DEFAULT 'EN_PREPARATION'
                     CHECK (statut IN ('EN_PREPARATION','EXPEDIE','EN_TRANSIT','LIVRE','ECHEC')),
    CONSTRAINT pk_livraisons  PRIMARY KEY (id_livraison),
    CONSTRAINT fk_liv_cmd     FOREIGN KEY (id_commande) REFERENCES COMMANDES(id_commande)
);

-- TABLE : LOG_COMMANDES (pour audit)
CREATE TABLE LOG_COMMANDES (
    id_log NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_commande NUMBER(10),
    ancien_statut VARCHAR2(30),
    nouveau_statut VARCHAR2(30),
    date_action DATE DEFAULT SYSDATE,
    utilisateur VARCHAR2(100) DEFAULT SYS_CONTEXT('USERENV','SESSION_USER')
);

COMMIT;