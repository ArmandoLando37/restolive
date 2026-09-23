package com.restoliv.dao;

import com.restoliv.config.AccesBdd;
import com.restoliv.model.Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// Acces aux donnees de la table admin.
public class AdminDAO {

    // Retrouve l'admin par son nom d'utilisateur
    public Admin findByUsername(String username) {
        String sql = "SELECT id, username, password FROM admin WHERE username = ?";
        Admin admin = null;
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql)) {
            statement.setString(1, username);
            try (ResultSet resultat = statement.executeQuery()) {
                if (resultat.next()) {
                    admin = new Admin();
                    admin.setId(resultat.getInt("id"));
                    admin.setUsername(resultat.getString("username"));
                    admin.setPassword(resultat.getString("password"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }
}