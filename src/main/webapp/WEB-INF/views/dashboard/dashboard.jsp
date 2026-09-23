<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Dashboard - RestoLiv</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>
    <body>
        <header class="entete">
            <span class="marque">RestoLiv</span>
            <nav class="navigation">
                <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/menu">Menu</a>
                <a href="${pageContext.request.contextPath}/livreurs">Livreurs</a>
                <a href="${pageContext.request.contextPath}/commandes">Commandes</a>
                <form method="post" action="${pageContext.request.contextPath}/logout" style="display:inline">
                    <button type="submit">Deconnexion</button>
                </form>
            </nav>
        </header>

        <div class="conteneur">
            <h1 class="titre-page">Dashboard</h1>

            <div class="statistiques">
                <div class="carte-stat">
                    <div class="valeur">${commandesAujourdhui}</div>
                    <div class="libelle">Commandes aujourd'hui</div>
                </div>
                <div class="carte-stat ca">
                    <div class="valeur"><fmt:formatNumber value="${chiffreAffaires}" pattern="#,##0.##"/> Ar</div>
                    <div class="libelle">Chiffre d'affaires du jour</div>
                </div>
                <div class="carte-stat livreur-libre">
                    <div class="valeur">${livreursLibre}</div>
                    <div class="libelle">Livreurs LIBRE</div>
                </div>
                <div class="carte-stat en-livraison">
                    <div class="valeur">${livreursEnLivraison}</div>
                    <div class="libelle">Livreurs EN_LIVRAISON</div>
                </div>
            </div>

            <h2 class="sous-titre-page">Commandes par statut</h2>
            <div class="statistiques">
                <div class="carte-stat">
                    <div class="valeur">${statutRecue}</div>
                    <div class="libelle">RECUE</div>
                </div>
                <div class="carte-stat en-cuisine">
                    <div class="valeur">${statutEnCuisine}</div>
                    <div class="libelle">EN_CUISINE</div>
                </div>
                <div class="carte-stat en-livraison">
                    <div class="valeur">${statutEnLivraison}</div>
                    <div class="libelle">EN_LIVRAISON</div>
                </div>
                <div class="carte-stat livree">
                    <div class="valeur">${statutLivree}</div>
                    <div class="libelle">LIVREE</div>
                </div>
                <div class="carte-stat retour">
                    <div class="valeur">${statutRetour}</div>
                    <div class="libelle">RETOUR</div>
                </div>
            </div>
        </div>
    </body>
</html>