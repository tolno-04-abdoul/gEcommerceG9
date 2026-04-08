-- ============================================================
-- PROJET FINAL ORACLE - GESTION E-COMMERCE
-- Script MASTER : Exécution complète dans l'ordre
-- Version 2.0 - Avec donnees aleatoires
-- ============================================================

PROMPT ============================================================
PROMPT  IST MAMOU - Département Génie Informatique
PROMPT  Projet Final Oracle - Gestion E-Commerce
PROMPT  Version avec generation aleatoire
PROMPT ============================================================
PROMPT.

PROMPT [1/9] Creation des tables...
@01_creation_tables.sql

PROMPT [2/9] Creation des sequences...
@02_sequences.sql

PROMPT [3/9] Creation des index...
@05_index.sql

PROMPT [4/9] Insertion des donnees de base...
@04_insertion_donnees.sql

PROMPT [5/9] Generation des donnees aleatoires (DBMS_RANDOM)...
@11_generation_aleatoire.sql

PROMPT [6/9] Creation des vues et vues materialisees...
@06_vues.sql

PROMPT [7/9] Creation des triggers...
@07_triggers.sql

PROMPT [8/9] Requetes MERGE et avancees...
@08_merge_requetes.sql

PROMPT [9/9] Verification finale...
@verification.sql

PROMPT.
PROMPT ============================================================
PROMPT  PROJET INSTALLE AVEC SUCCES !
PROMPT  Donnees aleatoires generees.
PROMPT  Pour la gestion des utilisateurs/roles, lancer en SYSDBA :
PROMPT  @03_utilisateurs_roles.sql
PROMPT  Pour la sauvegarde auto : scripts\install_planification.bat
PROMPT ============================================================