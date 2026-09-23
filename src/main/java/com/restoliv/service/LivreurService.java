package com.restoliv.service;

import com.restoliv.dao.LivreurDAO;
import com.restoliv.model.Livreur;
import java.util.List;

// Logique metier des livreurs.
public class LivreurService {

    private final LivreurDAO livreurDAO = new LivreurDAO();

    // Liste tous les livreurs
    public List<Livreur> listeLivreurs() {
        return livreurDAO.findAll();
    }

    // Liste les livreurs disponibles (statut LIBRE)
    public List<Livreur> listeLivreursDisponibles() {
        return livreurDAO.findAvailableDrivers();
    }

    // Retrouve un livreur par son id
    public Livreur chercherLivreur(int id) {
        return livreurDAO.findById(id);
    }

    // Compte les livreurs ayant un statut donne (pour le dashboard)
    public int compterLivreursParStatut(String statut) {
        return livreurDAO.compterParStatut(statut);
    }

    // Ajoute un livreur apres validation
    public boolean ajouterLivreur(Livreur livreur) {
        if (livreur.getNom() == null || livreur.getNom().trim().isEmpty()) {
            return false;
        }
        if (livreur.getTelephone() == null || livreur.getTelephone().trim().isEmpty()) {
            return false;
        }
        if (livreur.getStatut() == null) {
            livreur.setStatut("LIBRE");
        }
        livreurDAO.save(livreur);
        return true;
    }

    // Modifie un livreur apres validation
    public boolean modifierLivreur(Livreur livreur) {
        if (livreur.getNom() == null || livreur.getNom().trim().isEmpty()) {
            return false;
        }
        if (livreur.getTelephone() == null || livreur.getTelephone().trim().isEmpty()) {
            return false;
        }
        livreurDAO.update(livreur);
        return true;
    }
}