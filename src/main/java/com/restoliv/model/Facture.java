package com.restoliv.model;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

// Represente la facture d'une commande.
public class Facture {

    private int id;
    private int commandeId;
    private String numeroFacture;
    private LocalDateTime dateFacture;
    private BigDecimal montantTotal;

    public Facture() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCommandeId() {
        return commandeId;
    }

    public void setCommandeId(int commandeId) {
        this.commandeId = commandeId;
    }

    public String getNumeroFacture() {
        return numeroFacture;
    }

    public void setNumeroFacture(String numeroFacture) {
        this.numeroFacture = numeroFacture;
    }

    public LocalDateTime getDateFacture() {
        return dateFacture;
    }

    public void setDateFacture(LocalDateTime dateFacture) {
        this.dateFacture = dateFacture;
    }

    public String getDateFactureTexte() {
        if (dateFacture == null) {
            return "";
        }
        return dateFacture.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }

    public String getMontantTotalTexte() {
        if (montantTotal == null) {
            return "";
        }
        return NumberFormat.getNumberInstance(Locale.FRENCH).format(montantTotal)
                .replace('\u202F', ' ').replace('\u00A0', ' ') + " Ar";
    }

    public BigDecimal getMontantTotal() {
        return montantTotal;
    }

    public void setMontantTotal(BigDecimal montantTotal) {
        this.montantTotal = montantTotal;
    }
}