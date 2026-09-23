<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><c:out value="${titrePage}"/> - RestoLiv</title>
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