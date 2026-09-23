// Calcule le montant total de la nouvelle commande.
(function () {
    function recalculerTotal() {
        var cases = document.querySelectorAll('.case-plat');
        var total = 0;
        cases.forEach(function (casePlat) {
            var prix = parseFloat(casePlat.dataset.prix) || 0;
            var champQuantite = document.querySelector('input[name="quantite_' + casePlat.value + '"]');
            var quantite = 0;
            if (champQuantite) {
                quantite = parseInt(champQuantite.value, 10) || 0;
            }
            if (casePlat.checked && quantite > 0) {
                total += prix * quantite;
            }
        });
        document.getElementById('montantTotal').textContent = total.toFixed(2) + ' Ar';
    }

    document.querySelectorAll('.case-plat, .quantite-plat').forEach(function (element) {
        element.addEventListener('change', recalculerTotal);
        element.addEventListener('input', recalculerTotal);
    });
})();