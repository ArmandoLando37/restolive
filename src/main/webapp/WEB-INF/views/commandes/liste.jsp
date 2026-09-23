<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Commandes"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<h1 class="titre-page">Commandes</h1>

<div class="carte">
    <div class="barre-outils">
        <a class="bouton" href="${pageContext.request.contextPath}/commandes/nouvelle" style="text-decoration:none;text-align:center;width:auto;padding:8px 14px;margin-top:0">Nouvelle commande</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>Reference</th>
                <th>Client</th>
                <th>Source</th>
                <th>Statut</th>
                <th>Livreur</th>
                <th>Total</th>
                <th>Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="commande" items="${commandes}">
                <tr>
                    <td><c:out value="${commande.reference}"/></td>
                    <td>
                        <c:out value="${commande.nomClient}"/>
                        <br><span class="texte-secondaire"><c:out value="${commande.telephoneClient}"/></span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${commande.source == 'APPEL'}">
                                <span class="badge badge-vert">APPEL</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-gris">WHATSAPP</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><span class="badge" style="background:#e0e0e0;color:#383d41"><c:out value="${commande.statut}"/></span></td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty commande.nomLivreur}">
                                <c:out value="${commande.nomLivreur}"/>
                            </c:when>
                            <c:otherwise>
                                <span class="texte-secondaire">Non assigne</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><c:out value="${commande.total}"/> Ar</td>
                    <td><c:out value="${commande.dateCommandeTexte}"/></td>
                    <td class="actions">
                        <a class="bouton-secondaire" href="${pageContext.request.contextPath}/commandes/details?id=${commande.id}">Details</a>
                        <a class="bouton-secondaire" href="${pageContext.request.contextPath}/factures?id=${commande.id}">Facture</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${empty commandes}">
        <p class="texte-secondaire">Aucune commande enregistree.</p>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>