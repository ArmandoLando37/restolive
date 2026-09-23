-- RestoLiv : creation de la base et des tables
-- A executer une seule fois avec XAMPP (MariaDB)

CREATE DATABASE IF NOT EXISTS restoliv
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_general_ci;

USE restoliv;

-- Table admin : un seul utilisateur (Admin / Gerant)
CREATE TABLE IF NOT EXISTS admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Table plat : menu du restaurant
CREATE TABLE IF NOT EXISTS plat (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    prix DECIMAL(10,2) NOT NULL,
    disponible TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Table livreur
CREATE TABLE IF NOT EXISTS livreur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    statut ENUM('LIBRE','EN_LIVRAISON') NOT NULL DEFAULT 'LIBRE'
) ENGINE=InnoDB;

-- Table commande
CREATE TABLE IF NOT EXISTS commande (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reference VARCHAR(50) NOT NULL UNIQUE,
    nom_client VARCHAR(100) NOT NULL,
    telephone_client VARCHAR(20) NOT NULL,
    adresse_livraison VARCHAR(255) NOT NULL,
    source ENUM('APPEL','WHATSAPP') NOT NULL,
    statut ENUM('RECUE','EN_CUISINE','EN_LIVRAISON','LIVREE','RETOUR') NOT NULL DEFAULT 'RECUE',
    livreur_id INT,
    total DECIMAL(10,2) NOT NULL,
    date_commande TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_commande_livreur FOREIGN KEY (livreur_id) REFERENCES livreur(id)
) ENGINE=InnoDB;

-- Table commande_detail : contient au moins un plat par commande
CREATE TABLE IF NOT EXISTS commande_detail (
    id INT AUTO_INCREMENT PRIMARY KEY,
    commande_id INT NOT NULL,
    plat_id INT NOT NULL,
    quantite INT NOT NULL,
    prix_unitaire DECIMAL(10,2) NOT NULL,
    sous_total DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_detail_commande FOREIGN KEY (commande_id) REFERENCES commande(id),
    CONSTRAINT fk_detail_plat FOREIGN KEY (plat_id) REFERENCES plat(id)
) ENGINE=InnoDB;

-- Table paiement : Mobile Money uniquement
CREATE TABLE IF NOT EXISTS paiement (
    id INT AUTO_INCREMENT PRIMARY KEY,
    commande_id INT NOT NULL,
    mode_paiement ENUM('MOBILE_MONEY') NOT NULL,
    reference VARCHAR(100) NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    date_paiement TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    statut ENUM('PAYE') NOT NULL DEFAULT 'PAYE',
    CONSTRAINT fk_paiement_commande FOREIGN KEY (commande_id) REFERENCES commande(id)
) ENGINE=InnoDB;

-- Table facture
CREATE TABLE IF NOT EXISTS facture (
    id INT AUTO_INCREMENT PRIMARY KEY,
    commande_id INT NOT NULL,
    numero_facture VARCHAR(50) NOT NULL UNIQUE,
    date_facture TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    montant_total DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_facture_commande FOREIGN KEY (commande_id) REFERENCES commande(id)
) ENGINE=InnoDB;

-- Admin par defaut : username admin / mot de passe admin123
-- Le mot de passe est stocke en SHA-256 (jamais en clair).
INSERT INTO admin (username, password)
VALUES ('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');