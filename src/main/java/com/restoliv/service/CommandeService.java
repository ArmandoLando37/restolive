package com.restoliv.service;

import com.restoliv.config.AccesBdd;
import com.restoliv.dao.CommandeDAO;
import com.restoliv.dao.CommandeDetailDAO;
import com.restoliv.dao.FactureDAO;
import com.restoliv.dao.LivreurDAO;
import com.restoliv.dao.PaiementDAO;
import com.restoliv.dao.PlatDAO;
import com.restoliv.model.Commande;
import com.restoliv.model.CommandeDetail;
import com.restoliv.model.Facture;
import com.restoliv.model.Livreur;
import com.restoliv.model.Paiement;
import com.restoliv.model.Plat;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

// Logique metier des commandes.
public class CommandeService {

    private final CommandeDAO commandeDAO = new CommandeDAO();
    private final CommandeDetailDAO detailDAO = new CommandeDetailDAO();
    private final PaiementDAO paiementDAO = new PaiementDAO();
    private final FactureDAO factureDAO = new FactureDAO();
    private final LivreurDAO livreurDAO = new LivreurDAO();
    private final PlatDAO platDAO = new PlatDAO();

    // Liste toutes les commandes
    public List<Commande> listeCommandes() {
        return commandeDAO.findAll();
    }

    // Retrouve une commande par son id
    public Commande chercherCommande(int id) {
        return commandeDAO.findById(id);
    }

    // Liste les lignes d'une commande
    public List<CommandeDetail> listerDetails(int commandeId) {
        return detailDAO.findByCommandeId(commandeId);
    }

    // Cree une commande complete dans une transaction JDBC
    public boolean creerCommande(Commande commande, List<CommandeDetail> details, Paiement paiement) {
        if (!commandeValide(commande, details, paiement)) {
            return false;
        }
        BigDecimal total = calculerTotal(details);
        commande.setTotal(total);
        commande.setStatut("RECUE");
        commande.setReference(genererReference());

        Connection connexion = null;
        try {
            connexion = AccesBdd.obtenirConnexion();
            connexion.setAutoCommit(false);

            int idCommande = commandeDAO.save(connexion, commande);
            if (idCommande == 0) {
                connexion.rollback();
                return false;
            }
            commande.setId(idCommande);

            for (CommandeDetail detail : details) {
                detail.setCommandeId(idCommande);
                detailDAO.save(connexion, detail);
            }

            paiement.setCommandeId(idCommande);
            paiement.setMontant(total);
            paiement.setModePaiement("MOBILE_MONEY");
            if (paiement.getStatut() == null) {
                paiement.setStatut("PAYE");
            }
            paiementDAO.save(connexion, paiement);

            Facture facture = new Facture();
            facture.setCommandeId(idCommande);
            facture.setNumeroFacture(genererNumeroFacture());
            facture.setMontantTotal(total);
            factureDAO.save(connexion, facture);

            connexion.commit();
            return true;
        } catch (SQLException e) {
            if (connexion != null) {
                try {
                    connexion.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (connexion != null) {
                try {
                    connexion.setAutoCommit(true);
                    connexion.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Change le statut d'une commande et gere celui du livreur
    public boolean changerStatut(int id, String nouveauStatut) {
        List<String> statuts = Arrays.asList("RECUE", "EN_CUISINE", "EN_LIVRAISON", "LIVREE", "RETOUR");
        if (!statuts.contains(nouveauStatut)) {
            return false;
        }
        Connection connexion = null;
        try {
            connexion = AccesBdd.obtenirConnexion();
            connexion.setAutoCommit(false);

            Commande commande = commandeDAO.findById(id);
            if (commande == null) {
                connexion.rollback();
                return false;
            }

            commandeDAO.updateStatut(connexion, id, nouveauStatut);

            // Gestion automatique du statut du livreur
            if (commande.getLivreurId() > 0) {
                if ("EN_LIVRAISON".equals(nouveauStatut)) {
                    livreurDAO.updateStatut(connexion, commande.getLivreurId(), "EN_LIVRAISON");
                } else if ("LIVREE".equals(nouveauStatut) || "RETOUR".equals(nouveauStatut)) {
                    livreurDAO.updateStatut(connexion, commande.getLivreurId(), "LIBRE");
                }
            }

            connexion.commit();
            return true;
        } catch (SQLException e) {
            if (connexion != null) {
                try {
                    connexion.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (connexion != null) {
                try {
                    connexion.setAutoCommit(true);
                    connexion.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Verifie les donnees obligatoires de la commande
    private boolean commandeValide(Commande commande, List<CommandeDetail> details, Paiement paiement) {
        if (commande.getNomClient() == null || commande.getNomClient().trim().isEmpty()) {
            return false;
        }
        if (commande.getTelephoneClient() == null || commande.getTelephoneClient().trim().isEmpty()) {
            return false;
        }
        if (commande.getAdresseLivraison() == null || commande.getAdresseLivraison().trim().isEmpty()) {
            return false;
        }
        List<String> sources = Arrays.asList("APPEL", "WHATSAPP");
        if (!sources.contains(commande.getSource())) {
            return false;
        }
        if (details == null || details.isEmpty()) {
            return false;
        }
        for (CommandeDetail detail : details) {
            if (detail.getQuantite() <= 0) {
                return false;
            }
            Plat plat = platDAO.findById(detail.getPlatId());
            if (plat == null || !plat.isDisponible()) {
                return false;
            }
            // Le prix unitaire est celui du jour, conserve en historique
            detail.setPrixUnitaire(plat.getPrix());
            detail.setSousTotal(plat.getPrix().multiply(BigDecimal.valueOf(detail.getQuantite())));
        }
        if (paiement == null || paiement.getReference() == null || paiement.getReference().trim().isEmpty()) {
            return false;
        }
        if (commande.getLivreurId() > 0) {
            Livreur livreur = livreurDAO.findById(commande.getLivreurId());
            if (livreur == null || !"LIBRE".equals(livreur.getStatut())) {
                return false;
            }
        }
        return true;
    }

    // Calcule le montant total d'une commande
    public BigDecimal calculerTotal(List<CommandeDetail> details) {
        BigDecimal total = BigDecimal.ZERO;
        for (CommandeDetail detail : details) {
            total = total.add(detail.getSousTotal());
        }
        return total.setScale(2, RoundingMode.HALF_UP);
    }

    // Statistiques pour le dashboard

    public int compterParStatut(String statut) {
        return commandeDAO.compterParStatut(statut);
    }

    public int compterCommandesAujourdhui() {
        return commandeDAO.compterCommandesAujourdhui();
    }

    public BigDecimal chiffreAffairesJour() {
        return commandeDAO.sommeTotalAujourdhui();
    }

    // Reference unique de commande
    private String genererReference() {
        return "CMD-" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
    }

    // Numero unique de facture
    private String genererNumeroFacture() {
        return "FAC-" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
    }
}