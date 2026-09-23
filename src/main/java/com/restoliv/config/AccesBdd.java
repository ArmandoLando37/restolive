package com.restoliv.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Centralise la connexion MySQL pour tous les DAO.
public class AccesBdd {

    // Configuration de la base restoliv (XAMPP local)
    private static final String URL = "jdbc:mysql://localhost:3306/restoliv?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
    private static final String UTILISATEUR = "root";
    private static final String MOT_DE_PASSE = "";

    static {
        try {
            // Charge le driver MySQL une seule fois
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver MySQL introuvable", e);
        }
    }

    // Retourne une connexion vers la base restoliv
    public static Connection obtenirConnexion() throws SQLException {
        return DriverManager.getConnection(URL, UTILISATEUR, MOT_DE_PASSE);
    }
}