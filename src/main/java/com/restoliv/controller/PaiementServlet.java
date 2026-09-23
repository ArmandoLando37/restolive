package com.restoliv.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Les paiements sont enregistres lors de la creation d'une commande.
// Cette page renvoie vers la liste des commandes.
@WebServlet(name = "PaiementServlet", urlPatterns = {"/paiements"})
public class PaiementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        reponse.sendRedirect(requete.getContextPath() + "/commandes");
    }
}