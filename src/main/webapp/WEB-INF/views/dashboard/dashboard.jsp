<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="fr_FR"/>
<c:set var="titrePage" value="Dashboard"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<div class="mb-6 flex items-center justify-between">
    <div>
        <h1 class="text-2xl font-bold text-slate-900">Dashboard</h1>
        <p class="mt-1 text-xs text-slate-400">Vue d'ensemble de l'activite du jour</p>
    </div>
</div>

<div class="grid grid-cols-1 gap-5 md:grid-cols-2 lg:grid-cols-4">
    <div class="rounded-2xl bg-gradient-to-br from-blue-50/80 to-indigo-50/50 p-5">
        <div class="flex items-start justify-between">
            <p class="text-xs font-semibold text-slate-500">Chiffre d'affaires</p>
            <span class="flex h-10 w-10 items-center justify-center rounded-xl bg-white/80">
                <svg class="h-5 w-5 text-indigo-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M3 11l18-7-7 18-2.5-7.5L3 11z"/>
                </svg>
            </span>
        </div>
        <p class="mt-4 font-mono text-2xl font-bold text-slate-900">${chiffreAffairesTexte} Ar</p>
        <c:set var="pctCA" value="${chiffreAffairesHier > 0 ? (chiffreAffaires - chiffreAffairesHier) * 100 / chiffreAffairesHier : (chiffreAffaires > 0 ? 100 : 0)}"/>
        <c:choose>
            <c:when test="${pctCA > 0}">
                <p class="mt-1 text-xs font-medium text-emerald-600">+<fmt:formatNumber value="${pctCA}" pattern="#,##0.00"/>% vs hier</p>
            </c:when>
            <c:when test="${pctCA < 0}">
                <p class="mt-1 text-xs font-medium text-rose-600"><fmt:formatNumber value="${pctCA}" pattern="#,##0.00"/>% vs hier</p>
            </c:when>
            <c:otherwise>
                <p class="mt-1 text-xs font-medium text-slate-400">Stable vs hier</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="rounded-2xl bg-gradient-to-br from-teal-50/80 to-emerald-50/50 p-5">
        <div class="flex items-start justify-between">
            <p class="text-xs font-semibold text-slate-500">Commandes aujourdhui</p>
            <span class="flex h-10 w-10 items-center justify-center rounded-xl bg-white/80">
                <svg class="h-5 w-5 text-teal-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M6 2v4M18 2v4M6 6H4a1 1 0 0 0-1 1v13a1 1 0 0 0 1 1h16a1 1 0 0 0 1-1V7a1 1 0 0 0-1-1h-2"/>
                    <path d="M8 12h8M8 16h5"/>
                </svg>
            </span>
        </div>
        <p class="mt-4 text-2xl font-bold text-slate-900">${commandesAujourdhui}</p>
        <c:set var="deltaCommandes" value="${commandesAujourdhui - commandesHier}"/>
        <c:choose>
            <c:when test="${deltaCommandes > 0}">
                <p class="mt-1 text-xs font-medium text-emerald-600">+${deltaCommandes} commande(s) vs hier</p>
            </c:when>
            <c:when test="${deltaCommandes < 0}">
                <p class="mt-1 text-xs font-medium text-rose-600">${deltaCommandes} commande(s) vs hier</p>
            </c:when>
            <c:otherwise>
                <p class="mt-1 text-xs font-medium text-slate-400">Stable vs hier</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="rounded-2xl bg-gradient-to-br from-teal-50/80 to-emerald-50/50 p-5">
        <div class="flex items-start justify-between">
            <p class="text-xs font-semibold text-slate-500">Livreurs libres</p>
            <span class="flex h-10 w-10 items-center justify-center rounded-xl bg-white/80">
                <svg class="h-5 w-5 text-emerald-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="5.5" cy="17.5" r="3.5"/>
                    <circle cx="18.5" cy="17.5" r="3.5"/>
                    <path d="M15 17.5H9a4 4 0 0 1 0-8h6a4 4 0 0 1 0 8z"/>
                </svg>
            </span>
        </div>
        <p class="mt-4 text-2xl font-bold text-slate-900">${livreursLibre}</p>
        <p class="mt-1 text-xs font-medium text-slate-400">Pret a partir en livraison</p>
    </div>

    <div class="rounded-2xl bg-gradient-to-br from-slate-50 to-blue-50/60 p-5">
        <div class="flex items-start justify-between">
            <p class="text-xs font-semibold text-slate-500">Livreurs en livraison</p>
            <span class="flex h-10 w-10 items-center justify-center rounded-xl bg-white/80">
                <svg class="h-5 w-5 text-blue-500" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M3 7h11a4 4 0 0 1 4 4v5h-3"/>
                    <path d="M1 7h2"/>
                    <circle cx="7" cy="17.5" r="2.5"/>
                    <circle cx="17" cy="17.5" r="2.5"/>
                    <path d="M4 17.5H14"/>
                </svg>
            </span>
        </div>
        <p class="mt-4 text-2xl font-bold text-slate-900">${livreursEnLivraison}</p>
        <p class="mt-1 text-xs font-medium text-slate-400">Commandes en cours d'acheminement</p>
    </div>
