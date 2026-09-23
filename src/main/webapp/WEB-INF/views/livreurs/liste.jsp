<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Livreurs"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<h1 class="titre-page">Livreurs</h1>

<c:if test="${not empty param.info}">
    <div class="alerte alerte-succes">${param.info}</div>
</c:if>
<c:if test="${not empty param.erreur}">
    <div class="alerte alerte-erreur">${param.erreur}</div>
</c:if>

<div class="carte">
    <div class="barre-outils">
        <a class="bouton" href="${pageContext.request.contextPath}/livreurs/ajouter" style="text-decoration:none;text-align:center;width:auto;padding:8px 14px;margin-top:0">Ajouter un livreur</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>Nom</th>
                <th>Telephone</th>
                <th>Statut</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="livreur" items="${livreurs}">
                <tr>
                    <td><c:out value="${livreur.nom}"/></td>
                    <td><c:out value="${livreur.telephone}"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${livreur.statut == 'LIBRE'}">
                                <span class="badge badge-vert">LIBRE</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-gris">EN_LIVRAISON</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="actions">
                        <a class="bouton-secondaire" href="${pageContext.request.contextPath}/livreurs/modifier?id=${livreur.id}">Modifier</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${empty livreurs}">
        <p class="texte-secondaire">Aucun livreur enregistre.</p>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>