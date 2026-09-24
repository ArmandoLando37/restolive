<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Livreurs"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<div class="mb-6 flex items-center justify-between">
    <div>
        <h1 class="text-2xl font-bold text-slate-900">Livreurs</h1>
        <p class="mt-1 text-xs text-slate-400">Personnel de livraison du restaurant</p>
    </div>
    <a href="${pageContext.request.contextPath}/livreurs/ajouter"
       class="inline-flex items-center gap-2 rounded-xl bg-teal-600 px-4 py-2.5 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800">
        <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 5v14M5 12h14"/></svg>
        Ajouter un livreur
    </a>
</div>

<c:if test="${not empty param.info}">
    <div class="mb-5 rounded-xl border border-emerald-100 bg-emerald-50 px-4 py-3 text-sm text-emerald-700">${param.info}</div>
</c:if>
<c:if test="${not empty param.erreur}">
    <div class="mb-5 rounded-xl border border-rose-100 bg-rose-50 px-4 py-3 text-sm text-rose-700">${param.erreur}</div>
</c:if>

<div class="overflow-x-auto rounded-2xl border border-slate-100 bg-white">
    <table class="w-full min-w-[560px] text-sm">
        <thead>
            <tr class="border-b border-slate-100 bg-slate-50/50 text-left text-[11px] font-semibold uppercase tracking-wider text-slate-400">
                <th class="px-4 py-4">Nom</th>
                <th class="px-4 py-4">Telephone</th>
                <th class="px-4 py-4">Statut</th>
                <th class="px-4 py-4 text-right">Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="livreur" items="${livreurs}">
                <tr class="border-b border-slate-100 transition hover:bg-slate-50/60">
                    <td class="px-4 py-4">
                        <div class="flex items-center gap-3">
                            <div class="flex h-9 w-9 items-center justify-center rounded-full bg-teal-50 text-xs font-bold uppercase text-teal-700">
                                <c:out value="${livreur.nom.substring(0, 1)}"/>
                            </div>
                            <span class="font-medium text-slate-900"><c:out value="${livreur.nom}"/></span>
                        </div>
                    </td>
                    <td class="px-4 py-4 text-slate-500"><c:out value="${livreur.telephone}"/></td>
                    <td class="px-4 py-4">
                        <c:set var="badgeStatut" value="${livreur.statut}"/>
                        <%@ include file="/WEB-INF/views/includes/statut-badge.jsp" %>
                    </td>
                    <td class="px-4 py-4">
                        <div class="flex items-center justify-end gap-1">
                            <a href="${pageContext.request.contextPath}/livreurs/modifier?id=${livreur.id}" title="Modifier"
                               class="rounded-md p-1.5 text-slate-400 transition-colors hover:bg-teal-50 hover:text-teal-600">
                                <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"/>
                                </svg>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${empty livreurs}">
        <div class="px-4 py-10 text-center">
            <p class="text-sm text-slate-400">Aucun livreur enregistre.</p>
        </div>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>