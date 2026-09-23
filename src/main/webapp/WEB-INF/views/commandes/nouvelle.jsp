<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Nouvelle commande"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<h1 class="titre-page">Nouvelle commande</h1>

<c:if test="${not empty erreur}">
    <div class="alerte alerte-erreur">${erreur}</div>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/commandes/nouvelle">
    <div class="carte">
        <h2 class="sous-titre-page">Informations du client</h2>
        <div class="groupe-formulaire">
            <label for="nomClient">Nom du client</label>
            <input type="text" id="nomClient" name="nomClient" required>
        </div>
        <div class="groupe-formulaire">
            <label for="telephoneClient">Telephone</label>
            <input type="text" id="telephoneClient" name="telephoneClient" required>
        </div>
        <div class="groupe-formulaire">
            <label for="adresseLivraison">Adresse de livraison</label>
            <input type="text" id="adresseLivraison" name="adresseLivraison" required>
        </div>
        <div class="groupe-formulaire">
            <label for="source">Source de la commande</label>
            <select id="source" name="source" required>
                <option value="APPEL">APPEL</option>
                <option value="WHATSAPP">WHATSAPP</option>
            </select>
        </div>
    </div>

    <div class="carte">
        <h2 class="sous-titre-page">Selection des plats</h2>
        <table>
            <thead>
                <tr>
                    <th>Selectionner</th>
                    <th>Plat</th>
                    <th>Prix unitaire</th>
                    <th>Quantite</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="plat" items="${platsDisponibles}">
                    <tr>
                        <td><input type="checkbox" name="plat_${plat.id}" value="${plat.id}" class="case-plat" data-prix="${plat.prix}"></td>
                        <td><c:out value="${plat.nom}"/></td>
                        <td><c:out value="${plat.prix}"/> Ar</td>
                        <td><input type="number" name="quantite_${plat.id}" min="0" value="0" class="quantite-plat" data-prix="${plat.prix}"></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${empty platsDisponibles}">
            <p class="texte-secondaire">Aucun plat disponible. Ajoutez d'abord des plats dans le menu.</p>
        </c:if>
        <div class="statistiques" style="margin-top:15px;margin-bottom:0">
            <div class="carte-stat">
                <div class="valeur" id="montantTotal">0 Ar</div>
                <div class="libelle">Montant total</div>
            </div>
        </div>
    </div>

    <div class="carte">
        <h2 class="sous-titre-page">Livreur</h2>
        <div class="groupe-formulaire">
            <label for="livreurId">Livreur disponible</label>
            <select id="livreurId" name="livreurId">
                <option value="0">Aucun livreur</option>
                <c:forEach var="livreur" items="${livreursDisponibles}">
                    <option value="${livreur.id}"><c:out value="${livreur.nom}"/> - <c:out value="${livreur.telephone}"/></option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="carte">
        <h2 class="sous-titre-page">Paiement Mobile Money</h2>
        <div class="groupe-formulaire">
            <label for="referencePaiement">Reference du paiement Mobile Money</label>
            <input type="text" id="referencePaiement" name="referencePaiement" required>
        </div>
        <p class="texte-secondaire">Mode de paiement : MOBILE_MONEY. Le montant est calcule automatiquement.</p>
    </div>

    <div style="margin-bottom:25px">
        <button type="submit" class="bouton" style="width:auto;padding:11px 28px">Enregistrer la commande</button>
        <a class="bouton-secondaire" href="${pageContext.request.contextPath}/commandes" style="padding:12px 15px">Annuler</a>
    </div>
</form>

<script src="${pageContext.request.contextPath}/assets/js/commande.js"></script>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>