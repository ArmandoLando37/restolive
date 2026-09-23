package com.restoliv.dao;

import com.restoliv.config.AccesBdd;
import com.restoliv.model.CommandeDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// Acces aux donnees de la table commande_detail.
public class CommandeDetailDAO {

    // Enregistre une ligne de commande dans la transaction fournie par le Service
    public void save(Connection connexion, CommandeDetail detail) {
        String sql = "INSERT INTO commande_detail (commande_id, plat_id, quantite, "
                + "prix_unitaire, sous_total) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setInt(1, detail.getCommandeId());
            statement.setInt(2, detail.getPlatId());
            statement.setInt(3, detail.getQuantite());
            statement.setBigDecimal(4, detail.getPrixUnitaire());
            statement.setBigDecimal(5, detail.getSousTotal());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Liste les lignes d'une commande avec le nom du plat
    public List<CommandeDetail> findByCommandeId(int commandeId) {
        String sql = "SELECT d.id, d.commande_id, d.plat_id, d.quantite, "
                + "d.prix_unitaire, d.sous_total, p.nom AS nom_plat "
                + "FROM commande_detail d JOIN plat p ON d.plat_id = p.id "
                + "WHERE d.commande_id = ? ORDER BY d.id";
        List<CommandeDetail> details = new ArrayList<>();
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setInt(1, commandeId);
            try (ResultSet resultat = statement.executeQuery()) {
                while (resultat.next()) {
                    CommandeDetail detail = new CommandeDetail();
                    detail.setId(resultat.getInt("id"));
                    detail.setCommandeId(resultat.getInt("commande_id"));
                    detail.setPlatId(resultat.getInt("plat_id"));
                    detail.setQuantite(resultat.getInt("quantite"));
                    detail.setPrixUnitaire(resultat.getBigDecimal("prix_unitaire"));
                    detail.setSousTotal(resultat.getBigDecimal("sous_total"));
                    detail.setNomPlat(resultat.getString("nom_plat"));
                    details.add(detail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }
}