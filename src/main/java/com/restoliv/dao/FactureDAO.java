package com.restoliv.dao;

import com.restoliv.config.AccesBdd;
import com.restoliv.model.Facture;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// Acces aux donnees de la table facture.
public class FactureDAO {

    // Enregistre une facture dans la transaction fournie par le Service
    public void save(Connection connexion, Facture facture) {
        String sql = "INSERT INTO facture (commande_id, numero_facture, montant_total) "
                + "VALUES (?, ?, ?)";
        try (PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setInt(1, facture.getCommandeId());
            statement.setString(2, facture.getNumeroFacture());
            statement.setBigDecimal(3, facture.getMontantTotal());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Retrouve la facture d'une commande
    public Facture findByCommandeId(int commandeId) {
        String sql = "SELECT id, commande_id, numero_facture, date_facture, montant_total "
                + "FROM facture WHERE commande_id = ?";
        Facture facture = null;
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setInt(1, commandeId);
            try (ResultSet resultat = statement.executeQuery()) {
                if (resultat.next()) {
                    facture = new Facture();
                    facture.setId(resultat.getInt("id"));
                    facture.setCommandeId(resultat.getInt("commande_id"));
                    facture.setNumeroFacture(resultat.getString("numero_facture"));
                    if (resultat.getTimestamp("date_facture") != null) {
                        facture.setDateFacture(resultat.getTimestamp("date_facture").toLocalDateTime());
                    }
                    facture.setMontantTotal(resultat.getBigDecimal("montant_total"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return facture;
    }
}