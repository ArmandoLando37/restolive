package com.restoliv.controller;

import com.restoliv.model.Livreur;
import com.restoliv.service.LivreurService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Gere les livreurs : liste, ajout, modification, statut.
@WebServlet(name = "LivreurServlet", urlPatterns = {"/livreurs", "/livreurs/ajouter", "/livreurs/modifier"})
public class LivreurServlet extends HttpServlet {

    private final LivreurService livreurService = new LivreurService();

    @Override
    protected void doGet(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        String chemin = requete.getServletPath();

        if ("/livreurs/ajouter".equals(chemin)) {
            requete.setAttribute("titrePage", "Ajouter un livreur");
            requete.getRequestDispatcher("/WEB-INF/views/livreurs/ajouter.jsp").forward(requete, reponse);
            return;
        }

        if ("/livreurs/modifier".equals(chemin)) {
            Livreur livreur = livreurService.chercherLivreur(parcourirId(requete));
            requete.setAttribute("livreur", livreur);
            requete.setAttribute("titrePage", "Modifier un livreur");
            requete.getRequestDispatcher("/WEB-INF/views/livreurs/modifier.jsp").forward(requete, reponse);
            return;
        }

        List<Livreur> livreurs = livreurService.listeLivreurs();
        requete.setAttribute("livreurs", livreurs);
        requete.setAttribute("titrePage", "Livreurs");
        requete.getRequestDispatcher("/WEB-INF/views/livreurs/liste.jsp").forward(requete, reponse);
    }

    @Override
    protected void doPost(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        String chemin = requete.getServletPath();
        String contexte = requete.getContextPath();

        if ("/livreurs/ajouter".equals(chemin)) {
            Livreur livreur = new Livreur();
            livreur.setNom(requete.getParameter("nom"));
            livreur.setTelephone(requete.getParameter("telephone"));
            livreur.setStatut("LIBRE");
            if (livreurService.ajouterLivreur(livreur)) {
                reponse.sendRedirect(contexte + "/livreurs?info=Livreur+ajoute.");
            } else {
                reponse.sendRedirect(contexte + "/livreurs?erreur=Nom+et+telephone+obligatoires.");
            }
            return;
        }

        if ("/livreurs/modifier".equals(chemin)) {
            Livreur livreur = new Livreur();
            livreur.setId(parcourirId(requete));
            livreur.setNom(requete.getParameter("nom"));
            livreur.setTelephone(requete.getParameter("telephone"));
            livreur.setStatut(requete.getParameter("statut"));
            if (livreurService.modifierLivreur(livreur)) {
                reponse.sendRedirect(contexte + "/livreurs?info=Livreur+modifie.");
            } else {
                reponse.sendRedirect(contexte + "/livreurs?erreur=Donnees+invalides.");
            }
        }
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