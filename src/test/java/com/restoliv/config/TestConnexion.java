package com.restoliv.config;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

// Petit test manuel pour verifier la connexion a la base restoliv.
public class TestConnexion {

    public static void main(String[] args) {
        try (Connection connexion = AccesBdd.obtenirConnexion();
             Statement statement = connexion.createStatement();
             ResultSet resultat = statement.executeQuery("SELECT VERSION()")) {

            if (resultat.next()) {
                System.out.println("Connexion reussie, version : " + resultat.getString(1));
            }
        } catch (Exception e) {
            System.out.println("Echec de la connexion : " + e.getMessage());
        }
    }
}