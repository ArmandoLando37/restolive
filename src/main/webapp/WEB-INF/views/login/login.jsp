<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Connexion - RestoLiv</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>
    <body class="flex min-h-screen items-center justify-center bg-[#E8F3F1] px-4">
        <div class="w-full max-w-md">
            <div class="mb-6 flex flex-col items-center text-slate-900">
                <svg class="h-12 w-12 text-teal-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 15h16M4 19h16"/>
                    <path d="M6 15V9a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v6"/>
                    <circle cx="9" cy="9" r="1" fill="currentColor" stroke="none"/>
                    <circle cx="15" cy="9" r="1" fill="currentColor" stroke="none"/>
                </svg>
                <span class="mt-3 text-3xl font-bold tracking-tight">Resto<span class="text-teal-600">Liv</span></span>
                <p class="mt-1.5 text-sm text-slate-400">Gestion des commandes et livraisons</p>
            </div>

            <div class="rounded-3xl border border-slate-100 bg-white p-8 shadow-2xl shadow-slate-200/50">
                <c:if test="${not empty erreur}">
                    <div class="mb-5 rounded-xl border border-rose-100 bg-rose-50 px-4 py-3 text-sm text-rose-700">${erreur}</div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/login" class="space-y-5">
                    <div>
                        <label for="username" class="mb-1.5 block text-sm font-medium text-slate-600">Nom d'utilisateur</label>
                        <input type="text" id="username" name="username" required autofocus
                               class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
                    </div>
                    <div>
                        <label for="motDePasse" class="mb-1.5 block text-sm font-medium text-slate-600">Mot de passe</label>
                        <input type="password" id="motDePasse" name="motDePasse" required
                               class="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
                    </div>
                    <button type="submit"
                            class="w-full rounded-xl bg-teal-600 px-4 py-2.5 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800 focus:outline-none focus:ring-4 focus:ring-teal-500/10">
                        Se connecter
                    </button>
                </form>
            </div>
        </div>
    </body>
</html>