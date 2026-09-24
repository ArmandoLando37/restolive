<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Details commande"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<div class="mb-6 flex flex-wrap items-center justify-between gap-3">
    <div>
        <h1 class="text-2xl font-bold text-slate-900">Commande <span class="font-mono text-slate-500"><c:out value="${commande.reference}"/></span></h1>
        <p class="mt-1 text-xs text-slate-400"><c:out value="${commande.dateCommandeTexte}"/></p>
    </div>
    <a href="${pageContext.request.contextPath}/factures?id=${commande.id}"
       class="inline-flex items-center gap-2 rounded-xl bg-teal-600 px-4 py-2.5 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800">
        <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><path d="M14 2v6h6"/><path d="M12 18v-6"/><path d="M9 15h6"/>
        </svg>
        Voir la facture
    </a>
</div>

<c:if test="${empty commande}">
    <div class="rounded-2xl border border-rose-100 bg-rose-50 px-4 py-3 text-sm text-rose-700">Commande introuvable.</div>
</c:if>

<c:if test="${not empty commande}">
    <div class="grid gap-6 lg:grid-cols-3">
        <div class="space-y-6 lg:col-span-2">
            <div class="rounded-2xl border border-slate-100/80 bg-white p-6">
                <h2 class="text-base font-semibold text-slate-900">Details de la commande</h2>
                <div class="mt-4 overflow-x-auto rounded-2xl border border-slate-100">
                    <table class="w-full min-w-[520px] text-sm">
                        <thead>
                            <tr class="border-b border-slate-100 bg-slate-50/50 text-left text-[11px] font-semibold uppercase tracking-wider text-slate-400">
                                <th class="px-4 py-4">Plat</th>
                                <th class="px-4 py-4 text-right">Prix unitaire</th>
                                <th class="px-4 py-4 text-center">Quantite</th>
                                <th class="px-4 py-4 text-right">Sous-total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${details}">
                                <tr class="border-b border-slate-100 transition hover:bg-slate-50/60">
                                    <td class="px-4 py-4 font-medium text-slate-900"><c:out value="${detail.nomPlat}"/></td>
                                    <td class="px-4 py-4 font-mono text-right text-slate-600"><c:out value="${detail.prixUnitaireTexte}"/></td>
                                    <td class="px-4 py-4 text-center text-slate-700"><c:out value="${detail.quantite}"/></td>
                                    <td class="px-4 py-4 font-mono font-bold text-right text-slate-900"><c:out value="${detail.sousTotalTexte}"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="mt-4 flex items-center justify-between rounded-xl bg-[#F0F7F5] px-4 py-3">
                    <span class="text-sm font-medium text-slate-600">Total de la commande</span>
                    <span class="font-mono text-lg font-bold text-teal-700"><c:out value="${commande.totalTexte}"/></span>
                </div>
            </div>

            <div class="rounded-2xl border border-slate-100/80 bg-white p-6">
                <h2 class="text-base font-semibold text-slate-900">Paiement</h2>
                <c:choose>
                    <c:when test="${not empty paiement}">
                        <div class="mt-4 flex flex-wrap items-center justify-between gap-3">
                            <div class="space-y-1">
                                <span class="text-xs font-medium text-slate-400">Reference Mobile Money</span>
                                <p class="text-sm font-medium text-slate-900"><c:out value="${paiement.reference}"/></p>
                            </div>
                            <div class="space-y-1">
                                <span class="text-xs font-medium text-slate-400">Montant paye</span>
                                <p class="font-mono text-sm font-bold text-emerald-700"><c:out value="${paiement.montantTexte}"/></p>
                            </div>
                            <a href="${pageContext.request.contextPath}/factures?id=${commande.id}"
                               class="rounded-xl bg-slate-100 px-4 py-2 text-sm font-medium text-slate-600 transition-colors hover:bg-slate-200">
                                Afficher le recu de facturation
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="mt-4 text-sm text-slate-400">Paiement non encore recu.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <aside class="space-y-6">
            <div class="rounded-2xl border border-slate-100/80 bg-white p-6">
                <h2 class="text-base font-semibold text-slate-900">Client</h2>
                <div class="mt-4 space-y-3 text-sm">
                    <div>
                        <span class="text-xs font-medium text-slate-400">Nom</span>
                        <p class="mt-0.5 font-medium text-slate-900"><c:out value="${commande.nomClient}"/></p>
                    </div>
                    <div>
                        <span class="text-xs font-medium text-slate-400">Telephone</span>
                        <p class="mt-0.5 font-medium text-slate-900"><c:out value="${commande.telephoneClient}"/></p>
                    </div>
                    <div>
                        <span class="text-xs font-medium text-slate-400">Adresse de livraison</span>
                        <p class="mt-0.5 text-slate-700"><c:out value="${commande.adresseLivraison}"/></p>
                    </div>
                    <div>
                        <span class="text-xs font-medium text-slate-400">Source</span>
                        <div class="mt-1">
                            <c:set var="badgeSource" value="${commande.source}"/>
                            <%@ include file="/WEB-INF/views/includes/source-badge.jsp" %>
                        </div>
                    </div>
                </div>
            </div>

            <div class="rounded-2xl border border-slate-100/80 bg-white p-6">
                <h2 class="text-base font-semibold text-slate-900">Statut et livreur</h2>
                <div class="mt-4 space-y-3 text-sm">
                    <div class="flex items-center justify-between">
                        <span class="text-xs font-medium text-slate-400">Statut</span>
                        <c:set var="badgeStatut" value="${commande.statut}"/>
                        <%@ include file="/WEB-INF/views/includes/statut-badge.jsp" %>
                    </div>
                    <div>
                        <span class="text-xs font-medium text-slate-400">Livreur assigne</span>
                        <c:choose>
                            <c:when test="${not empty commande.nomLivreur}">
                                <p class="mt-0.5 font-medium text-slate-900"><c:out value="${commande.nomLivreur}"/></p>
                            </c:when>
                            <c:otherwise>
                                <p class="mt-0.5 text-sm text-slate-400">Non assigne</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </aside>
    </div>
</c:if>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>