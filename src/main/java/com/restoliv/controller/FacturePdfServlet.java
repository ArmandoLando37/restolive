package com.restoliv.controller;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.restoliv.model.Commande;
import com.restoliv.model.CommandeDetail;
import com.restoliv.model.Facture;
import com.restoliv.model.Paiement;
import com.restoliv.service.CommandeService;
import com.restoliv.service.FactureService;
import com.restoliv.service.PaiementService;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.Normalizer;
import java.text.NumberFormat;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Genere la facture d'une commande en PDF, telechargeable et personnalisee.
@WebServlet(name = "FacturePdfServlet", urlPatterns = {"/factures/pdf"})
public class FacturePdfServlet extends HttpServlet {

    private static final java.awt.Color TEAL = new java.awt.Color(13, 148, 136);
    private static final java.awt.Color FOND_DOUX = new java.awt.Color(240, 247, 245);
    private static final java.awt.Color TRAIT = new java.awt.Color(226, 232, 240);
    private static final java.awt.Color GRIS_DOUX = new java.awt.Color(100, 116, 139);

    private final CommandeService commandeService = new CommandeService();
    private final PaiementService paiementService = new PaiementService();
    private final FactureService factureService = new FactureService();

    @Override
    protected void doGet(HttpServletRequest requete, HttpServletResponse reponse)
            throws ServletException, IOException {
        int id = parcourirId(requete);
        Commande commande = commandeService.chercherCommande(id);
        Facture facture = factureService.consulterFacture(id);
        if (commande == null || facture == null) {
            reponse.sendRedirect(requete.getContextPath() + "/commandes");
            return;
        }

        List<CommandeDetail> details = commandeService.listerDetails(id);
        Paiement paiement = paiementService.consulterPaiement(id);

        byte[] pdf = genererPdf(commande, facture, details, paiement);

        reponse.setContentType("application/pdf");
        reponse.setContentLength(pdf.length);
        definirNomFichier(reponse, facture, commande);
        reponse.getOutputStream().write(pdf);
    }

    // Genere le PDF de la facture sur une seule page
    private byte[] genererPdf(Commande commande, Facture facture, List<CommandeDetail> details, Paiement paiement)
            throws IOException {
        Document document = new Document();
        ByteArrayOutputStream flux = new ByteArrayOutputStream();
        PdfWriter ecrivain = PdfWriter.getInstance(document, flux);
        document.open();

        document.add(entete(commande, facture));
        document.add(new Paragraph(" "));
        document.add(informationsClient(commande));
        document.add(new Paragraph(" "));
        document.add(tableauLignes(details, facture));
        document.add(new Paragraph(" "));
        document.add(blocPaiement(paiement));
        document.add(new Paragraph(" "));
        Paragraph remerciement = new Paragraph("Merci de votre confiance et bon appetit.",
                FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL, GRIS_DOUX));
        remerciement.setAlignment(Element.ALIGN_CENTER);
        document.add(remerciement);

