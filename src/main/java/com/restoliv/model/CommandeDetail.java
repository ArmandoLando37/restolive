package com.restoliv.model;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Locale;

// Represente une ligne de commande (un plat avec sa quantite).
public class CommandeDetail {

    private int id;
    private int commandeId;
    private int platId;
    private int quantite;
    private BigDecimal prixUnitaire;
    private BigDecimal sousTotal;
    private String nomPlat; // nom du plat pour l'affichage

    public CommandeDetail() {
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

    public int getPlatId() {
        return platId;
    }

    public void setPlatId(int platId) {
        this.platId = platId;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    public BigDecimal getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setPrixUnitaire(BigDecimal prixUnitaire) {
        this.prixUnitaire = prixUnitaire;
    }

    public BigDecimal getSousTotal() {
        return sousTotal;
    }

    public void setSousTotal(BigDecimal sousTotal) {
        this.sousTotal = sousTotal;
    }

    public String getPrixUnitaireTexte() {
        if (prixUnitaire == null) {
            return "";
        }
        return NumberFormat.getNumberInstance(Locale.FRENCH).format(prixUnitaire)
                .replace('\u202F', ' ').replace('\u00A0', ' ') + " Ar";
    }

    public String getSousTotalTexte() {
        if (sousTotal == null) {
            return "";
        }
        return NumberFormat.getNumberInstance(Locale.FRENCH).format(sousTotal)
                .replace('\u202F', ' ').replace('\u00A0', ' ') + " Ar";
    }

    public String getNomPlat() {
        return nomPlat;
    }

    public void setNomPlat(String nomPlat) {
        this.nomPlat = nomPlat;
    }
}