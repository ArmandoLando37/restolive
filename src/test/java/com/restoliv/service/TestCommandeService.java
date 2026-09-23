package com.restoliv.service;

import com.restoliv.model.Commande;
import com.restoliv.model.CommandeDetail;
import com.restoliv.model.Facture;
import com.restoliv.model.Livreur;
import com.restoliv.model.Paiement;
import com.restoliv.dao.LivreurDAO;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

// Tests du service des commandes : transaction complete, paiement,
// facture et gestion automatique du livreur.
public class TestCommandeService {

    private static int plat;
    private static int livreurLibre;
    private static int livreurOccupe;
    private static int commandeId;
    private static int avantOK;
    private static int avantEchec;

    public static void main(String[] args) {
        System.out.println("=== TestCommandeService ===");
        avantOK = TestUtil.getReussites();
        avantEchec = TestUtil.getEchecs();

        plat = TestUtil.insererPlat("Test Riz au Poisson", "8000", 1);
        livreurLibre = TestUtil.insererLivreur("Test Livreur A", "LIBRE");
        livreurOccupe = TestUtil.insererLivreur("Test Livreur B", "EN_LIVRAISON");
        if (plat == 0 || livreurLibre == 0 || livreurOccupe == 0) {
            System.out.println("  ECHEC : insertion des donnees temporaires");
            return;
        }

        try {
            testerValidation();
            testerCreationComplete();
            testerStatuts();
        } finally {
            if (commandeId > 0) {
                TestUtil.supprimerCommande(commandeId);
            }
            TestUtil.supprimerLivreur(livreurOccupe);
            TestUtil.supprimerLivreur(livreurLibre);
            TestUtil.supprimerPlat(plat);
            System.out.println("  Nettoyage des donnees temporaires : OK");
        }

        System.out.println("  Bilan TestCommandeService : " + (TestUtil.getReussites() - avantOK)
                + " OK, " + (TestUtil.getEchecs() - avantEchec) + " ECHEC");
    }

    private static void testerValidation() {
        System.out.println("  --- Validation ---");
        CommandeService service = new CommandeService();

        Commande sansDetails = construireCommande();
        TestUtil.verifier(!service.creerCommande(sansDetails, detailsVides(), newPaiement()),
                "sans details -> creation refusee");

        Commande sansPaiement = construireCommande();
        TestUtil.verifier(!service.creerCommande(sansPaiement, avecUnDetail(), null),
                "reference de paiement absente -> creation refusee");

        Commande avecOccupe = construireCommande();
        avecOccupe.setLivreurId(livreurOccupe);
        TestUtil.verifier(!service.creerCommande(avecOccupe, avecUnDetail(), newPaiement()),
                "livreur non libre -> creation refusee");
    }

    private static void testerCreationComplete() {
        System.out.println("  --- Creation complete (transaction) ---");
        CommandeService service = new CommandeService();
        Commande commande = construireCommande();
        boolean cree = service.creerCommande(commande, avecUnDetail(), newPaiement());
        TestUtil.verifier(cree, "la commande est creee");
        if (!cree) {
            return;
        }
        commandeId = commande.getId();
        TestUtil.verifier(commandeId > 0, "l'id de la commande est renseigne");
        TestUtil.verifier(commande.getReference() != null && commande.getReference().startsWith("CMD-"),
                "la reference commence par CMD-");
        TestUtil.verifier("RECUE".equals(commande.getStatut()), "statut initial RECUE");
        TestUtil.verifier(commande.getTotal().compareTo(new BigDecimal("16000.00")) == 0,
                "total calcule = 16000 (8000 x 2)");

        List<CommandeDetail> details = service.listerDetails(commandeId);
        TestUtil.verifier(details.size() == 1, "un seul detail enregistre");
        if (!details.isEmpty()) {
            CommandeDetail detail = details.get(0);
            TestUtil.verifier(detail.getQuantite() == 2, "quantite = 2");
            TestUtil.verifier(detail.getPrixUnitaire().compareTo(new BigDecimal("8000")) == 0,
                    "prix unitaire historise = 8000");
            TestUtil.verifier(detail.getSousTotal().compareTo(new BigDecimal("16000")) == 0,
                    "sous-total = 16000");
        }

        Paiement paiement = new PaiementService().consulterPaiement(commandeId);
        TestUtil.verifier(paiement != null, "le paiement existe");
        if (paiement != null) {
            TestUtil.verifier("MOBILE_MONEY".equals(paiement.getModePaiement()),
                    "mode de paiement MOBILE_MONEY");
            TestUtil.verifier("PAYE".equals(paiement.getStatut()), "statut du paiement PAYE");
            TestUtil.verifier(paiement.getMontant().compareTo(new BigDecimal("16000.00")) == 0,
                    "montant paye = 16000");
        }

        Facture facture = new FactureService().consulterFacture(commandeId);
        TestUtil.verifier(facture != null, "la facture existe");
        if (facture != null) {
            TestUtil.verifier(facture.getNumeroFacture() != null && facture.getNumeroFacture().startsWith("FAC-"),
                    "le numero de facture commence par FAC-");
            TestUtil.verifier(facture.getMontantTotal().compareTo(new BigDecimal("16000.00")) == 0,
                    "montant total de la facture = 16000");
        }
    }

    private static void testerStatuts() {
        System.out.println("  --- Changement de statut ---");
        CommandeService service = new CommandeService();
        LivreurDAO livreurDAO = new LivreurDAO();

        TestUtil.verifier(!service.changerStatut(commandeId, "INTROUVABLE"),
                "statut inconnu -> changement refuse");

        TestUtil.verifier(service.changerStatut(commandeId, "EN_LIVRAISON"),
                "passage en EN_LIVRAISON accepte");
        Livreur livreurParti = livreurDAO.findById(livreurLibre);
        TestUtil.verifier(livreurParti != null && "EN_LIVRAISON".equals(livreurParti.getStatut()),
                "le livreur passe automatiquement en EN_LIVRAISON");

        TestUtil.verifier(service.changerStatut(commandeId, "LIVREE"),
                "passage en LIVREE accepte");
        Livreur livreurRentre = livreurDAO.findById(livreurLibre);
        TestUtil.verifier(livreurRentre != null && "LIBRE".equals(livreurRentre.getStatut()),
                "le livreur redevient LIBRE apres la livraison");
    }

    private static Commande construireCommande() {
        Commande commande = new Commande();
        commande.setNomClient("Test Client");
        commande.setTelephoneClient("0342220000");
        commande.setAdresseLivraison("Analakely");
        commande.setSource("APPEL");
        commande.setLivreurId(livreurLibre);
        return commande;
    }

    private static CommandeDetail unDetail() {
        CommandeDetail detail = new CommandeDetail();
        detail.setPlatId(plat);
        detail.setQuantite(2);
        return detail;
    }

    private static List<CommandeDetail> avecUnDetail() {
        List<CommandeDetail> details = new ArrayList<>();
        details.add(unDetail());
        return details;
    }

    private static List<CommandeDetail> detailsVides() {
        return new ArrayList<>();
    }

    private static Paiement newPaiement() {
        Paiement paiement = new Paiement();
        paiement.setReference("MP-TEST-UNITE");
        return paiement;
    }
}