<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Modifier un livreur"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<h1 class="titre-page">Modifier un livreur</h1>

<c:if test="${empty livreur}">
    <div class="alerte alerte-erreur">Livreur introuvable.</div>
</c:if>

<c:if test="${not empty livreur}">
    <div class="carte">
        <form method="post" action="${pageContext.request.contextPath}/livreurs/modifier">
            <input type="hidden" name="id" value="${livreur.id}">
            <div class="groupe-formulaire">
                <label for="nom">Nom du livreur</label>
                <input type="text" id="nom" name="nom" value="${livreur.nom}" required>
            </div>
            <div class="groupe-formulaire">
                <label for="telephone">Telephone</label>
                <input type="text" id="telephone" name="telephone" value="${livreur.telephone}" required>
            </div>
            <div class="groupe-formulaire">
                <label for="statut">Statut</label>
                <select id="statut" name="statut">
                    <option value="LIBRE" ${livreur.statut == 'LIBRE' ? 'selected' : ''}>LIBRE</option>
                    <option value="EN_LIVRAISON" ${livreur.statut == 'EN_LIVRAISON' ? 'selected' : ''}>EN_LIVRAISON</option>
                </select>
            </div>
            <button type="submit" class="bouton" style="width:auto;padding:10px 25px;margin-top:5px">Enregistrer</button>
            <a class="bouton-secondaire" href="${pageContext.request.contextPath}/livreurs" style="padding:11px 15px">Annuler</a>
        </form>
    </div>
</c:if>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>