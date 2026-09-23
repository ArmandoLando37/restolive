<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Ajouter un plat"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<h1 class="titre-page">Ajouter un plat</h1>

<div class="carte">
    <form method="post" action="${pageContext.request.contextPath}/menu/ajouter">
        <div class="groupe-formulaire">
            <label for="nom">Nom du plat</label>
            <input type="text" id="nom" name="nom" required>
        </div>
        <div class="groupe-formulaire">
            <label for="description">Description</label>
            <textarea id="description" name="description"></textarea>
        </div>
        <div class="groupe-formulaire">
            <label for="prix">Prix (Ar)</label>
            <input type="number" step="0.01" min="0" id="prix" name="prix" required>
        </div>
        <div class="groupe-formulaire case-cocher">
            <input type="checkbox" id="disponible" name="disponible" checked>
            <label for="disponible">Plat disponible a la vente</label>
        </div>
        <button type="submit" class="bouton" style="width:auto;padding:10px 25px;margin-top:5px">Enregistrer</button>
        <a class="bouton-secondaire" href="${pageContext.request.contextPath}/menu" style="padding:11px 15px">Annuler</a>
    </form>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>