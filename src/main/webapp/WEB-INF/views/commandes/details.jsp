<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Details de la commande"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<h1 class="titre-page">Details de la commande</h1>

<c:if test="${not empty info}">
    <div class="alerte alerte-succes">${info}</div>
</c:if>
<c:if test="${not empty erreur}">
    <div class="alerte alerte-erreur">${erreur}</div>
</c:if>

<c:if test="${empty commande}">
    <div class="alerte alerte-erreur">Commande introuvable.</div>
</c:if>

<c:if test="${not empty commande}">
    <div class="carte">
        <h2 class="sous-titre-page">Commande <c:out value="${commande.reference}"/></h2>
        <p>Client : <strong><c:out value="${commande.nomClient}"/></strong> - <c:out value="${commande.telephoneClient}"/></p>
        <p>Adresse : <c:out value="${commande.adresseLivraison}"/></p>
        <p>Source : <c:out value="${commande.source}"/> - Statut : <span class="badge" style="background:#e0e0e0;color:#383d41"><c:out value="${commande.statut}"/></span></p>
        <p>Livreur : 
            <c:choose>
                <c:when test="${not empty commande.nomLivreur}">
                    <c:out value="${commande.nomLivreur}"/>
                </c:when>
                <c:otherwise>Non assigne</c:otherwise>
            </c:choose>
        </p>
        <p>Date : <c:out value="${commande.dateCommandeTexte}"/></p>
    </div>

    <div class="carte">
        <h2 class="sous-titre-page">Plats commandes</h2>
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
        <p style="margin-top:12px"><strong>Total : ${commande.total} Ar</strong></p>
    </div>

    <div class="carte">
        <h2 class="sous-titre-page">Paiement</h2>
        <c:choose>
            <c:when test="${not empty paiement}">
                <p>Mode : <c:out value="${paiement.modePaiement}"/></p>
                <p>Reference Mobile Money : <strong><c:out value="${paiement.reference}"/></strong></p>
                <p>Montant : <c:out value="${paiement.montant}"/> Ar - Statut : <c:out value="${paiement.statut}"/></p>
            </c:when>
            <c:otherwise>
                <p class="texte-secondaire">Aucun paiement enregistre.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="carte">
        <h2 class="sous-titre-page">Facture</h2>
        <c:choose>
            <c:when test="${not empty facture}">
                <p>Numero : <strong><c:out value="${facture.numeroFacture}"/></strong></p>
                <a class="bouton-secondaire" href="${pageContext.request.contextPath}/factures?id=${commande.id}" target="_blank">Voir et imprimer la facture</a>
            </c:when>
            <c:otherwise>
                <p class="texte-secondaire">Aucune facture.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="carte">
        <h2 class="sous-titre-page">Statut de la commande</h2>
        <form method="post" action="${pageContext.request.contextPath}/commandes/statut" class="barre-outils">
            <input type="hidden" name="id" value="${commande.id}">
            <select name="statut">
                <option value="RECUE" ${commande.statut == 'RECUE' ? 'selected' : ''}>RECUE</option>
                <option value="EN_CUISINE" ${commande.statut == 'EN_CUISINE' ? 'selected' : ''}>EN_CUISINE</option>
                <option value="EN_LIVRAISON" ${commande.statut == 'EN_LIVRAISON' ? 'selected' : ''}>EN_LIVRAISON</option>
                <option value="LIVREE" ${commande.statut == 'LIVREE' ? 'selected' : ''}>LIVREE</option>
                <option value="RETOUR" ${commande.statut == 'RETOUR' ? 'selected' : ''}>RETOUR</option>
            </select>
            <button type="submit" class="bouton-secondaire">Changer le statut</button>
        </form>
        <p class="texte-secondaire">Le livreur passe en EN_LIVRAISON au depart, puis revient LIBRE apres LIVREE ou RETOUR.</p>
    </div>
</c:if>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>