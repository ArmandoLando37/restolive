package com.restoliv.service;

import com.restoliv.model.Plat;
import java.math.BigDecimal;
import java.util.List;

// Tests du service des plats : validation, tri et Interpolation Search.
public class TestPlatService {

    private static int platA;
    private static int platB;
    private static int platC;
    private static int avantOK;
    private static int avantEchec;

    public static void main(String[] args) {
        System.out.println("=== TestPlatService ===");
        avantOK = TestUtil.getReussites();
        avantEchec = TestUtil.getEchecs();

        platA = TestUtil.insererPlat("Test Poulet", "8000", 1);
        platB = TestUtil.insererPlat("Test Riz", "6500", 1);
        platC = TestUtil.insererPlat("Test Pizza", "12000", 1);
        if (platA == 0 || platB == 0 || platC == 0) {
            System.out.println("  ECHEC : insertion des plats temporaires");
            return;
        }

        try {
            testerTri();
            testerInterpolation();
            testerValidation();
            testerDesactivation();
            testerRecherche();
        } finally {
            TestUtil.supprimerPlat(platA);
            TestUtil.supprimerPlat(platB);
            TestUtil.supprimerPlat(platC);
            System.out.println("  Nettoyage des plats temporaires : OK");
        }

        afficherBilan();
    }

    private static void testerTri() {
        System.out.println("  --- Tri ---");
        PlatService service = new PlatService();
        List<Plat> tries = service.trierPlatsParPrixAsc();
        boolean ordre = true;
        for (int i = 1; i < tries.size(); i++) {
            if (tries.get(i).getPrix().compareTo(tries.get(i - 1).getPrix()) < 0) {
                ordre = false;
            }
        }
        TestUtil.verifier(ordre, "les plats sont tries par prix croissant");
    }

    private static void testerInterpolation() {
        System.out.println("  --- Interpolation Search ---");
        PlatService service = new PlatService();
        Plat exact = service.chercherPlatParBudget(new BigDecimal("12000"));
        TestUtil.verifier(exact != null && exact.getPrix().compareTo(new BigDecimal("12000")) == 0,
                "budget 12000 -> plat a 12000 (prix exact)");

        Plat proche = service.chercherPlatParBudget(new BigDecimal("9000"));
        TestUtil.verifier(proche != null && proche.getPrix().compareTo(new BigDecimal("8000")) == 0,
                "budget 9000 -> plat le plus proche a 8000");

        Plat haut = service.chercherPlatParBudget(new BigDecimal("20000"));
        TestUtil.verifier(haut != null && haut.getPrix().compareTo(new BigDecimal("12000")) == 0,
                "budget 20000 -> plat max disponible a 12000");

        Plat nul = service.chercherPlatParBudget(null);
        TestUtil.verifier(nul == null, "budget null -> aucun plat");

        Plat zero = service.chercherPlatParBudget(new BigDecimal("0"));
        TestUtil.verifier(zero == null, "budget 0 -> aucun plat");
    }

    private static void testerValidation() {
        System.out.println("  --- Validation ---");
        PlatService service = new PlatService();
        Plat sansNom = new Plat();
        sansNom.setNom("  ");
        sansNom.setPrix(new BigDecimal("5000"));
        TestUtil.verifier(!service.ajouterPlat(sansNom), "nom vide -> ajout refuse");

        Plat sansPrix = new Plat();
        sansPrix.setNom("Test");
        sansPrix.setPrix(new BigDecimal("-1"));
        TestUtil.verifier(!service.ajouterPlat(sansPrix), "prix negatif -> ajout refuse");

        Plat valide = new Plat();
        valide.setNom("Test Valide");
        valide.setPrix(new BigDecimal("9500"));
        TestUtil.verifier(service.ajouterPlat(valide), "plat valide -> ajout accepte");
        TestUtil.supprimerPlat(dernierPlatInsert("Test Valide"));
    }

    private static void testerDesactivation() {
        System.out.println("  --- Desactivation ---");
        PlatService service = new PlatService();
        service.desactiverPlat(platB);
        Plat relu = service.chercherPlat(platB);
        TestUtil.verifier(relu != null && !relu.isDisponible(), "le plat 2 est desactive");

        boolean encoreDansListe = false;
        for (Plat plat : service.listePlatsDisponibles()) {
            if (plat.getId() == platB) {
                encoreDansListe = true;
            }
        }
        TestUtil.verifier(!encoreDansListe, "le plat desactive n'est plus disponible a la vente");
    }

    private static void testerRecherche() {
        System.out.println("  --- Recherche ---");
        PlatService service = new PlatService();
        List<Plat> resultats = service.rechercherPlats("pizza");
        boolean trouve = false;
        for (Plat plat : resultats) {
            if (plat.getId() == platC) {
                trouve = true;
            }
        }
        TestUtil.verifier(trouve, "la recherche par mot cle trouve le plat Test Pizza");
    }

    private static int dernierPlatInsert(String nom) {
        List<Plat> plats = new PlatService().rechercherPlats(nom);
        return plats.isEmpty() ? 0 : plats.get(0).getId();
    }

    private static void afficherBilan() {
        System.out.println("  Bilan TestPlatService : " + (TestUtil.getReussites() - avantOK)
                + " OK, " + (TestUtil.getEchecs() - avantEchec) + " ECHEC");
    }
}