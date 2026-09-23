package com.restoliv.controller;

import com.restoliv.model.Commande;
import com.restoliv.model.CommandeDetail;
import com.restoliv.model.Paiement;
import com.restoliv.model.Plat;
import com.restoliv.service.CommandeService;
import com.restoliv.service.FactureService;
import com.restoliv.service.LivreurService;
import com.restoliv.service.PaiementService;
import com.restoliv.service.PlatService;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Gere les commandes : creation complete, listing, details, statuts.
@WebServlet(name = "CommandeServlet", urlPatterns = {"/commandes", "/commandes/nouvelle",
        "/commandes/details", "/commandes/statut"})
public class CommandeServlet extends HttpServlet {

    private final CommandeService commandeService = new CommandeService();
    private final LivreurService livreurService = new LivreurService();
    private final PaiementService paiementService = new PaiementService();
    private final FactureService factureService = new FactureService();
    private final PlatService platService = new PlatService();

    @Override
    protected void doGet(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        String chemin = requete.getServletPath();

        if ("/commandes/nouvelle".equals(chemin)) {
            requete.setAttribute("platsDisponibles", platService.listePlatsDisponibles());
            requete.setAttribute("livreursDisponibles", livreurService.listeLivreursDisponibles());
            requete.setAttribute("erreur", requete.getParameter("erreur"));
            requete.setAttribute("titrePage", "Nouvelle commande");
            requete.getRequestDispatcher("/WEB-INF/views/commandes/nouvelle.jsp").forward(requete, reponse);
            return;
        }

        if ("/commandes/details".equals(chemin)) {
            chargerDetails(requete);
            requete.setAttribute("titrePage", "Details de la commande");
            requete.getRequestDispatcher("/WEB-INF/views/commandes/details.jsp").forward(requete, reponse);
            return;
        }

        List<Commande> commandes = commandeService.listeCommandes();
        requete.setAttribute("commandes", commandes);
        requete.setAttribute("titrePage", "Commandes");
        requete.getRequestDispatcher("/WEB-INF/views/commandes/liste.jsp").forward(requete, reponse);
    }

    @Override
    protected void doPost(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        String chemin = requete.getServletPath();
        String contexte = requete.getContextPath();

        if ("/commandes/nouvelle".equals(chemin)) {
            Commande commande = construireCommande(requete);
            List<CommandeDetail> details = construireDetails(requete);
            Paiement paiement = construirePaiement(requete);

            if (commandeService.creerCommande(commande, details, paiement)) {
                reponse.sendRedirect(contexte + "/factures?id=" + commande.getId());
            } else {
                reponse.sendRedirect(contexte + "/commandes/nouvelle?erreur=Donnees+invalides.+Verifiez+les+champs+et+la+disponibilite+des+plats.");
            }
            return;
        }

        if ("/commandes/statut".equals(chemin)) {
            int id = parcourirId(requete);
            String statut = requete.getParameter("statut");
            if (commandeService.changerStatut(id, statut)) {
                reponse.sendRedirect(contexte + "/commandes/details?id=" + id + "&info=Statut+modifie.");
            } else {
                reponse.sendRedirect(contexte + "/commandes/details?id=" + id + "&erreur=Changement+de+statut+impossible.");
            }
        }
    }

    // Construit la commande a partir du formulaire
    private Commande construireCommande(HttpServletRequest requete) {
        Commande commande = new Commande();
        commande.setNomClient(requete.getParameter("nomClient"));
        commande.setTelephoneClient(requete.getParameter("telephoneClient"));
        commande.setAdresseLivraison(requete.getParameter("adresseLivraison"));
        commande.setSource(requete.getParameter("source"));
        commande.setLivreurId(parcourirInt(requete.getParameter("livreurId")));
        return commande;
    }

    // Construit les lignes de commande a partir des plats coches
    private List<CommandeDetail> construireDetails(HttpServletRequest requete) {
        List<CommandeDetail> details = new ArrayList<>();
        List<Plat> plats = platService.listePlatsDisponibles();
        for (Plat plat : plats) {
            boolean coche = requete.getParameter("plat_" + plat.getId()) != null;
            int quantite = parcourirInt(requete.getParameter("quantite_" + plat.getId()));
            if (coche && quantite > 0) {
                CommandeDetail detail = new CommandeDetail();
                detail.setPlatId(plat.getId());
                detail.setQuantite(quantite);
                details.add(detail);
            }
        }
        return details;
    }

    // Construit le paiement Mobile Money
    private Paiement construirePaiement(HttpServletRequest requete) {
        Paiement paiement = new Paiement();
        paiement.setReference(requete.getParameter("referencePaiement"));
        return paiement;
    }

    // Charge les donnees d'une commande pour la page de details
    private void chargerDetails(HttpServletRequest requete) {
        int id = parcourirId(requete);
        if (id <= 0) {
            return;
        }
        requete.setAttribute("commande", commandeService.chercherCommande(id));
        requete.setAttribute("details", commandeService.listerDetails(id));
        requete.setAttribute("paiement", paiementService.consulterPaiement(id));
        requete.setAttribute("facture", factureService.consulterFacture(id));
        requete.setAttribute("info", requete.getParameter("info"));
        requete.setAttribute("erreur", requete.getParameter("erreur"));
    }

    // Lit un parametre id en entier
    private int parcourirId(HttpServletRequest requete) {
        return parcourirInt(requete.getParameter("id"));
    }

    // Convertit une chaine en entier sans erreur
    private int parcourirInt(String valeur) {
        try {
            return Integer.parseInt(valeur);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}