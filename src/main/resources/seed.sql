-- RestoLiv : donnees de demonstration (a executer apres restoliv.sql)
-- ATTENTION : ce script efface les donnees existantes avant d'inserer
-- des exemples dans toutes les tables.

USE restoliv;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM facture;
DELETE FROM paiement;
DELETE FROM commande_detail;
DELETE FROM commande;
DELETE FROM livreur;
DELETE FROM plat;
DELETE FROM admin;
SET FOREIGN_KEY_CHECKS = 1;

-- Administration (mot de passe hache en SHA-256)
INSERT INTO admin (id, username, password) VALUES
(1, 'admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9'),
(2, 'gerant', '38f35912846eb95406aa8620795a68851541e0bd26e1969216ab22352b11f958');

-- Menu
INSERT INTO plat (id, nom, description, prix, disponible) VALUES
(1, 'Poulet Riz Cantonais', 'Poulet saute aux legumes, riz cantonais', 8500.00, 1),
(2, 'Ravitoto', 'Feuilles de manioc pilees et riz blanc', 7000.00, 1),
(3, 'Romazava', 'Boeuf aux herbes locales et riz', 9000.00, 1),
(4, 'Poisson Frit', 'Poisson frais frit, riz vapeur', 15000.00, 1),
(5, 'Pizza Margherita', 'Sauce tomate et fromage fondant', 12000.00, 1),
(6, 'Burger Resto', 'Steak hache, cheddar et frites', 11000.00, 1),
(7, 'Salade Cesar', 'Poulet grille, croutons, sauce cesar', 8000.00, 0),
(8, 'MofoGasy', 'Beignets malgaches, goutter de midi', 3000.00, 1),
(9, 'Jus de Baobab', 'Jus naturel de baobab bien frais', 4000.00, 1),
(10, 'Cafe', 'Cafe noir ou au lait', 2000.00, 1);

-- Livreurs
INSERT INTO livreur (id, nom, telephone, statut) VALUES
(1, 'Jean Randria', '034 00 000 01', 'LIBRE'),
(2, 'Rina Ravelojaona', '033 00 000 02', 'LIBRE'),
(3, 'Tovo Andriamalala', '032 00 000 03', 'EN_LIVRAISON'),
(4, 'Mialisoa Rakotomanga', '034 00 000 04', 'LIBRE');

-- Commandes
INSERT INTO commande (id, reference, nom_client, telephone_client, adresse_livraison,
                      source, statut, livreur_id, total, date_commande) VALUES
(1, 'CMD-20260923080001', 'Aina Randrianarisoa', '034 12 000 01', 'Analakely',
 'APPEL', 'RECUE', 4, 18000.00, '2026-09-23 08:00:00'),
(2, 'CMD-20260923095002', 'Herizo Rakoto', '033 12 000 02', 'Ivandry',
 'WHATSAPP', 'EN_CUISINE', NULL, 23000.00, '2026-09-23 09:50:00'),
(3, 'CMD-20260923110003', 'Vola Andrianina', '034 12 000 03', 'Antanimena',
 'APPEL', 'EN_LIVRAISON', 3, 31500.00, '2026-09-23 11:00:00'),
(4, 'CMD-20260922183004', 'Faly Rajohnson', '032 12 000 04', 'Ambohipo',
 'APPEL', 'LIVREE', 1, 30000.00, '2026-09-22 18:30:00'),
(5, 'CMD-20260922195005', 'Lova Ratsimbazafy', '034 12 000 05', 'Ambodivona',
 'WHATSAPP', 'LIVREE', 2, 27000.00, '2026-09-22 19:50:00'),
(6, 'CMD-20260920180006', 'Nirina Henintsoa', '033 12 000 06', 'Tanjombato',
 'APPEL', 'RETOUR', 2, 20500.00, '2026-09-20 18:00:00');

-- Details des commandes
INSERT INTO commande_detail (commande_id, plat_id, quantite, prix_unitaire, sous_total) VALUES
(1, 2, 2, 7000.00, 14000.00),
(1, 10, 2, 2000.00, 4000.00),
(2, 5, 1, 12000.00, 12000.00),
(2, 6, 1, 11000.00, 11000.00),
(3, 6, 1, 11000.00, 11000.00),
(3, 5, 1, 12000.00, 12000.00),
(3, 1, 1, 8500.00, 8500.00),
(4, 4, 2, 15000.00, 30000.00),
(5, 2, 3, 7000.00, 21000.00),
(5, 8, 2, 3000.00, 6000.00),
(6, 5, 1, 12000.00, 12000.00),
(6, 1, 1, 8500.00, 8500.00);

-- Paiements Mobile Money
INSERT INTO paiement (id, commande_id, mode_paiement, reference, montant, statut) VALUES
(1, 1, 'MOBILE_MONEY', 'MP-2026-0001', 18000.00, 'PAYE'),
(2, 2, 'MOBILE_MONEY', 'MP-2026-0002', 23000.00, 'PAYE'),
(3, 3, 'MOBILE_MONEY', 'MP-2026-0003', 31500.00, 'PAYE'),
(4, 4, 'MOBILE_MONEY', 'MP-2026-0004', 30000.00, 'PAYE'),
(5, 5, 'MOBILE_MONEY', 'MP-2026-0005', 27000.00, 'PAYE'),
(6, 6, 'MOBILE_MONEY', 'MP-2026-0006', 20500.00, 'PAYE');

-- Factures
INSERT INTO facture (id, commande_id, numero_facture, date_facture, montant_total) VALUES
(1, 1, 'FAC-20260923080001', '2026-09-23 08:00:00', 18000.00),
(2, 2, 'FAC-20260923095002', '2026-09-23 09:50:00', 23000.00),
(3, 3, 'FAC-20260923110003', '2026-09-23 11:00:00', 31500.00),
(4, 4, 'FAC-20260922183004', '2026-09-22 18:30:00', 30000.00),
(5, 5, 'FAC-20260922195005', '2026-09-22 19:50:00', 27000.00),
(6, 6, 'FAC-20260920180006', '2026-09-20 18:00:00', 20500.00);