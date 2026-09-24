<c:choose>
    <c:when test="${badgeSource == 'APPEL'}">
        <span class="inline-flex items-center rounded-full border border-sky-100 bg-sky-50 px-2.5 py-0.5 text-xs font-medium text-sky-700">Par appel</span>
    </c:when>
    <c:otherwise>
        <span class="inline-flex items-center rounded-full border border-teal-100 bg-teal-50 px-2.5 py-0.5 text-xs font-medium text-teal-700">WhatsApp</span>
    </c:otherwise>
</c:choose>