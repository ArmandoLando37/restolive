package com.restoliv.service;

import com.restoliv.dao.AdminDAO;
import com.restoliv.model.Admin;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

// Logique d'authentification de l'admin.
public class AuthService {

    private final AdminDAO adminDAO = new AdminDAO();

    // Verifie le couple nom d'utilisateur / mot de passe
    public boolean auth(String username, String motDePasse) {
        if (username == null || motDePasse == null) {
            return false;
        }
        Admin admin = adminDAO.findByUsername(username);
        if (admin == null) {
            return false;
        }
        String hash = calculerHash(motDePasse);
        return admin.getPassword().equals(hash);
    }

    // Calcule le hash SHA-256 d'un mot de passe
    public String calculerHash(String motDePasse) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] octets = digest.digest(motDePasse.getBytes(StandardCharsets.UTF_8));
            StringBuilder hex = new StringBuilder();
            for (byte octet : octets) {
                hex.append(String.format("%02x", octet));
            }
            return hex.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Algorithme SHA-256 introuvable", e);
        }
    }
}