<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Nouvelle commande"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<div class="mb-6">
    <h1 class="text-2xl font-bold text-slate-900">Nouvelle commande</h1>
    <p class="mt-1 text-xs text-slate-400">Passez une commande, choisissez les plats et le livreur</p>
</div>

<c:if test="${not empty erreur}">
    <div class="mb-5 rounded-xl border border-rose-100 bg-rose-50 px-4 py-3 text-sm text-rose-700">${erreur}</div>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/commandes/nouvelle" class="space-y-6">
    <div class="rounded-2xl border border-slate-100/80 bg-white p-6">
        <h2 class="text-base font-semibold text-slate-900">Informations du client</h2>
        <div class="mt-4 grid gap-4 sm:grid-cols-2">
            <div>
                <label for="nomClient" class="mb-1.5 block text-sm font-medium text-slate-600">Nom du client</label>
                <input type="text" id="nomClient" name="nomClient" required
                       class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
            </div>
            <div>
                <label for="telephoneClient" class="mb-1.5 block text-sm font-medium text-slate-600">Telephone</label>
                <input type="text" id="telephoneClient" name="telephoneClient" required
                       class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
            </div>
            <div>
                <label for="adresseLivraison" class="mb-1.5 block text-sm font-medium text-slate-600">Adresse de livraison</label>
                <input type="text" id="adresseLivraison" name="adresseLivraison" required
                       class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
            </div>
            <div>
                <label for="source" class="mb-1.5 block text-sm font-medium text-slate-600">Source de la commande</label>
                <select id="source" name="source" required
                        class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
                    <option value="APPEL">Par appel</option>
                    <option value="WHATSAPP">Par WhatsApp</option>
                </select>
            </div>
        </div>
    </div>

    <div class="rounded-2xl border border-slate-100/80 bg-white p-6">
        <div class="flex flex-wrap items-center justify-between gap-3">
            <h2 class="text-base font-semibold text-slate-900">Selection des plats</h2>
            <div class="rounded-xl bg-teal-50 px-4 py-2">
                <span class="font-mono text-sm font-bold text-teal-700" id="montantTotal">0 Ar</span>
                <span class="ml-1 text-xs font-medium text-teal-500/80">Total</span>
            </div>
        </div>
        <div class="mt-4 overflow-x-auto rounded-2xl border border-slate-100">
            <table class="w-full min-w-[600px] text-sm">
                <thead>
                    <tr class="border-b border-slate-100 bg-slate-50/50 text-left text-[11px] font-semibold uppercase tracking-wider text-slate-400">
                        <th class="w-12 px-4 py-4">Choix</th>
                        <th class="px-4 py-4">Plat</th>
                        <th class="px-4 py-4 text-right">Prix unitaire</th>
                        <th class="w-36 px-4 py-4">Quantite</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="plat" items="${platsDisponibles}">
                        <tr class="border-b border-slate-100 transition hover:bg-slate-50/60">
                            <td class="px-4 py-4">
                                <input type="checkbox" name="plat_${plat.id}" value="${plat.id}"
                                       class="case-plat h-4 w-4 rounded border-slate-300 text-teal-600 transition-colors focus:ring-teal-500"
                                       data-prix="${plat.prix}">
                            </td>
                            <td class="px-4 py-4">
                                <span class="font-medium text-slate-900"><c:out value="${plat.nom}"/></span>
                                <span class="block text-xs text-slate-400"><c:out value="${plat.description}"/></span>
                            </td>
                            <td class="px-4 py-4 font-mono text-right text-slate-600"><c:out value="${plat.prixTexte}"/></td>
                            <td class="px-4 py-4">
                                <input type="number" name="quantite_${plat.id}" min="0" value="0" data-prix="${plat.prix}"
                                       class="quantite-plat w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2 text-sm text-slate-900 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <c:if test="${empty platsDisponibles}">
            <div class="px-4 py-8 text-center">
                <p class="text-sm text-slate-400">Aucun plat disponible. Ajoutez d'abord des plats dans le menu.</p>
            </div>
        </c:if>
    </div>

    <div class="rounded-2xl border border-slate-100/80 bg-white p-6">
        <h2 class="text-base font-semibold text-slate-900">Livreur</h2>
        <div class="mt-4">
            <label for="livreurId" class="mb-1.5 block text-sm font-medium text-slate-600">Livreur disponible</label>
            <select id="livreurId" name="livreurId"
                    class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
                <option value="0">Aucun livreur</option>
                <c:forEach var="livreur" items="${livreursDisponibles}">
                    <option value="${livreur.id}"><c:out value="${livreur.nom}"/> - <c:out value="${livreur.telephone}"/></option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="rounded-2xl border border-slate-100/80 bg-white p-6">
        <h2 class="text-base font-semibold text-slate-900">Paiement Mobile Money</h2>
        <div class="mt-4">
            <label for="referencePaiement" class="mb-1.5 block text-sm font-medium text-slate-600">Reference du paiement Mobile Money</label>
            <input type="text" id="referencePaiement" name="referencePaiement" required
                   class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
        </div>
        <p class="mt-2 text-xs text-slate-400">Mode de paiement : Mobile Money. Le montant est calcule automatiquement.</p>
    </div>

    <div class="flex flex-wrap items-center gap-3">
        <button type="submit"
                class="inline-flex items-center gap-2 rounded-xl bg-teal-600 px-6 py-2.5 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800">
            Enregistrer la commande
        </button>
        <a href="${pageContext.request.contextPath}/commandes"
           class="rounded-xl bg-slate-100 px-6 py-2.5 text-sm font-medium text-slate-600 transition-colors hover:bg-slate-200">Annuler</a>
    </div>
</form>

<script src="${pageContext.request.contextPath}/assets/js/commande.js"></script>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>