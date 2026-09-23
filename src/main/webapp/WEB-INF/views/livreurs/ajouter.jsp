<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Ajouter un livreur"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<h1 class="titre-page">Ajouter un livreur</h1>

<div class="carte">
    <form method="post" action="${pageContext.request.contextPath}/livreurs/ajouter">
        <div class="groupe-formulaire">
            <label for="nom">Nom du livreur</label>
            <input type="text" id="nom" name="nom" required>
        </div>
        <div class="groupe-formulaire">
            <label for="telephone">Telephone</label>
            <input type="text" id="telephone" name="telephone" required>
        </div>
        <button type="submit" class="bouton" style="width:auto;padding:10px 25px;margin-top:5px">Enregistrer</button>
        <a class="bouton-secondaire" href="${pageContext.request.contextPath}/livreurs" style="padding:11px 15px">Annuler</a>
    </form>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>