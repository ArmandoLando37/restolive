package com.restoliv.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

// Represente un plat du menu.
public class Plat {

    private int id;
    private String nom;
    private String description;
    private BigDecimal prix;
    private boolean disponible;
    private LocalDateTime createdAt;

    public Plat() {
    }

    public Plat(String nom, String description, BigDecimal prix, boolean disponible) {
        this.nom = nom;
        this.description = description;
        this.prix = prix;
        this.disponible = disponible;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrix() {
        return prix;
    }

    public void setPrix(BigDecimal prix) {
        this.prix = prix;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}