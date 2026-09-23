package com.restoliv.controller;

import com.restoliv.service.CommandeService;
import com.restoliv.service.FactureService;
import com.restoliv.service.PaiementService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Affiche et imprime la facture d'une commande.
@WebServlet(name = "FactureServlet", urlPatterns = {"/factures"})
public class FactureServlet extends HttpServlet {

    private final CommandeService commandeService = new CommandeService();
    private final PaiementService paiementService = new PaiementService();
    private final FactureService factureService = new FactureService();

    @Override
    protected void doGet(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        int id = parcourirId(requete);
        if (id <= 0) {
            reponse.sendRedirect(requete.getContextPath() + "/commandes");
            return;
        }
        requete.setAttribute("commande", commandeService.chercherCommande(id));
        requete.setAttribute("details", commandeService.listerDetails(id));
        requete.setAttribute("paiement", paiementService.consulterPaiement(id));
        requete.setAttribute("facture", factureService.consulterFacture(id));
        requete.setAttribute("titrePage", "Facture");
        requete.getRequestDispatcher("/WEB-INF/views/factures/facture.jsp").forward(requete, reponse);
    }

    private int parcourirId(HttpServletRequest requete) {
        try {
            return Integer.parseInt(requete.getParameter("id"));
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}