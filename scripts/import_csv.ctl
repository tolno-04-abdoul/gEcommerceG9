LOAD DATA
INFILE 'produits.csv'
INTO TABLE PRODUITS
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id_produit        SEQUENCE(MAX,1),
    nom_produit       CHAR(200),
    description       CHAR(500),
    prix_unitaire     DECIMAL EXTERNAL,
    stock             INTEGER EXTERNAL,
    id_categorie      INTEGER EXTERNAL,
    id_fournisseur    INTEGER EXTERNAL,
    date_ajout        SYSDATE,
    actif             CONSTANT 'O'
)