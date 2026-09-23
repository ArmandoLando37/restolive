package com.restoliv.dao;

import com.restoliv.model.Admin;
import com.restoliv.model.Plat;
import com.restoliv.model.Livreur;
import java.util.List;

// Petit test manuel des DAO.
public class TestDAO {

    public static void main(String[] args) {
        AdminDAO adminDAO = new AdminDAO();
        Admin admin = adminDAO.findByUsername("admin");
        System.out.println("Admin trouve : " + (admin != null ? admin.getUsername() : "aucun"));

        PlatDAO platDAO = new PlatDAO();
        List<Plat> plats = platDAO.findAll();
        System.out.println("Nombre de plats : " + plats.size());

        LivreurDAO livreurDAO = new LivreurDAO();
        List<Livreur> livreurs = livreurDAO.findAll();
        System.out.println("Nombre de livreurs : " + livreurs.size());
    }
}