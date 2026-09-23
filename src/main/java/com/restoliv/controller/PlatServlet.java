package com.restoliv.controller;

import com.restoliv.model.Plat;
import com.restoliv.service.PlatService;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Gere le menu (plats) : listing, recherche, tri, budget, ajout, modification, desactivation.
@WebServlet(name = "PlatServlet", urlPatterns = {"/menu", "/menu/ajouter", "/menu/modifier", "/menu/desactiver"})
public class PlatServlet extends HttpServlet {

    private final PlatService platService = new PlatService();

    @Override
    protected void doGet(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        String chemin = requete.getServletPath();

        if ("/menu/ajouter".equals(chemin)) {
            requete.setAttribute("titrePage", "Ajouter un plat");
            requete.getRequestDispatcher("/WEB-INF/views/menu/ajouter.jsp").forward(requete, reponse);
            return;
        }

        if ("/menu/modifier".equals(chemin)) {
            Plat plat = platService.chercherPlat(parcourirId(requete));
            requete.setAttribute("plat", plat);
            requete.setAttribute("titrePage", "Modifier un plat");
            requete.getRequestDispatcher("/WEB-INF/views/menu/modifier.jsp").forward(requete, reponse);
            return;
        }

        // Liste des plats avec recherche, tri et recherche par budget
        String recherche = requete.getParameter("recherche");
        String tri = requete.getParameter("tri");
        String budgetTexte = requete.getParameter("budget");

        List<Plat> plats;
        if ("asc".equals(tri)) {
            plats = platService.trierPlatsParPrixAsc();
        } else if ("desc".equals(tri)) {
            plats = platService.trierPlatsParPrixDesc();
        } else if (recherche != null && !recherche.trim().isEmpty()) {
            plats = platService.rechercherPlats(recherche.trim());
        } else {
            plats = platService.listePlats();
        }

        // Recherche du plat par budget (Interpolation Search)
        Plat platBudget = null;
        if (budgetTexte != null && !budgetTexte.trim().isEmpty()) {
            try {
                BigDecimal budget = new BigDecimal(budgetTexte.trim());
                platBudget = platService.chercherPlatParBudget(budget);
            } catch (NumberFormatException e) {
                platBudget = null;
            }
        }

        requete.setAttribute("plats", plats);
        requete.setAttribute("searchTerm", recherche);
        requete.setAttribute("triActif", tri);
        requete.setAttribute("budget", budgetTexte);
        requete.setAttribute("platBudget", platBudget);
        requete.setAttribute("titrePage", "Menu");
        requete.getRequestDispatcher("/WEB-INF/views/menu/liste.jsp").forward(requete, reponse);
    }

    @Override
    protected void doPost(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        String chemin = requete.getServletPath();
        String contexte = requete.getContextPath();

        if ("/menu/ajouter".equals(chemin)) {
            boolean ok = platService.ajouterPlat(construirePlat(requete, -1));
            String separateur = contexte;
            if (ok) {
                reponse.sendRedirect(separateur + "/menu?info=Plat+ajoute.");
            } else {
                reponse.sendRedirect(separateur + "/menu?erreur=Donnees+invalides.+Nom+obligatoire+et+prix+superieur+a+0.");
            }
            return;
        }

        if ("/menu/modifier".equals(chemin)) {
            boolean ok = platService.modifierPlat(construirePlat(requete, parcourirId(requete)));
            if (ok) {
                reponse.sendRedirect(contexte + "/menu?info=Plat+modifie.");
            } else {
                reponse.sendRedirect(contexte + "/menu?erreur=Donnees+invalides.");
            }
            return;
        }

        if ("/menu/desactiver".equals(chemin)) {
            platService.desactiverPlat(parcourirId(requete));
            reponse.sendRedirect(contexte + "/menu?info=Plat+desactive.");
        }
    }

    // Construit un objet Plat a partir des parametres du formulaire
    private Plat construirePlat(HttpServletRequest requete, int id) {
        Plat plat = new Plat();
        plat.setId(id);
        plat.setNom(requete.getParameter("nom"));
        plat.setDescription(requete.getParameter("description"));
        try {
            plat.setPrix(new BigDecimal(requete.getParameter("prix")));
        } catch (Exception e) {
            plat.setPrix(BigDecimal.ZERO);
        }
        plat.setDisponible(requete.getParameter("disponible") != null);
        return plat;
    }

    // Lit le parametre id en entier
    private int parcourirId(HttpServletRequest requete) {
        try {
            return Integer.parseInt(requete.getParameter("id"));
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}