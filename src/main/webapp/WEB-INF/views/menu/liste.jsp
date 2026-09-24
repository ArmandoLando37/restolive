<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="fr_FR"/>
<c:set var="titrePage" value="Menu"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<div class="mb-6 flex items-center justify-between">
    <div>
        <h1 class="text-2xl font-bold text-slate-900">Menu</h1>
        <p class="mt-1 text-xs text-slate-400">Catalogue des plats du restaurant</p>
    </div>
    <a href="${pageContext.request.contextPath}/menu/ajouter"
       class="inline-flex items-center gap-2 rounded-xl bg-teal-600 px-4 py-2.5 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800">
        <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 5v14M5 12h14"/></svg>
        Ajouter un plat
    </a>
</div>

<c:if test="${not empty param.info}">
    <div class="mb-5 rounded-xl border border-emerald-100 bg-emerald-50 px-4 py-3 text-sm text-emerald-700">${param.info}</div>
</c:if>
<c:if test="${not empty param.erreur}">
    <div class="mb-5 rounded-xl border border-rose-100 bg-rose-50 px-4 py-3 text-sm text-rose-700">${param.erreur}</div>
</c:if>

<div class="mb-6 flex flex-col gap-3 rounded-2xl border border-slate-100/80 bg-[#F0F7F5] p-4 sm:flex-row sm:items-center sm:justify-between">
    <div class="flex flex-wrap items-center gap-3">
        <form method="get" action="${pageContext.request.contextPath}/menu" class="flex items-center gap-2">
            <input type="text" name="recherche" value="${searchTerm}" placeholder="Rechercher un plat..."
                   class="rounded-xl border border-slate-200 bg-white px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
            <button type="submit" class="rounded-xl bg-slate-100 px-3 py-2.5 text-sm font-medium text-slate-600 transition-colors hover:bg-slate-200">
                Rechercher
            </button>
        </form>
        <div class="flex items-center gap-1 rounded-xl bg-slate-100 p-1 text-sm">
            <a href="${pageContext.request.contextPath}/menu?tri=asc" class="rounded-lg px-2.5 py-1.5 font-medium text-slate-600 transition-colors hover:bg-white hover:shadow-sm">Croissant</a>
            <a href="${pageContext.request.contextPath}/menu?tri=desc" class="rounded-lg px-2.5 py-1.5 font-medium text-slate-600 transition-colors hover:bg-white hover:shadow-sm">Decroissant</a>
        </div>
    </div>
    <form method="get" action="${pageContext.request.contextPath}/menu" class="flex items-center gap-2">
        <input type="number" step="0.01" name="budget" value="${budget}" placeholder="Budget (Ar)"
               class="w-36 rounded-xl border border-slate-200 bg-white px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
        <button type="submit" title="Interpolation Search"
                class="inline-flex items-center gap-2 rounded-xl bg-slate-100 px-3 py-2.5 text-sm font-medium text-slate-600 transition-colors hover:bg-slate-200">
            <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/>
            </svg>
            Plat selon budget
        </button>
    </form>
</div>

<c:if test="${not empty budget}">
    <div class="mb-6 rounded-2xl border border-indigo-100 bg-indigo-50/70 px-4 py-3 text-sm text-indigo-800">
        <c:choose>
            <c:when test="${empty platBudget}">
                Resultat pour un budget de <strong class="font-mono"><fmt:formatNumber value="${budget}" pattern="#,##0"/> Ar</strong> : aucun plat.
            </c:when>
            <c:otherwise>
                Resultat pour un budget de <strong class="font-mono"><fmt:formatNumber value="${budget}" pattern="#,##0"/> Ar</strong> : plat le plus proche
                <strong><c:out value="${platBudget.nom}"/></strong> a <strong class="font-mono"><c:out value="${platBudget.prixTexte}"/></strong>.
            </c:otherwise>
        </c:choose>
    </div>
</c:if>

<div class="overflow-x-auto rounded-2xl border border-slate-100 bg-white">
    <table class="w-full min-w-[640px] text-sm">
        <thead>
            <tr class="border-b border-slate-100 bg-slate-50/50 text-left text-[11px] font-semibold uppercase tracking-wider text-slate-400">
                <th class="px-4 py-4">Nom</th>
                <th class="px-4 py-4">Description</th>
                <th class="px-4 py-4">Prix</th>
                <th class="px-4 py-4">Disponibilite</th>
                <th class="px-4 py-4 text-right">Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="plat" items="${plats}">
                <tr class="border-b border-slate-100 transition hover:bg-slate-50/60 ${platBudget != null && platBudget.id == plat.id ? 'bg-amber-50/70' : ''}">
                    <td class="px-4 py-4 font-medium text-slate-900"><c:out value="${plat.nom}"/></td>
                    <td class="px-4 py-4 text-slate-500"><c:out value="${plat.description}"/></td>
                    <td class="px-4 py-4 font-mono font-bold text-right text-slate-900"><c:out value="${plat.prixTexte}"/></td>
                    <td class="px-4 py-4">
                        <c:choose>
                            <c:when test="${plat.disponible}">
                                <span class="inline-flex items-center gap-1.5 rounded-full border border-emerald-100 bg-emerald-50 px-2.5 py-0.5 text-xs font-medium text-emerald-700">
                                    <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>Disponible
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="inline-flex items-center gap-1.5 rounded-full border border-rose-100 bg-rose-50 px-2.5 py-0.5 text-xs font-medium text-rose-700">
                                    <span class="h-1.5 w-1.5 rounded-full bg-rose-500"></span>Desactive
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="px-4 py-4">
                        <div class="flex items-center justify-end gap-1">
                            <a href="${pageContext.request.contextPath}/menu/modifier?id=${plat.id}" title="Modifier"
                               class="rounded-md p-1.5 text-slate-400 transition-colors hover:bg-teal-50 hover:text-teal-600">
                                <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"/>
                                </svg>
                            </a>
                            <c:if test="${plat.disponible}">
                                <form method="post" action="${pageContext.request.contextPath}/menu/desactiver" class="m-0">
                                    <input type="hidden" name="id" value="${plat.id}">
                                    <button type="submit" title="Desactiver"
                                            class="rounded-md p-1.5 text-slate-400 transition-colors hover:bg-rose-50 hover:text-rose-600">
                                        <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M18.36 6.64a9 9 0 1 1-12.73 0"/>
                                            <path d="M12 2v10"/>
                                        </svg>
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${empty plats}">
        <div class="px-4 py-10 text-center">
            <p class="text-sm text-slate-400">Aucun plat dans le menu.</p>
        </div>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>