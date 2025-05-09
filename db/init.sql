CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Table produits
CREATE TABLE IF NOT EXISTS produits (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    prix DECIMAL(10,2) NOT NULL,
    quantite_en_stock INT NOT NULL CHECK (quantite_en_stock >= 0)
);

-- Table commandes
CREATE TABLE IF NOT EXISTS commandes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    statut VARCHAR(50) CHECK (statut IN ('en attente', 'en cours', 'expédiée', 'annulée')),
    date_commande TIMESTAMP DEFAULT NOW(),
    total DECIMAL(10,2) DEFAULT 0.00
);

-- Table commandes_produits (relation N-N)
CREATE TABLE IF NOT EXISTS commandes_produits (
    id INT PRIMARY KEY AUTO_INCREMENT,
    commande_id INT,
    produit_id INT,
    quantite INT NOT NULL CHECK (quantite >= 1),
    FOREIGN KEY (commande_id) REFERENCES commandes(id),
    FOREIGN KEY (produit_id) REFERENCES produits(id)
);
