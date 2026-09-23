package com.restoliv.dao;

import com.restoliv.config.AccesBdd;
import com.restoliv.model.Livreur;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// Acces aux donnees de la table livreur.
public class LivreurDAO {

    // Liste tous les livreurs
    public List<Livreur> findAll() {
        String sql = "SELECT id, nom, telephone, statut FROM livreur ORDER BY nom";
        List<Livreur> livreurs = new ArrayList<>();
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql);
             ResultSet resultat = statement.executeQuery()) {
            while (resultat.next()) {
                livreurs.add(mapperLivreur(resultat));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return livreurs;
    }

    // Liste les livreurs disponibles (statut LIBRE)
    public List<Livreur> findAvailableDrivers() {
        String sql = "SELECT id, nom, telephone, statut FROM livreur "
                + "WHERE statut = 'LIBRE' ORDER BY nom";
        List<Livreur> livreurs = new ArrayList<>();
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql);
             ResultSet resultat = statement.executeQuery()) {
            while (resultat.next()) {
                livreurs.add(mapperLivreur(resultat));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return livreurs;
    }

    // Retrouve un livreur par son id
    public Livreur findById(int id) {
        String sql = "SELECT id, nom, telephone, statut FROM livreur WHERE id = ?";
        Livreur livreur = null;
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultat = statement.executeQuery()) {
                if (resultat.next()) {
                    livreur = mapperLivreur(resultat);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return livreur;
    }

    // Ajoute un nouveau livreur
    public void save(Livreur livreur) {
        String sql = "INSERT INTO livreur (nom, telephone, statut) VALUES (?, ?, ?)";
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setString(1, livreur.getNom());
            statement.setString(2, livreur.getTelephone());
            statement.setString(3, livreur.getStatut());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Modifie un livreur existant
    public void update(Livreur livreur) {
        String sql = "UPDATE livreur SET nom = ?, telephone = ?, statut = ? WHERE id = ?";
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setString(1, livreur.getNom());
            statement.setString(2, livreur.getTelephone());
            statement.setString(3, livreur.getStatut());
            statement.setInt(4, livreur.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Compte les livreurs ayant un statut donne
    public int compterParStatut(String statut) {
        String sql = "SELECT COUNT(*) AS total FROM livreur WHERE statut = ?";
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setString(1, statut);
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

    // Change le statut d'un livreur dans une transaction donnee
    public void updateStatut(Connection connexion, int id, String statut) {
        String sql = "UPDATE livreur SET statut = ? WHERE id = ?";
        try (PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setString(1, statut);
            statement.setInt(2, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Transforme une ligne de resultat en objet Livreur
    private Livreur mapperLivreur(ResultSet resultat) throws SQLException {
        Livreur livreur = new Livreur();
        livreur.setId(resultat.getInt("id"));
        livreur.setNom(resultat.getString("nom"));
        livreur.setTelephone(resultat.getString("telephone"));
        livreur.setStatut(resultat.getString("statut"));
        return livreur;
    }
}