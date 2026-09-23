package com.restoliv.service;

import com.restoliv.model.Livreur;
import java.util.List;

// Tests du service des livreurs : validation, comptage et modification.
public class TestLivreurService {

    private static int libre;
    private static int occupe;
    private static int avantOK;
    private static int avantEchec;

    public static void main(String[] args) {
        System.out.println("=== TestLivreurService ===");
        avantOK = TestUtil.getReussites();
        avantEchec = TestUtil.getEchecs();

        libre = TestUtil.insererLivreur("Test Livreur Libre", "LIBRE");
        occupe = TestUtil.insererLivreur("Test Livreur Occupe", "EN_LIVRAISON");
        if (libre == 0 || occupe == 0) {
            System.out.println("  ECHEC : insertion des livreurs temporaires");
            return;
        }

        try {
            testerValidation();
            testerListe();
            testerComptage();
            testerModification();
        } finally {
            TestUtil.supprimerLivreur(libre);
            TestUtil.supprimerLivreur(occupe);
            System.out.println("  Nettoyage des livreurs temporaires : OK");
        }

        System.out.println("  Bilan TestLivreurService : " + (TestUtil.getReussites() - avantOK)
                + " OK, " + (TestUtil.getEchecs() - avantEchec) + " ECHEC");
    }

    private static void testerValidation() {
        System.out.println("  --- Validation ---");
        LivreurService service = new LivreurService();
        Livreur sansNom = new Livreur();
        sansNom.setNom("  ");
        sansNom.setTelephone("0341111111");
        TestUtil.verifier(!service.ajouterLivreur(sansNom), "nom vide -> ajout refuse");

        Livreur sansTelephone = new Livreur();
        sansTelephone.setNom("Test");
        sansTelephone.setTelephone("");
        TestUtil.verifier(!service.ajouterLivreur(sansTelephone), "telephone vide -> ajout refuse");
    }

    private static void testerListe() {
        System.out.println("  --- Liste ---");
        LivreurService service = new LivreurService();
        List<Livreur> disponibles = service.listeLivreursDisponibles();
        boolean contientLibre = false;
        boolean contientOccupe = false;
        for (Livreur livreur : disponibles) {
            if (livreur.getId() == libre) {
                contientLibre = true;
            }
            if (livreur.getId() == occupe) {
                contientOccupe = true;
            }
        }
        TestUtil.verifier(contientLibre, "le livreur LIBRE figure dans la liste disponible");
        TestUtil.verifier(!contientOccupe, "le livreur EN_LIVRAISON ne figure pas dans la liste disponible");
    }

    private static void testerComptage() {
        System.out.println("  --- Comptage ---");
        LivreurService service = new LivreurService();
        TestUtil.verifier(service.compterLivreursParStatut("LIBRE") >= 1,
                "au moins un livreur LIBRE");
        TestUtil.verifier(service.compterLivreursParStatut("EN_LIVRAISON") >= 1,
                "au moins un livreur EN_LIVRAISON");
        TestUtil.verifier(service.compterLivreursParStatut("INTROUVABLE") == 0,
                "statut inconnu -> compteur a zero");
    }

    private static void testerModification() {
        System.out.println("  --- Modification ---");
        LivreurService service = new LivreurService();
        Livreur cible = service.chercherLivreur(libre);
        cible.setNom("Test Livreur Modifie");
        TestUtil.verifier(service.modifierLivreur(cible), "modification du livreur acceptee");
        Livreur relu = service.chercherLivreur(libre);
        TestUtil.verifier("Test Livreur Modifie".equals(relu.getNom()), "le nouveau nom est enregistre");
    }
}