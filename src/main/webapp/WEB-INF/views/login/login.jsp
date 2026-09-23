<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Connexion - RestoLiv</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>
    <body class="page-login">
        <div class="boite-login">
            <h1>RestoLiv</h1>
            <p class="sous-titre">Gestion des commandes et livraisons</p>

            <c:if test="${not empty erreur}">
                <div class="alerte alerte-erreur">${erreur}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/login">
                <label for="username">Nom d'utilisateur</label>
                <input type="text" id="username" name="username" required>

                <label for="motDePasse">Mot de passe</label>
                <input type="password" id="motDePasse" name="motDePasse" required>

                <button type="submit" class="bouton">Se connecter</button>
            </form>
        </div>
    </body>
</html>