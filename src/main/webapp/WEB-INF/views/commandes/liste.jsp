<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Commandes"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<div class="mb-6 flex items-center justify-between">
    <div>
        <h1 class="text-2xl font-bold text-slate-900">Commandes</h1>
        <p class="mt-1 text-xs text-slate-400">Suivi des commandes du restaurant</p>
    </div>
    <a href="${pageContext.request.contextPath}/commandes/nouvelle"
       class="inline-flex items-center gap-2 rounded-xl bg-teal-600 px-4 py-2.5 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800">
        <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 5v14M5 12h14"/></svg>
        Nouvelle commande
    </a>
</div>

<div class="overflow-x-auto rounded-2xl border border-slate-100 bg-white">
    <table class="w-full min-w-[860px] text-sm">
        <thead>
            <tr class="border-b border-slate-100 bg-slate-50/50 text-left text-[11px] font-semibold uppercase tracking-wider text-slate-400">
                <th class="px-4 py-4">Reference</th>
                <th class="px-4 py-4">Client</th>
                <th class="px-4 py-4">Source</th>
                <th class="px-4 py-4">Statut</th>
                <th class="px-4 py-4">Livreur</th>
                <th class="px-4 py-4 text-right">Total</th>
                <th class="px-4 py-4">Date</th>
                <th class="px-4 py-4 text-right">Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="commande" items="${commandes}">
                <tr class="border-b border-slate-100 transition hover:bg-slate-50/60">
                    <td class="px-4 py-4 font-mono text-xs font-medium text-slate-500"><c:out value="${commande.reference}"/></td>
                    <td class="px-4 py-4">
                        <span class="font-medium text-slate-900"><c:out value="${commande.nomClient}"/></span>
                        <span class="block text-xs text-slate-400"><c:out value="${commande.telephoneClient}"/></span>
                    </td>
                    <td class="px-4 py-4">
                        <c:set var="badgeSource" value="${commande.source}"/>
                        <%@ include file="/WEB-INF/views/includes/source-badge.jsp" %>
                    </td>
                    <td class="px-4 py-4">
                        <c:set var="badgeStatut" value="${commande.statut}"/>
                        <%@ include file="/WEB-INF/views/includes/statut-badge.jsp" %>
                    </td>
                    <td class="px-4 py-4">
                        <c:choose>
                            <c:when test="${not empty commande.nomLivreur}">
                                <span class="text-slate-700"><c:out value="${commande.nomLivreur}"/></span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-xs text-slate-400">Non assigne</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="px-4 py-4 font-mono font-bold text-right text-slate-900"><c:out value="${commande.totalTexte}"/></td>
                    <td class="px-4 py-4 text-xs text-slate-400"><c:out value="${commande.dateCommandeTexte}"/></td>
                    <td class="px-4 py-4">
                        <div class="flex items-center justify-end gap-1">
                            <a href="${pageContext.request.contextPath}/commandes/details?id=${commande.id}" title="Details"
                               class="rounded-md p-1.5 text-slate-400 transition-colors hover:bg-teal-50 hover:text-teal-600">
                                <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                                    <circle cx="12" cy="12" r="3"/>
                                </svg>
                            </a>
                            <a href="${pageContext.request.contextPath}/factures?id=${commande.id}" title="Facture"
                               class="rounded-md p-1.5 text-slate-400 transition-colors hover:bg-teal-50 hover:text-teal-600">
                                <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                                    <path d="M14 2v6h6M16 13H8M16 17H8M10 9H8"/>
                                </svg>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${empty commandes}">
        <div class="px-4 py-10 text-center">
            <p class="text-sm text-slate-400">Aucune commande enregistree.</p>
            <a href="${pageContext.request.contextPath}/commandes/nouvelle"
               class="mt-3 inline-flex items-center gap-2 rounded-xl bg-teal-600 px-4 py-2 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800">
                Creer la premiere commande
            </a>
        </div>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>