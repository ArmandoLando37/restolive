package com.restoliv.controller;

import com.restoliv.service.CommandeService;
import com.restoliv.service.LivreurService;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Locale;
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
        requete.setAttribute("commandesHier", commandeService.compterCommandesHier());
        requete.setAttribute("statutRecue", commandeService.compterParStatut("RECUE"));
        requete.setAttribute("statutEnCuisine", commandeService.compterParStatut("EN_CUISINE"));
        requete.setAttribute("statutEnLivraison", commandeService.compterParStatut("EN_LIVRAISON"));
        requete.setAttribute("statutLivree", commandeService.compterParStatut("LIVREE"));
        requete.setAttribute("statutRetour", commandeService.compterParStatut("RETOUR"));
        BigDecimal chiffreAffaires = commandeService.chiffreAffairesJour();
        requete.setAttribute("chiffreAffaires", chiffreAffaires);
        requete.setAttribute("chiffreAffairesTexte", formatMontant(chiffreAffaires));
        requete.setAttribute("chiffreAffairesHier", commandeService.chiffreAffairesHier());

        // Livreurs
        requete.setAttribute("livreursLibre", livreurService.compterLivreursParStatut("LIBRE"));
        requete.setAttribute("livreursEnLivraison", livreurService.compterLivreursParStatut("EN_LIVRAISON"));

        requete.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard.jsp").forward(requete, reponse);
    }

    // Formate une somme avec espaces normales
    private String formatMontant(BigDecimal montant) {
        if (montant == null) {
            return "0";
        }
        NumberFormat format = NumberFormat.getNumberInstance(Locale.FRENCH);
        format.setMinimumFractionDigits(0);
        format.setMaximumFractionDigits(2);
        return format.format(montant).replace('\u202F', ' ').replace('\u00A0', ' ');
    }
}