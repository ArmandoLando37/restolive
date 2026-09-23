package com.restoliv.controller;

import com.restoliv.service.AuthService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Gere la connexion de l'admin.
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        // Deja connecte : on va directement au dashboard
        HttpSession session = requete.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            reponse.sendRedirect(requete.getContextPath() + "/dashboard");
            return;
        }
        requete.getRequestDispatcher("/WEB-INF/views/login/login.jsp").forward(requete, reponse);
    }

    @Override
    protected void doPost(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        String username = requete.getParameter("username");
        String motDePasse = requete.getParameter("motDePasse");

        if (authService.auth(username, motDePasse)) {
            HttpSession session = requete.getSession(true);
            session.setAttribute("admin", username);
            reponse.sendRedirect(requete.getContextPath() + "/dashboard");
        } else {
            requete.setAttribute("erreur", "Nom d'utilisateur ou mot de passe incorrect.");
            requete.getRequestDispatcher("/WEB-INF/views/login/login.jsp").forward(requete, reponse);
        }
    }
}