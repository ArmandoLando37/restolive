<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Modifier un livreur"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<div class="mb-6">
    <h1 class="text-2xl font-bold text-slate-900">Modifier un livreur</h1>
    <p class="mt-1 text-xs text-slate-400">Met a jour les informations du livreur</p>
</div>

<c:if test="${empty livreur}">
    <div class="rounded-2xl border border-rose-100 bg-rose-50 px-4 py-3 text-sm text-rose-700">Livreur introuvable.</div>
</c:if>

<c:if test="${not empty livreur}">
    <div class="max-w-2xl rounded-2xl border border-slate-100/80 bg-white p-6">
        <form method="post" action="${pageContext.request.contextPath}/livreurs/modifier" class="space-y-5">
            <input type="hidden" name="id" value="${livreur.id}">
            <div>
                <label for="nom" class="mb-1.5 block text-sm font-medium text-slate-600">Nom du livreur</label>
                <input type="text" id="nom" name="nom" value="${livreur.nom}" required
                       class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
            </div>
            <div>
                <label for="telephone" class="mb-1.5 block text-sm font-medium text-slate-600">Telephone</label>
                <input type="text" id="telephone" name="telephone" value="${livreur.telephone}" required
                       class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
            </div>
            <div>
                <label for="statut" class="mb-1.5 block text-sm font-medium text-slate-600">Statut</label>
                <select id="statut" name="statut"
                        class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
                    <option value="LIBRE" ${livreur.statut == 'LIBRE' ? 'selected' : ''}>Libre</option>
                    <option value="EN_LIVRAISON" ${livreur.statut == 'EN_LIVRAISON' ? 'selected' : ''}>En livraison</option>
                </select>
            </div>
            <div class="flex items-center gap-3 pt-1">
                <button type="submit"
                        class="inline-flex items-center gap-2 rounded-xl bg-teal-600 px-5 py-2.5 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800">
                    Enregistrer
                </button>
                <a href="${pageContext.request.contextPath}/livreurs"
                   class="rounded-xl bg-slate-100 px-5 py-2.5 text-sm font-medium text-slate-600 transition-colors hover:bg-slate-200">Annuler</a>
            </div>
        </form>
    </div>
</c:if>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>