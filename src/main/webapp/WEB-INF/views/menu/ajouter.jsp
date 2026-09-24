<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Ajouter un plat"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<div class="mb-6">
    <h1 class="text-2xl font-bold text-slate-900">Ajouter un plat</h1>
    <p class="mt-1 text-xs text-slate-400">Nouveau plat dans le menu du restaurant</p>
</div>

<div class="max-w-2xl rounded-2xl border border-slate-100/80 bg-white p-6">
    <form method="post" action="${pageContext.request.contextPath}/menu/ajouter" class="space-y-5">
        <div>
            <label for="nom" class="mb-1.5 block text-sm font-medium text-slate-600">Nom du plat</label>
            <input type="text" id="nom" name="nom" required
                   class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
        </div>
        <div>
            <label for="description" class="mb-1.5 block text-sm font-medium text-slate-600">Description</label>
            <textarea id="description" name="description" rows="3"
                      class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10"></textarea>
        </div>
        <div>
            <label for="prix" class="mb-1.5 block text-sm font-medium text-slate-600">Prix (Ar)</label>
            <input type="number" step="0.01" min="0" id="prix" name="prix" required
                   class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
        </div>
        <label class="flex items-center gap-2.5 text-sm">
            <input type="checkbox" id="disponible" name="disponible" checked
                   class="h-4 w-4 rounded border-slate-300 text-teal-600 transition-colors focus:ring-teal-500">
            <span class="font-medium text-slate-600">Plat disponible a la vente</span>
        </label>
        <div class="flex items-center gap-3 pt-1">
            <button type="submit"
                    class="inline-flex items-center gap-2 rounded-xl bg-teal-600 px-5 py-2.5 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800">
                Enregistrer
            </button>
            <a href="${pageContext.request.contextPath}/menu"
               class="rounded-xl bg-slate-100 px-5 py-2.5 text-sm font-medium text-slate-600 transition-colors hover:bg-slate-200">Annuler</a>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>