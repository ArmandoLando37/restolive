package com.restoliv.service;

import com.restoliv.config.AccesBdd;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

// Outils communs aux tests : assertions, compteurs et donnees temporaires.
public class TestUtil {

    private static int reussites = 0;
    private static int echecs = 0;

    // Verifie une condition et affiche OK ou ECHEC
    public static void verifier(boolean condition, String message) {
        if (condition) {
            reussites++;
            System.out.println("  OK : " + message);
        } else {
            echecs++;
            System.out.println("  ECHEC : " + message);
        }
    }

    public static void reinitialiserCompteurs() {
        reussites = 0;
        echecs = 0;
    }

    public static int getReussites() {
        return reussites;
    }

    public static int getEchecs() {
        return echecs;
    }

    // Insere un plat temporaire et retourne son id
    public static int insererPlat(String nom, String prix, int disponible) {
        String sql = "INSERT INTO plat (nom, prix, disponible) VALUES (?, ?, ?)";
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, nom);
            statement.setBigDecimal(2, new BigDecimal(prix));
            statement.setInt(3, disponible);
            statement.executeUpdate();
            ResultSet cle = statement.getGeneratedKeys();
            if (cle.next()) {
                return cle.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Insere un livreur temporaire et retourne son id
    public static int insererLivreur(String nom, String statut) {
        String sql = "INSERT INTO livreur (nom, telephone, statut) VALUES (?, ?, ?)";
        try (Connection connexion = AccesBdd.obtenirConnexion();
             PreparedStatement statement = connexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, nom);
            statement.setString(2, "0340000000");
            statement.setString(3, statut);
            statement.executeUpdate();
            ResultSet cle = statement.getGeneratedKeys();
            if (cle.next()) {
                return cle.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void supprimerPlat(int id) {
        executer("DELETE FROM plat WHERE id = " + id);
    }

    public static void supprimerLivreur(int id) {
        executer("DELETE FROM livreur WHERE id = " + id);
    }

    // Supprime une commande et ses fichiers (details, paiement, facture)
    public static void supprimerCommande(int id) {
        executer("DELETE FROM facture WHERE commande_id = " + id);
        executer("DELETE FROM paiement WHERE commande_id = " + id);
        executer("DELETE FROM commande_detail WHERE commande_id = " + id);
        executer("DELETE FROM commande WHERE id = " + id);
    }

    private static void executer(String sql) {
        try (Connection connexion = AccesBdd.obtenirConnexion();
             Statement statement = connexion.createStatement()) {
            statement.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}