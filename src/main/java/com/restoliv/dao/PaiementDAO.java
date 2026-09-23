package com.restoliv.dao;

import com.restoliv.config.AccesBdd;
import com.restoliv.model.Paiement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// Acces aux donnees de la table paiement.
public class PaiementDAO {

    // Enregistre un paiement dans la transaction fournie par le Service
    public void save(Connection connexion, Paiement paiement) {
        String sql = "INSERT INTO paiement (commande_id, mode_paiement, reference, "
                + "montant, statut) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setInt(1, paiement.getCommandeId());
            statement.setString(2, paiement.getModePaiement());
            statement.setString(3, paiement.getReference());
            statement.setBigDecimal(4, paiement.getMontant());
            statement.setString(5, paiement.getStatut());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Retrouve le paiement d'une commande
    public Paiement findByCommandeId(int commandeId) {
        String sql = "SELECT id, commande_id, mode_paiement, reference, montant, "
                + "date_paiement, statut FROM paiement WHERE commande_id = ?";
        Paiement paiement = null;
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setInt(1, commandeId);
            try (ResultSet resultat = statement.executeQuery()) {
                if (resultat.next()) {
                    paiement = new Paiement();
                    paiement.setId(resultat.getInt("id"));
                    paiement.setCommandeId(resultat.getInt("commande_id"));
                    paiement.setModePaiement(resultat.getString("mode_paiement"));
                    paiement.setReference(resultat.getString("reference"));
                    paiement.setMontant(resultat.getBigDecimal("montant"));
                    if (resultat.getTimestamp("date_paiement") != null) {
                        paiement.setDatePaiement(resultat.getTimestamp("date_paiement").toLocalDateTime());
                    }
                    paiement.setStatut(resultat.getString("statut"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paiement;
    }
}