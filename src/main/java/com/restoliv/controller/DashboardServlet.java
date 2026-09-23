package com.restoliv.controller;

import com.restoliv.service.CommandeService;
import com.restoliv.service.LivreurService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Affiche le dashboard avec les statistiques reelles.
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private final CommandeService commandeService = new CommandeService();
    private final LivreurService livreurService = new LivreurService();

    @Override
    protected void doGet(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        // Commandes
        requete.setAttribute("commandesAujourdhui", commandeService.compterCommandesAujourdhui());
        requete.setAttribute("statutRecue", commandeService.compterParStatut("RECUE"));
        requete.setAttribute("statutEnCuisine", commandeService.compterParStatut("EN_CUISINE"));
        requete.setAttribute("statutEnLivraison", commandeService.compterParStatut("EN_LIVRAISON"));
        requete.setAttribute("statutLivree", commandeService.compterParStatut("LIVREE"));
        requete.setAttribute("statutRetour", commandeService.compterParStatut("RETOUR"));
        requete.setAttribute("chiffreAffaires", commandeService.chiffreAffairesJour());

        // Livreurs
        requete.setAttribute("livreursLibre", livreurService.compterLivreursParStatut("LIBRE"));
        requete.setAttribute("livreursEnLivraison", livreurService.compterLivreursParStatut("EN_LIVRAISON"));

        requete.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard.jsp").forward(requete, reponse);
    }
}