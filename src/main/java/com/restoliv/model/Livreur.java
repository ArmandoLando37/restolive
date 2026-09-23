package com.restoliv.model;

// Represente un livreur.
public class Livreur {

    private int id;
    private String nom;
    private String telephone;
    private String statut;

    public Livreur() {
    }

    public Livreur(String nom, String telephone, String statut) {
        this.nom = nom;
        this.telephone = telephone;
        this.statut = statut;
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

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }
}