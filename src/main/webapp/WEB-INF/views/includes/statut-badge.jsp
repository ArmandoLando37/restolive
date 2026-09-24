<c:choose>
    <c:when test="${badgeStatut == 'RECUE'}">
        <span class="inline-flex items-center gap-1.5 rounded-full border border-blue-100 bg-blue-50 px-2.5 py-0.5 text-xs font-medium text-blue-700">
            <span class="h-1.5 w-1.5 rounded-full bg-blue-500"></span>Recue
        </span>
    </c:when>
    <c:when test="${badgeStatut == 'EN_CUISINE'}">
        <span class="inline-flex items-center gap-1.5 rounded-full border border-amber-100 bg-amber-50 px-2.5 py-0.5 text-xs font-medium text-amber-700">
            <span class="h-1.5 w-1.5 rounded-full bg-amber-500"></span>En cuisine
        </span>
    </c:when>
    <c:when test="${badgeStatut == 'EN_LIVRAISON'}">
        <span class="inline-flex items-center gap-1.5 rounded-full border border-purple-100 bg-purple-50 px-2.5 py-0.5 text-xs font-medium text-purple-700">
            <span class="h-1.5 w-1.5 rounded-full bg-purple-500"></span>En livraison
        </span>
    </c:when>
    <c:when test="${badgeStatut == 'LIVREE'}">
        <span class="inline-flex items-center gap-1.5 rounded-full border border-emerald-100 bg-emerald-50 px-2.5 py-0.5 text-xs font-medium text-emerald-700">
            <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>Livree
        </span>
    </c:when>
    <c:when test="${badgeStatut == 'RETOUR'}">
        <span class="inline-flex items-center gap-1.5 rounded-full border border-rose-100 bg-rose-50 px-2.5 py-0.5 text-xs font-medium text-rose-700">
            <span class="h-1.5 w-1.5 rounded-full bg-rose-500"></span>Retour
        </span>
    </c:when>
    <c:when test="${badgeStatut == 'LIBRE'}">
        <span class="inline-flex items-center gap-1.5 rounded-full border border-emerald-100 bg-emerald-50 px-2.5 py-0.5 text-xs font-medium text-emerald-700">
            <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>Libre
        </span>
    </c:when>
    <c:otherwise>
        <span class="inline-flex items-center gap-1.5 rounded-full border border-slate-100 bg-slate-50 px-2.5 py-0.5 text-xs font-medium text-slate-600">
            <span class="h-1.5 w-1.5 rounded-full bg-slate-400"></span><c:out value="${badgeStatut}"/>
        </span>
    </c:otherwise>
</c:choose>
