package com.restoliv.service;

import com.restoliv.dao.PlatDAO;
import com.restoliv.model.Plat;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

// Logique metier du menu (plats).
public class PlatService {

    private final PlatDAO platDAO = new PlatDAO();

    // Liste tous les plats
    public List<Plat> listePlats() {
        return platDAO.findAll();
    }

    // Liste les plats encore disponibles a la vente
    public List<Plat> listePlatsDisponibles() {
        return platDAO.findDisponibles();
    }

    // Retrouve un plat par son id
    public Plat chercherPlat(int id) {
        return platDAO.findById(id);
    }

    // Ajoute un plat apres validation
    public boolean ajouterPlat(Plat plat) {
        if (plat.getNom() == null || plat.getNom().trim().isEmpty()) {
            return false;
        }
        if (plat.getPrix() == null || plat.getPrix().signum() <= 0) {
            return false;
        }
        if (plat.getDescription() == null) {
            plat.setDescription("");
        }
        platDAO.save(plat);
        return true;
    }

    // Modifie un plat apres validation
    public boolean modifierPlat(Plat plat) {
        if (plat.getNom() == null || plat.getNom().trim().isEmpty()) {
            return false;
        }
        if (plat.getPrix() == null || plat.getPrix().signum() <= 0) {
            return false;
        }
        if (plat.getDescription() == null) {
            plat.setDescription("");
        }
        platDAO.update(plat);
        return true;
    }

    // Desactive un plat (jamais de suppression physique)
    public void desactiverPlat(int id) {
        platDAO.desactiver(id);
    }

    // Recherche textuelle des plats par nom (SQL LIKE)
    public List<Plat> rechercherPlats(String motCle) {
        if (motCle == null || motCle.trim().isEmpty()) {
            return listePlats();
        }
        return platDAO.searchByName(motCle.trim());
    }

    // Tri des plats par prix croissant
    public List<Plat> trierPlatsParPrixAsc() {
        return platDAO.findTriesParPrixAsc();
    }

    // Tri des plats par prix decroissant
    public List<Plat> trierPlatsParPrixDesc() {
        return platDAO.findTriesParPrixDesc();
    }

    // Recherche le plat correspondant au budget avec Interpolation Search
    public Plat chercherPlatParBudget(BigDecimal budget) {
        if (budget == null || budget.signum() <= 0) {
            return null;
        }
        List<Plat> plats = platDAO.findTriesParPrixAsc();
        if (plats.isEmpty()) {
            return null;
        }
        int index = interpolationSearch(plats, budget);
        if (index >= 0) {
            return plats.get(index);
        }
        // Pas de prix exact : retourne le plus proche du budget
        return trouverPlatLePlusProche(plats, budget);
    }

    // Interpolation Search : recherche un prix exact dans les plats tries
    private int interpolationSearch(List<Plat> plats, BigDecimal budget) {
        int debut = 0;
        int fin = plats.size() - 1;
        while (debut <= fin) {
            if (budget.compareTo(plats.get(debut).getPrix()) < 0
                    || budget.compareTo(plats.get(fin).getPrix()) > 0) {
                return -1;
            }
            int position = positionInterpoler(plats, debut, fin, budget);
            int comparaison = budget.compareTo(plats.get(position).getPrix());
            if (comparaison == 0) {
                return position;
            }
            if (comparaison < 0) {
                fin = position - 1;
            } else {
                debut = position + 1;
            }
        }
        return -1;
    }

    // Estime la position du budget dans l'intervalle [debut, fin]
    private int positionInterpoler(List<Plat> plats, int debut, int fin, BigDecimal budget) {
        BigDecimal prixDebut = plats.get(debut).getPrix();
        BigDecimal prixFin = plats.get(fin).getPrix();
        BigDecimal ecart = prixFin.subtract(prixDebut);
        int position;
        if (ecart.signum() == 0) {
            position = debut;
        } else {
            BigDecimal part = budget.subtract(prixDebut)
                    .multiply(BigDecimal.valueOf(fin - debut));
            position = debut + part.divide(ecart, 0, RoundingMode.HALF_UP).intValue();
        }
        if (position < debut) {
            position = debut;
        }
        if (position > fin) {
            position = fin;
        }
        return position;
    }

    // Recherche le plat dont le prix est le plus proche du budget
    private Plat trouverPlatLePlusProche(List<Plat> plats, BigDecimal budget) {
        Plat plusProche = plats.get(0);
        BigDecimal ecartMin = budget.subtract(plusProche.getPrix()).abs();
        for (Plat plat : plats) {
            BigDecimal ecart = budget.subtract(plat.getPrix()).abs();
            if (ecart.compareTo(ecartMin) < 0) {
                ecartMin = ecart;
                plusProche = plat;
            }
        }
        return plusProche;
    }
}