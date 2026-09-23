<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Facture"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<div class="zone-facture">
    <div class="carte">
        <div class="entete-facture">
            <h1>RestoLiv</h1>
            <p><c:out value="${facture.numeroFacture}"/></p>
            <p>Date : <c:out value="${facture.dateFactureTexte}"/></p>
        </div>

        <c:if test="${empty commande}">
            <div class="alerte alerte-erreur">Facture introuvable.</div>
        </c:if>

        <c:if test="${not empty commande}">
            <h2 class="sous-titre-page">Commande <c:out value="${commande.reference}"/></h2>

            <table class="bloc-infos">
                <tr>
                    <th>Client</th>
                    <td><c:out value="${commande.nomClient}"/></td>
                </tr>
                <tr>
                    <th>Telephone</th>
                    <td><c:out value="${commande.telephoneClient}"/></td>
                </tr>
                <tr>
                    <th>Adresse</th>
                    <td><c:out value="${commande.adresseLivraison}"/></td>
                </tr>
                <tr>
                    <th>Source</th>
                    <td><c:out value="${commande.source}"/></td>
                </tr>
                <tr>
                    <th>Statut</th>
                    <td><c:out value="${commande.statut}"/></td>
                </tr>
                <tr>
                    <th>Livreur</th>
                    <td>
                        <c:choose>
                            <c:when test="${not empty commande.nomLivreur}">
                                <c:out value="${commande.nomLivreur}"/>
                            </c:when>
                            <c:otherwise>Non assigne</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>

            <h2 class="sous-titre-page">Details</h2>
            <table>
                <thead>
                    <tr>
                        <th>Plat</th>
                        <th>Quantite</th>
                        <th>Prix unitaire</th>
                        <th>Sous-total</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="detail" items="${details}">
                        <tr>
                            <td><c:out value="${detail.nomPlat}"/></td>
                            <td><c:out value="${detail.quantite}"/></td>
                            <td><c:out value="${detail.prixUnitaire}"/> Ar</td>
                            <td><c:out value="${detail.sousTotal}"/> Ar</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <table class="bloc-infos">
                <tr>
                    <th>Paiement</th>
                    <td><c:out value="${paiement.modePaiement}"/></td>
                </tr>
                <tr>
                    <th>Reference Mobile Money</th>
                    <td><c:out value="${paiement.reference}"/></td>
                </tr>
                <tr>
                    <th>Total</th>
                    <td><strong><c:out value="${facture.montantTotal}"/> Ar</strong></td>
                </tr>
            </table>

            <p class="texte-secondaire" style="margin-top:20px">Merci de votre confiance.</p>
        </c:if>
    </div>

    <div class="zone-impression">
        <button type="button" class="bouton" onclick="window.print()" style="width:auto;padding:11px 28px">Imprimer la facture</button>
        <a class="bouton-secondaire" href="javascript:history.back()" style="padding:12px 15px">Retour</a>
    </div>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>