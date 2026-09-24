<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="titrePage" value="Facture"/>
<%@ include file="/WEB-INF/views/includes/entete.jsp" %>

<div class="mx-auto max-w-3xl">
    <div class="zone-facture rounded-2xl border border-slate-100 bg-white p-8 print:rounded-none print:border-0 print:bg-white print:p-0 print:shadow-none print:text-black">
        <div class="flex items-start justify-between border-b-2 border-teal-500 pb-6">
            <div>
                <div class="flex items-center gap-2">
                    <span class="text-2xl font-bold text-slate-900">Resto<span class="text-teal-600">Liv</span></span>
                </div>
                <p class="mt-1 text-sm text-slate-400">Gestion des commandes et livraisons</p>
            </div>
            <div class="text-right">
                <p class="text-xs font-medium uppercase tracking-wide text-slate-400">Numero</p>
                <p class="mt-0.5 font-mono text-base font-bold text-slate-900"><c:out value="${facture.numeroFacture}"/></p>
                <p class="mt-1 text-xs text-slate-400">Date : <c:out value="${facture.dateFactureTexte}"/></p>
            </div>
        </div>

        <c:if test="${empty commande}">
            <div class="mt-6 rounded-lg border border-rose-100 bg-rose-50 px-4 py-3 text-sm text-rose-700">Facture introuvable.</div>
        </c:if>

        <c:if test="${not empty commande}">
            <div class="mt-6 flex items-center justify-between">
                <h2 class="font-mono text-sm font-semibold text-slate-500"><c:out value="${commande.reference}"/></h2>
                <c:set var="badgeStatut" value="${commande.statut}"/>
                <%@ include file="/WEB-INF/views/includes/statut-badge.jsp" %>
            </div>

            <dl class="mt-5 grid gap-x-6 gap-y-4 sm:grid-cols-2">
                <div>
                    <dt class="text-xs font-medium uppercase tracking-wide text-slate-400">Client</dt>
                    <dd class="mt-1 text-sm font-medium text-slate-900"><c:out value="${commande.nomClient}"/></dd>
                </div>
                <div>
                    <dt class="text-xs font-medium uppercase tracking-wide text-slate-400">Telephone</dt>
                    <dd class="mt-1 text-sm text-slate-700"><c:out value="${commande.telephoneClient}"/></dd>
                </div>
                <div>
                    <dt class="text-xs font-medium uppercase tracking-wide text-slate-400">Adresse de livraison</dt>
                    <dd class="mt-1 text-sm text-slate-700"><c:out value="${commande.adresseLivraison}"/></dd>
                </div>
                <div>
                    <dt class="text-xs font-medium uppercase tracking-wide text-slate-400">Source</dt>
                    <dd class="mt-1 text-sm text-slate-700">
                        <c:choose>
                            <c:when test="${commande.source == 'APPEL'}">Par appel</c:when>
                            <c:otherwise>Par WhatsApp</c:otherwise>
                        </c:choose>
                    </dd>
                </div>
                <div>
                    <dt class="text-xs font-medium uppercase tracking-wide text-slate-400">Livreur</dt>
                    <dd class="mt-1 text-sm text-slate-700">
                        <c:choose>
                            <c:when test="${not empty commande.nomLivreur}"><c:out value="${commande.nomLivreur}"/></c:when>
                            <c:otherwise>Non assigne</c:otherwise>
                        </c:choose>
                    </dd>
                </div>
            </dl>

            <h3 class="mt-8 text-xs font-medium uppercase tracking-wide text-slate-400">Details de la commande</h3>
            <div class="mt-2 overflow-x-auto rounded-xl border border-slate-100 print:border-0">
                <table class="w-full text-sm">
                    <thead>
                        <tr class="border-b border-slate-100 bg-slate-50/50 text-left text-[11px] font-semibold uppercase tracking-wider text-slate-400">
                            <th class="px-4 py-3">Plat</th>
                            <th class="px-4 py-3">Quantite</th>
                            <th class="px-4 py-3 text-right">Prix unitaire</th>
                            <th class="px-4 py-3 text-right">Sous-total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="detail" items="${details}">
                            <tr class="border-b border-slate-100">
                                <td class="px-4 py-3 font-medium text-slate-900"><c:out value="${detail.nomPlat}"/></td>
                                <td class="px-4 py-3 text-slate-600">x <c:out value="${detail.quantite}"/></td>
                                <td class="px-4 py-3 font-mono text-right text-slate-600"><c:out value="${detail.prixUnitaireTexte}"/></td>
                                <td class="px-4 py-3 font-mono font-semibold text-right text-slate-900"><c:out value="${detail.sousTotalTexte}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="mt-6 flex justify-end">
                <div class="w-64 rounded-xl bg-slate-50 p-4 print:border print:border-slate-200">
                    <div class="flex items-center justify-between py-1">
                        <span class="text-sm text-slate-500">Paiement</span>
                        <span class="text-sm font-medium text-slate-900">Mobile Money</span>
                    </div>
                    <div class="flex items-center justify-between py-1">
                        <span class="text-sm text-slate-500">Reference</span>
                        <span class="font-mono text-sm font-medium text-slate-900"><c:out value="${paiement.reference}"/></span>
                    </div>
                    <div class="mt-2 flex items-center justify-between border-t border-slate-200 pt-3">
                        <span class="text-base font-semibold text-slate-900">Total</span>
                        <span class="font-mono text-lg font-bold text-teal-600 print:text-black"><c:out value="${facture.montantTotalTexte}"/></span>
                    </div>
                </div>
            </div>

            <p class="mt-8 text-center text-sm text-slate-400">Merci de votre confiance et bon appetit.</p>
        </c:if>
    </div>

    <div class="mt-6 flex flex-wrap items-center justify-center gap-3 print:hidden">
        <a href="${pageContext.request.contextPath}/factures/pdf?id=${commande.id}"
           class="inline-flex items-center gap-2 rounded-xl bg-slate-100 px-6 py-2.5 text-sm font-medium text-slate-600 transition-colors hover:bg-slate-200">
            <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                <path d="M7 10l5 5 5-5"/>
                <path d="M12 15V3"/>
            </svg>
            Telecharger le PDF
        </a>
        <button type="button" onclick="window.print()"
                class="inline-flex items-center gap-2 rounded-xl bg-teal-600 px-6 py-2.5 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800">
            <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M6 9V2h12v7"/>
                <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/>
                <path d="M6 14h12v8H6z"/>
            </svg>
            Imprimer la facture
        </button>
        <a href="javascript:history.back()"
           class="rounded-xl bg-slate-100 px-6 py-2.5 text-sm font-medium text-slate-600 transition-colors hover:bg-slate-200">Retour</a>
    </div>
</div>

<%@ include file="/WEB-INF/views/includes/pied.jsp" %>