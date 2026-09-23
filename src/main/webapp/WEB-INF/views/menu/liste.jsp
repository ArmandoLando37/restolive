<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Menu"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<h1 class="titre-page">Menu</h1>

<c:if test="${not empty param.info}">
    <div class="alerte alerte-succes">${param.info}</div>
</c:if>
<c:if test="${not empty param.erreur}">
    <div class="alerte alerte-erreur">${param.erreur}</div>
</c:if>

<div class="carte">
    <div class="barre-outils">
        <form method="get" action="${pageContext.request.contextPath}/menu">
            <input type="text" name="recherche" value="${searchTerm}" placeholder="Rechercher un plat par nom">
            <button type="submit" class="bouton-secondaire">Rechercher</button>
        </form>
        <a class="bouton-secondaire" href="${pageContext.request.contextPath}/menu?tri=asc">Tri prix croissant</a>
        <a class="bouton-secondaire" href="${pageContext.request.contextPath}/menu?tri=desc">Tri prix decroissant</a>
        <form method="get" action="${pageContext.request.contextPath}/menu">
            <input type="number" step="0.01" name="budget" value="${budget}" placeholder="Budget en Ar (Interpolation Search)">
            <button type="submit" class="bouton-secondaire">Plat selon budget</button>
        </form>
        <a class="bouton" href="${pageContext.request.contextPath}/menu/ajouter" style="text-decoration:none;text-align:center;width:auto;padding:8px 14px;margin-top:0">Ajouter un plat</a>
    </div>

    <c:if test="${not empty budget}">
        <p class="texte-secondaire">
            Resultat de la recherche par budget (${budget} Ar) :
            <c:choose>
                <c:when test="${empty platBudget}">aucun plat.</c:when>
                <c:otherwise>plat le plus proche : <strong>${platBudget.nom}</strong> a <strong>${platBudget.prix} Ar</strong>.</c:otherwise>
            </c:choose>
        </p>
    </c:if>

    <table>
        <thead>
            <tr>
                <th>Nom</th>
                <th>Description</th>
                <th>Prix</th>
                <th>Disponibilite</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="plat" items="${plats}">
                <tr class="${platBudget != null && platBudget.id == plat.id ? 'surbrillance' : ''}">
                    <td><c:out value="${plat.nom}"/></td>
                    <td><c:out value="${plat.description}"/></td>
                    <td><c:out value="${plat.prix}"/> Ar</td>
                    <td>
                        <c:choose>
                            <c:when test="${plat.disponible}">
                                <span class="badge badge-vert">Disponible</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-gris">Desactive</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="actions">
                        <a class="bouton-secondaire" href="${pageContext.request.contextPath}/menu/modifier?id=${plat.id}">Modifier</a>
                        <c:if test="${plat.disponible}">
                            <form method="post" action="${pageContext.request.contextPath}/menu/desactiver">
                                <input type="hidden" name="id" value="${plat.id}">
                                <button type="submit" class="bouton-secondaire bouton-retrait">Desactiver</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${empty plats}">
        <p class="texte-secondaire">Aucun plat dans le menu.</p>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>