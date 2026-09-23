package com.restoliv.dao;

import com.restoliv.config.AccesBdd;
import com.restoliv.model.Plat;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

// Acces aux donnees de la table plat.
public class PlatDAO {

    // Liste tous les plats
    public List<Plat> findAll() {
        return chercher("SELECT id, nom, description, prix, disponible, created_at "
                + "FROM plat ORDER BY nom");
    }

    // Liste les plats encore disponibles a la vente
    public List<Plat> findDisponibles() {
        return chercher("SELECT id, nom, description, prix, disponible, created_at "
                + "FROM plat WHERE disponible = 1 ORDER BY nom");
    }

    // Retrouve un plat par son id
    public Plat findById(int id) {
        String sql = "SELECT id, nom, description, prix, disponible, created_at FROM plat WHERE id = ?";
        Plat plat = null;
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultat = statement.executeQuery()) {
                if (resultat.next()) {
                    plat = mapperPlat(resultat);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return plat;
    }

    // Ajoute un nouveau plat
    public void save(Plat plat) {
        String sql = "INSERT INTO plat (nom, description, prix, disponible) VALUES (?, ?, ?, ?)";
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setString(1, plat.getNom());
            statement.setString(2, plat.getDescription());
            statement.setBigDecimal(3, plat.getPrix());
            statement.setBoolean(4, plat.isDisponible());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Modifie un plat existant
    public void update(Plat plat) {
        String sql = "UPDATE plat SET nom = ?, description = ?, prix = ?, disponible = ? WHERE id = ?";
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setString(1, plat.getNom());
            statement.setString(2, plat.getDescription());
            statement.setBigDecimal(3, plat.getPrix());
            statement.setBoolean(4, plat.isDisponible());
            statement.setInt(5, plat.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Desactive un plat sans le supprimer (disponible = false)
    public void desactiver(int id) {
        String sql = "UPDATE plat SET disponible = 0 WHERE id = ?";
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Recherche les plats par nom (recherche textuelle)
    public List<Plat> searchByName(String motCle) {
        String sql = "SELECT id, nom, description, prix, disponible, created_at "
                + "FROM plat WHERE nom LIKE ? ORDER BY nom";
        List<Plat> plats = new ArrayList<>();
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setString(1, "%" + motCle + "%");
            try (ResultSet resultat = statement.executeQuery()) {
                while (resultat.next()) {
                    plats.add(mapperPlat(resultat));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return plats;
    }

    // Tri des plats par prix croissant
    public List<Plat> findTriesParPrixAsc() {
        return chercher("SELECT id, nom, description, prix, disponible, created_at "
                + "FROM plat ORDER BY prix ASC");
    }

    // Tri des plats par prix decroissant
    public List<Plat> findTriesParPrixDesc() {
        return chercher("SELECT id, nom, description, prix, disponible, created_at "
                + "FROM plat ORDER BY prix DESC");
    }

    // Execute une requete simple sans parametre
    private List<Plat> chercher(String sql) {
        List<Plat> plats = new ArrayList<>();
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql);
             ResultSet resultat = statement.executeQuery()) {
            while (resultat.next()) {
                plats.add(mapperPlat(resultat));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return plats;
    }

    // Transforme une ligne de resultat en objet Plat
    private Plat mapperPlat(ResultSet resultat) throws SQLException {
        Plat plat = new Plat();
        plat.setId(resultat.getInt("id"));
        plat.setNom(resultat.getString("nom"));
        plat.setDescription(resultat.getString("description"));
        plat.setPrix(resultat.getBigDecimal("prix"));
        plat.setDisponible(resultat.getBoolean("disponible"));
        if (resultat.getTimestamp("created_at") != null) {
            plat.setCreatedAt(resultat.getTimestamp("created_at").toLocalDateTime());
        }
        return plat;
    }
}