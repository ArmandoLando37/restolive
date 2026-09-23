package com.restoliv.service;

import com.restoliv.dao.PaiementDAO;
import com.restoliv.model.Paiement;

// Logique metier des paiements Mobile Money.
public class PaiementService {

    private final PaiementDAO paiementDAO = new PaiementDAO();

    // Consulte le paiement d'une commande
    public Paiement consulterPaiement(int commandeId) {
        return paiementDAO.findByCommandeId(commandeId);
    }
}