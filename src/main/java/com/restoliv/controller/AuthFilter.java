package com.restoliv.controller;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Protege les pages necessitant une connexion.
@WebFilter(urlPatterns = {"/dashboard", "/menu", "/menu/*", "/livreurs", "/livreurs/*",
        "/commandes", "/commandes/*", "/paiements", "/factures", "/factures/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig config) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest requete, ServletResponse reponse, FilterChain chaine)
            throws IOException, ServletException {
        HttpServletRequest httpRequete = (HttpServletRequest) requete;
        HttpServletResponse httpReponse = (HttpServletResponse) reponse;
        HttpSession session = httpRequete.getSession(false);

        // Session valide : on laisse passer
        if (session != null && session.getAttribute("admin") != null) {
            chaine.doFilter(requete, reponse);
            return;
        }

        // Pas de session : redirection vers le login
        httpReponse.sendRedirect(httpRequete.getContextPath() + "/login");
    }

    @Override
    public void destroy() {
    }
}