</div>

<div class="mt-6 grid gap-6 lg:grid-cols-3">
    <section class="lg:col-span-2">
        <h2 class="text-base font-semibold text-slate-900">Commandes par statut</h2>
        <div class="mt-4 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-5">
            <div class="rounded-2xl border border-blue-100 bg-blue-50/70 p-5">
                <p class="text-2xl font-bold text-slate-900">${statutRecue}</p>
                <p class="mt-0.5 text-sm font-medium text-blue-700">Recue</p>
            </div>
            <div class="rounded-2xl border border-amber-100 bg-amber-50/70 p-5">
                <p class="text-2xl font-bold text-slate-900">${statutEnCuisine}</p>
                <p class="mt-0.5 text-sm font-medium text-amber-700">En cuisine</p>
            </div>
            <div class="rounded-2xl border border-purple-100 bg-purple-50/70 p-5">
                <p class="text-2xl font-bold text-slate-900">${statutEnLivraison}</p>
                <p class="mt-0.5 text-sm font-medium text-purple-700">En livraison</p>
            </div>
            <div class="rounded-2xl border border-emerald-100 bg-emerald-50/70 p-5">
                <p class="text-2xl font-bold text-slate-900">${statutLivree}</p>
                <p class="mt-0.5 text-sm font-medium text-emerald-700">Livree</p>
            </div>
            <div class="rounded-2xl border border-rose-100 bg-rose-50/70 p-5">
                <p class="text-2xl font-bold text-slate-900">${statutRetour}</p>
                <p class="mt-0.5 text-sm font-medium text-rose-700">Retour</p>
            </div>
        </div>
    </section>

    <aside class="h-fit rounded-2xl border border-slate-100/80 bg-white p-5">
        <h2 class="text-base font-semibold text-slate-900">Actions rapides</h2>
        <p class="mt-0.5 text-xs text-slate-400">Raccourcis vers les taches courantes</p>
        <div class="mt-4 space-y-2">
            <a href="${pageContext.request.contextPath}/commandes/nouvelle"
               class="flex items-center gap-2.5 rounded-xl bg-teal-600 px-3 py-2.5 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800">
                <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 5v14M5 12h14"/></svg>
                Nouvelle commande
            </a>
            <a href="${pageContext.request.contextPath}/menu/ajouter"
               class="flex items-center gap-2.5 rounded-xl border border-slate-200 bg-white px-3 py-2 text-sm font-medium text-slate-600 transition-colors hover:border-teal-300 hover:bg-teal-50 hover:text-teal-700">
                <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
                </svg>
                Ajouter un plat
            </a>
            <a href="${pageContext.request.contextPath}/livreurs/ajouter"
               class="flex items-center gap-2.5 rounded-xl border border-slate-200 bg-white px-3 py-2 text-sm font-medium text-slate-600 transition-colors hover:border-teal-300 hover:bg-teal-50 hover:text-teal-700">
                <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/>
                </svg>
                Ajouter un livreur
            </a>
        </div>
    </aside>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>