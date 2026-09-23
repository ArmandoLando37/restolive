package com.restoliv.service;

import com.restoliv.config.AccesBdd;
import com.restoliv.model.Plat;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

// Petit test manuel des Services.
public class TestService {

    public static void main(String[] args) throws Exception {
        // Test de l'authentification
        AuthService authService = new AuthService();
        System.out.println("auth admin/admin123 : " + authService.auth("admin", "admin123"));
        System.out.println("auth admin/mauvais : " + authService.auth("admin", "mauvais"));

        // Insertion de plats temporaires pour tester l'Interpolation Search
        List<Integer> ids = new ArrayList<>();
        Connection connexion = AccesBdd.obtenirConnexion();
        ajouterPlatTemporaire(connexion, ids, "Poulet Broche", "8000");
        ajouterPlatTemporaire(connexion, ids, "Riz Cantonais", "6500");
        ajouterPlatTemporaire(connexion, ids, "Pizza", "12000");
        ajouterPlatTemporaire(connexion, ids, "Poisson", "15000");
        connexion.close();

        PlatService platService = new PlatService();
        List<Plat> tries = platService.trierPlatsParPrixAsc();
        System.out.print("Prix tries : ");
        for (Plat plat : tries) {
            System.out.print(plat.getPrix() + " ");
        }
        System.out.println();

        // Budget identique a un prix exact
        Plat exact = platService.chercherPlatParBudget(new BigDecimal("12000"));
        System.out.println("Budget 12000 -> " + (exact != null ? exact.getPrix() : "aucun"));

        // Budget sans prix exact : retourne le plus proche
        Plat proche = platService.chercherPlatParBudget(new BigDecimal("9000"));
        System.out.println("Budget 9000 -> " + (proche != null ? proche.getPrix() : "aucun"));

        // Nettoyage des plats temporaires
        Connection nettoyage = AccesBdd.obtenirConnexion();
        PreparedStatement suppression = nettoyage.prepareStatement("DELETE FROM plat WHERE id = ?");
        for (Integer id : ids) {
            suppression.setInt(1, id);
            suppression.executeUpdate();
        }
        suppression.close();
        nettoyage.close();
        System.out.println("Plats temporaires supprimes.");
    }

    private static void ajouterPlatTemporaire(Connection connexion, List<Integer> ids,
            String nom, String prix) throws Exception {
        String sql = "INSERT INTO plat (nom, prix, disponible) VALUES (?, ?, 1)";
        PreparedStatement statement = connexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        statement.setString(1, nom);
        statement.setBigDecimal(2, new BigDecimal(prix));
        statement.executeUpdate();
        java.sql.ResultSet cle = statement.getGeneratedKeys();
        if (cle.next()) {
            ids.add(cle.getInt(1));
        }
        cle.close();
        statement.close();
    }
}