        document.close();
        return flux.toByteArray();
    }

    // En-tete de la facture : logo, numero et date
    private PdfPTable entete(Commande commande, Facture facture) {
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);

        PdfPCell gauche = new PdfPCell(new Phrase("RestoLiv", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, Font.BOLD)));
        gauche.setBorder(Rectangle.BOTTOM);
        gauche.setBorderColorBottom(TEAL);
        gauche.setBorderWidthBottom(2f);
        gauche.setPaddingBottom(8f);

        PdfPCell droite = new PdfPCell();
        droite.setBorder(Rectangle.BOTTOM);
        droite.setBorderColorBottom(TEAL);
        droite.setBorderWidthBottom(2f);
        droite.setPaddingBottom(8f);
        rightligne(droite, "Numero : " + facture.getNumeroFacture(), 10, Font.BOLD);
        rightligne(droite, "Date : " + facture.getDateFacture().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")), 9, Font.NORMAL);
        rightligne(droite, "Commande : " + commande.getReference(), 9, Font.NORMAL);

        table.addCell(gauche);
        table.addCell(droite);
        return table;
    }

    private void rightligne(PdfPCell cellule, String texte, int taille, int style) {
        Paragraph p = new Paragraph(texte, FontFactory.getFont(FontFactory.HELVETICA, taille, style));
        p.setAlignment(Element.ALIGN_RIGHT);
        cellule.addElement(p);
    }

    // Coordonnees du client
    private PdfPTable informationsClient(Commande commande) {
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{50f, 50f});

        celluleFacture(table, "Client", commande.getNomClient(), true);
        celluleFacture(table, "Telephone", commande.getTelephoneClient(), false);
        celluleFacture(table, "Adresse de livraison", commande.getAdresseLivraison(), false);
        String source = "PAR APPEL";
        if ("WHATSAPP".equals(commande.getSource())) {
            source = "PAR WHATSAPP";
        }
        celluleFacture(table, "Source", source.toLowerCase(Locale.FRENCH), false);
        celluleFacture(table, "Livreur", commande.getNomLivreur() == null ? "Non assigne" : commande.getNomLivreur(), false);
        String vide = "";
        PdfPCell cVide = new PdfPCell(new Phrase(vide, FontFactory.getFont(FontFactory.HELVETICA, 10)));
        cVide.setBorder(Rectangle.NO_BORDER);
        cVide.setPaddingBottom(3f);
        table.addCell(cVide);
        return table;
    }

    private void celluleFacture(PdfPTable table, String libelle, String valeur, boolean gras) {
        PdfPCell cellule = new PdfPCell();
        cellule.setBorder(Rectangle.NO_BORDER);
        cellule.setPaddingBottom(4f);
        Paragraph p = new Paragraph();
        p.add(new Phrase(libelle + " : ", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, Font.BOLD, GRIS_DOUX)));
        p.add(new Phrase(valeur == null ? "" : valeur,
                FontFactory.getFont(FontFactory.HELVETICA, 10, gras ? Font.BOLD : Font.NORMAL)));
        cellule.addElement(p);
        table.addCell(cellule);
    }

    // Lignes de la commande avec le total
    private PdfPTable tableauLignes(List<CommandeDetail> details, Facture facture) {
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{44f, 14f, 21f, 21f});

        ligneEntete(table, "Plat");
        ligneEntete(table, "Quantite");
        ligneEntete(table, "PU");
        ligneEntete(table, "Sous-total");

        if (details != null) {
            for (CommandeDetail detail : details) {
                celluleLigne(table, detail.getNomPlat(), false);
                celluleLigne(table, "x " + detail.getQuantite(), false);
                celluleLigneMontant(table, montant(detail.getPrixUnitaire()));
                celluleLigneMontant(table, montant(detail.getSousTotal()));
            }
        }

        PdfPCell total = new PdfPCell(new Phrase("TOTAL",
                FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD, java.awt.Color.WHITE)));
        total.setBackgroundColor(TEAL);
        total.setHorizontalAlignment(Element.ALIGN_RIGHT);
        total.setPadding(6f);
        total.setColspan(3);
        PdfPCell montantTotal = new PdfPCell(new Phrase(montant(facture.getMontantTotal()),
                FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD, java.awt.Color.WHITE)));
        montantTotal.setBackgroundColor(TEAL);
        montantTotal.setHorizontalAlignment(Element.ALIGN_RIGHT);
        montantTotal.setPadding(6f);
        table.addCell(total);
        table.addCell(montantTotal);
        return table;
    }

    private void ligneEntete(PdfPTable table, String texte) {
        PdfPCell cellule = new PdfPCell(new Phrase(texte,
                FontFactory.getFont(FontFactory.HELVETICA_BOLD, 8, Font.BOLD, java.awt.Color.WHITE)));
        cellule.setBackgroundColor(GRIS_DOUX);
        cellule.setPadding(5f);
        cellule.setHorizontalAlignment(Element.ALIGN_LEFT);
        table.addCell(cellule);
    }

    private void celluleLigne(PdfPTable table, String texte, boolean gras) {
        PdfPCell cellule = new PdfPCell(new Phrase(texte,
                FontFactory.getFont(FontFactory.HELVETICA, 9, gras ? Font.BOLD : Font.NORMAL)));
        cellule.setBorder(Rectangle.BOTTOM);
        cellule.setBorderColorBottom(TRAIT);
        cellule.setBorderWidthBottom(0.5f);
        cellule.setPadding(5f);
        table.addCell(cellule);
    }

    private void celluleLigneMontant(PdfPTable table, String texte) {
        PdfPCell cellule = new PdfPCell(new Phrase(texte,
                FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
        cellule.setBorder(Rectangle.BOTTOM);
        cellule.setBorderColorBottom(TRAIT);
        cellule.setBorderWidthBottom(0.5f);
        cellule.setPadding(5f);
        cellule.setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.addCell(cellule);
    }

    // Bloc du paiement Mobile Money
    private PdfPTable blocPaiement(Paiement paiement) {
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);

        PdfPCell cellule = new PdfPCell(new Phrase("Paiement : Mobile Money",
                FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, Font.BOLD)));
        cellule.setBackgroundColor(FOND_DOUX);
        cellule.setBorder(Rectangle.NO_BORDER);
        cellule.setPadding(6f);
        table.addCell(cellule);

        PdfPCell reference = new PdfPCell(new Phrase("Reference : " + (paiement == null || paiement.getReference() == null
                ? "-" : paiement.getReference()), FontFactory.getFont(FontFactory.HELVETICA, 10)));
        reference.setBackgroundColor(FOND_DOUX);
        reference.setBorder(Rectangle.NO_BORDER);
        reference.setPadding(6f);
        reference.setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.addCell(reference);
        return table;
    }

    // Formate une somme avec des espaces et sans caractere non ASCII
    private String montant(BigDecimal valeur) {
        if (valeur == null) {
            return "0 Ar";
        }
        NumberFormat format = NumberFormat.getNumberInstance(Locale.FRENCH);
        format.setMinimumFractionDigits(0);
        format.setMaximumFractionDigits(2);
        return format.format(valeur).replace('\u202F', ' ').replace('\u00A0', ' ') + " Ar";
    }

    // Nom de fichier unique lie a l'achat, puis en-tete Content-Disposition
    private void definirNomFichier(HttpServletResponse reponse, Facture facture, Commande commande)
            throws UnsupportedEncodingException {
        String base = nomPropre(commande.getNomClient(), 40);
        String nomAscii = "Facture-" + facture.getNumeroFacture() + "-" + base + ".pdf";
        String nomUtf8 = "Facture-" + facture.getNumeroFacture() + "-" + normeAscii(base) + ".pdf";
        String encodage = URLEncoder.encode(nomUtf8, "UTF-8").replace("+", "%20");
        reponse.setHeader("Content-Disposition",
                "attachment; filename=\"" + nomAscii + "\"; filename*=UTF-8''" + encodage);
    }

    // Nom du client sans accents ni caracteres interdits
    private String nomPropre(String nom, int longueurMax) {
        if (nom == null) {
            return "CLIENT";
        }
        String normalise = Normalizer.normalize(nom, Normalizer.Form.NFD)
                .replaceAll("\\p{M}", "");
        String nettoye = normalise.replaceAll("[^A-Za-z0-9._-]+", "_");
        if (nettoye.length() > longueurMax) {
            nettoye = nettoye.substring(0, longueurMax);
        }
        if (nettoye.isEmpty()) {
            nettoye = "CLIENT";
        }
        return nettoye;
    }

    // Version sans accents pour la partie ASCII du nom de fichier
    private String normeAscii(String nom) {
        return nom.replaceAll("[^A-Za-z0-9._-]", "_");
    }

    private int parcourirId(HttpServletRequest requete) {
        try {
            return Integer.parseInt(requete.getParameter("id"));
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}