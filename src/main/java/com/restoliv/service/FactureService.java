package com.restoliv.service;

import com.restoliv.dao.FactureDAO;
import com.restoliv.model.Facture;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

// Logique metier des factures.
public class FactureService {

    private final FactureDAO factureDAO = new FactureDAO();

    // Consulte la facture d'une commande
    public Facture consulterFacture(int commandeId) {
        return factureDAO.findByCommandeId(commandeId);
    }

    // Genere un numero de facture unique
    public String genererNumeroFacture() {
        return "FAC-" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
    }
}