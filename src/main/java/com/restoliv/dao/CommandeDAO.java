package com.restoliv.dao;

import com.restoliv.config.AccesBdd;
import com.restoliv.model.Commande;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

// Acces aux donnees de la table commande.
public class CommandeDAO {

    // Enregistre une commande dans la transaction fournie par le Service
    public int save(Connection connexion, Commande commande) {
        String sql = "INSERT INTO commande (reference, nom_client, telephone_client, "
                + "adresse_livraison, source, statut, livreur_id, total) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        int id = 0;
        try (PreparedStatement statement = connexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, commande.getReference());
            statement.setString(2, commande.getNomClient());
            statement.setString(3, commande.getTelephoneClient());
            statement.setString(4, commande.getAdresseLivraison());
            statement.setString(5, commande.getSource());
            statement.setString(6, commande.getStatut());
            if (commande.getLivreurId() > 0) {
                statement.setInt(7, commande.getLivreurId());
            } else {
                statement.setNull(7, Types.INTEGER);
            }
            statement.setBigDecimal(8, commande.getTotal());
            statement.executeUpdate();
            try (ResultSet cle = statement.getGeneratedKeys()) {
                if (cle.next()) {
                    id = cle.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
    }

    // Liste toutes les commandes avec le nom du livreur
    public List<Commande> findAll() {
        String sql = "SELECT c.id, c.reference, c.nom_client, c.telephone_client, "
                + "c.adresse_livraison, c.source, c.statut, c.livreur_id, c.total, "
                + "c.date_commande, l.nom AS nom_livreur "
                + "FROM commande c LEFT JOIN livreur l ON c.livreur_id = l.id "
                + "ORDER BY c.date_commande DESC";
        List<Commande> commandes = new ArrayList<>();
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql);
             ResultSet resultat = statement.executeQuery()) {
            while (resultat.next()) {
                commandes.add(mapperCommande(resultat));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commandes;
    }

    // Retrouve une commande par son id
    public Commande findById(int id) {
        String sql = "SELECT c.id, c.reference, c.nom_client, c.telephone_client, "
                + "c.adresse_livraison, c.source, c.statut, c.livreur_id, c.total, "
                + "c.date_commande, l.nom AS nom_livreur "
                + "FROM commande c LEFT JOIN livreur l ON c.livreur_id = l.id "
                + "WHERE c.id = ?";
        Commande commande = null;
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultat = statement.executeQuery()) {
                if (resultat.next()) {
                    commande = mapperCommande(resultat);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commande;
    }

    // Change le statut d'une commande dans la transaction fournie par le Service
    public void updateStatut(Connection connexion, int id, String statut) {
        String sql = "UPDATE commande SET statut = ? WHERE id = ?";
        try (PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setString(1, statut);
            statement.setInt(2, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Compte les commandes ayant un statut donne
    public int compterParStatut(String statut) {
        String sql = "SELECT COUNT(*) AS total FROM commande WHERE statut = ?";
        return compter(sql, statut);
    }

    // Compte les commandes du jour
    public int compterCommandesAujourdhui() {
        String sql = "SELECT COUNT(*) AS total FROM commande WHERE DATE(date_commande) = CURDATE()";
        return compter(sql, null);
    }

    // Somme des totaux des commandes du jour (chiffre d'affaires)
    public BigDecimal sommeTotalAujourdhui() {
        String sql = "SELECT COALESCE(SUM(total), 0) AS total FROM commande WHERE DATE(date_commande) = CURDATE()";
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql);
             ResultSet resultat = statement.executeQuery()) {
            if (resultat.next()) {
                return resultat.getBigDecimal("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    // Execute un COUNT avec un parametre optionnel
    private int compter(String sql, String parametre) {
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            if (parametre != null) {
                statement.setString(1, parametre);
            }
            try (ResultSet resultat = statement.executeQuery()) {
                if (resultat.next()) {
                    return resultat.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Transforme une ligne de resultat en objet Commande
    private Commande mapperCommande(ResultSet resultat) throws SQLException {
        Commande commande = new Commande();
        commande.setId(resultat.getInt("id"));
        commande.setReference(resultat.getString("reference"));
        commande.setNomClient(resultat.getString("nom_client"));
        commande.setTelephoneClient(resultat.getString("telephone_client"));
        commande.setAdresseLivraison(resultat.getString("adresse_livraison"));
        commande.setSource(resultat.getString("source"));
        commande.setStatut(resultat.getString("statut"));
        Object idLivreur = resultat.getObject("livreur_id");
        commande.setLivreurId(idLivreur != null ? ((Number) idLivreur).intValue() : 0);
        commande.setTotal(resultat.getBigDecimal("total"));
        if (resultat.getTimestamp("date_commande") != null) {
            commande.setDateCommande(resultat.getTimestamp("date_commande").toLocalDateTime());
        }
        String nomLivreur = resultat.getString("nom_livreur");
        if (nomLivreur != null) {
            commande.setNomLivreur(nomLivreur);
        }
        return commande;
    }
}