<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><c:out value="${titrePage}"/> - RestoLiv</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>
    <body class="min-h-screen bg-[#E8F3F1] text-slate-900 antialiased">
        <div class="flex min-h-screen">
            <aside class="sticky top-0 hidden h-screen w-64 shrink-0 flex-col border-r border-slate-100 bg-white print:hidden lg:flex">
                <div class="flex h-20 items-center gap-2.5 border-b border-slate-100 px-6">
                    <svg class="h-9 w-9 text-teal-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M4 15h16M4 19h16"/>
                        <path d="M6 15V9a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v6"/>
                        <circle cx="9" cy="9" r="1" fill="currentColor" stroke="none"/>
                        <circle cx="15" cy="9" r="1" fill="currentColor" stroke="none"/>
                    </svg>
                    <span class="text-xl font-bold tracking-tight text-slate-900">Resto<span class="text-teal-600">Liv</span></span>
                </div>

                <nav class="flex-1 space-y-6 overflow-y-auto px-4 py-6">
                    <div>
                        <p class="mb-2 px-3 text-[10px] font-bold uppercase tracking-wider text-slate-400">Navigation principale</p>
                        <div class="space-y-1">
                            <a href="${pageContext.request.contextPath}/dashboard"
                               class="flex items-center gap-2.5 rounded-lg px-3 py-2 text-sm font-medium transition-colors ${pageContext.request.requestURI.contains('/dashboard') ? 'bg-[#F0F2FE] text-slate-900 font-semibold' : 'text-slate-500 hover:bg-slate-50 hover:text-slate-900'}">
                                <span class="flex items-center gap-2.5">
                                    <svg class="h-4 w-4 text-teal-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/>
                                        <rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/>
                                    </svg>
                                    Dashboard
                                </span>
                            </a>
                            <a href="${pageContext.request.contextPath}/menu"
                               class="flex items-center gap-2.5 rounded-lg px-3 py-2 text-sm font-medium transition-colors ${pageContext.request.requestURI.contains('/menu') ? 'bg-[#F0F2FE] text-slate-900 font-semibold' : 'text-slate-500 hover:bg-slate-50 hover:text-slate-900'}">
                                <span class="flex items-center gap-2.5">
                                    <svg class="h-4 w-4 text-teal-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
                                        <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
                                    </svg>
                                    Menu
                                </span>
                            </a>
                            <a href="${pageContext.request.contextPath}/livreurs"
                               class="flex items-center gap-2.5 rounded-lg px-3 py-2 text-sm font-medium transition-colors ${pageContext.request.requestURI.contains('/livreurs') ? 'bg-[#F0F2FE] text-slate-900 font-semibold' : 'text-slate-500 hover:bg-slate-50 hover:text-slate-900'}">
                                <span class="flex items-center gap-2.5">
                                    <svg class="h-4 w-4 text-teal-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M1 3h15v13H1z"/><path d="M16 8h4l3 3v5h-7V8z"/>
                                        <circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/>
                                    </svg>
                                    Livreurs
                                </span>
                            </a>
                            <a href="${pageContext.request.contextPath}/commandes"
                               class="flex items-center gap-2.5 rounded-lg px-3 py-2 text-sm font-medium transition-colors ${pageContext.request.requestURI.contains('/commandes') && !pageContext.request.requestURI.contains('/nouvelle') ? 'bg-[#F0F2FE] text-slate-900 font-semibold' : 'text-slate-500 hover:bg-slate-50 hover:text-slate-900'}">
                                <span class="flex items-center gap-2.5">
                                    <svg class="h-4 w-4 text-teal-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                                        <path d="M14 2v6h6"/><path d="M9 13h6M9 17h4"/>
                                    </svg>
                                    Commandes
                                </span>
                            </a>
                        </div>
                    </div>

                    <div>
                        <p class="mb-2 px-3 text-[10px] font-bold uppercase tracking-wider text-slate-400">Raccourcis</p>
                        <div class="space-y-1">
                            <a href="${pageContext.request.contextPath}/commandes/nouvelle"
                               class="flex items-center gap-2.5 rounded-lg px-3 py-2 text-sm font-medium transition-colors ${pageContext.request.requestURI.contains('/commandes/nouvelle') ? 'bg-[#F0F2FE] text-slate-900 font-semibold' : 'text-slate-500 hover:bg-slate-50 hover:text-slate-900'}">
                                <span class="flex items-center gap-2.5">
                                    <svg class="h-4 w-4 text-teal-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M12 5v14M5 12h14"/>
                                    </svg>
                                    Nouvelle commande
                                </span>
                            </a>
                            <a href="${pageContext.request.contextPath}/menu/ajouter"
                               class="flex items-center gap-2.5 rounded-lg px-3 py-2 text-sm font-medium transition-colors ${pageContext.request.requestURI.contains('/menu/ajouter') ? 'bg-[#F0F2FE] text-slate-900 font-semibold' : 'text-slate-500 hover:bg-slate-50 hover:text-slate-900'}">
                                <span class="flex items-center gap-2.5">
                                    <svg class="h-4 w-4 text-teal-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
                                    </svg>
                                    Ajouter un plat
                                </span>
                            </a>
                        </div>
                    </div>
                </nav>

                <div class="border-t border-slate-100 p-4">
                    <form method="post" action="${pageContext.request.contextPath}/logout" class="m-0">
                        <button type="submit"
                                class="flex w-full items-center gap-2.5 rounded-lg px-3 py-2 text-sm font-medium text-slate-500 transition-colors hover:bg-rose-50 hover:text-rose-600"
                                title="Deconnexion">
                            <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                                <path d="M16 17l5-5-5-5"/>
                                <path d="M21 12H9"/>
                            </svg>
                            Quitter
                        </button>
                    </form>
                </div>
            </aside>

            <div class="flex min-w-0 flex-1 flex-col">
                <header class="border-b border-slate-100 bg-white print:hidden lg:hidden">
                    <div class="flex h-14 items-center justify-between px-4">
                        <a href="${pageContext.request.contextPath}/dashboard" class="flex items-center gap-2">
                            <svg class="h-7 w-7 text-teal-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M4 15h16M4 19h16"/>
                                <path d="M6 15V9a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v6"/>
                                <circle cx="9" cy="9" r="1" fill="currentColor" stroke="none"/>
                                <circle cx="15" cy="9" r="1" fill="currentColor" stroke="none"/>
                            </svg>
                            <span class="text-lg font-bold tracking-tight text-slate-900">Resto<span class="text-teal-600">Liv</span></span>
                        </a>
                        <form method="post" action="${pageContext.request.contextPath}/logout" class="m-0">
                            <button type="submit" class="inline-flex items-center gap-1.5 rounded-lg px-2.5 py-1.5 text-sm font-medium text-slate-500 hover:bg-rose-50 hover:text-rose-600"
                                    title="Deconnexion">
                                <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                                    <path d="M16 17l5-5-5-5"/>
                                    <path d="M21 12H9"/>
                                </svg>
                                Quitter
                            </button>
                        </form>
                    </div>
                    <nav class="flex gap-1 overflow-x-auto px-3 pb-2">
                        <a href="${pageContext.request.contextPath}/dashboard"
                           class="shrink-0 rounded-full px-3 py-1.5 text-sm font-medium ${pageContext.request.requestURI.contains('/dashboard') ? 'bg-teal-50 text-teal-700 font-semibold' : 'text-slate-500'}">Dashboard</a>
                        <a href="${pageContext.request.contextPath}/menu"
                           class="shrink-0 rounded-full px-3 py-1.5 text-sm font-medium ${pageContext.request.requestURI.contains('/menu') ? 'bg-teal-50 text-teal-700 font-semibold' : 'text-slate-500'}">Menu</a>
                        <a href="${pageContext.request.contextPath}/livreurs"
                           class="shrink-0 rounded-full px-3 py-1.5 text-sm font-medium ${pageContext.request.requestURI.contains('/livreurs') ? 'bg-teal-50 text-teal-700 font-semibold' : 'text-slate-500'}">Livreurs</a>
                        <a href="${pageContext.request.contextPath}/commandes"
                           class="shrink-0 rounded-full px-3 py-1.5 text-sm font-medium ${pageContext.request.requestURI.contains('/commandes') && !pageContext.request.requestURI.contains('/nouvelle') ? 'bg-teal-50 text-teal-700 font-semibold' : 'text-slate-500'}">Commandes</a>
                        <a href="${pageContext.request.contextPath}/commandes/nouvelle"
                           class="shrink-0 rounded-full bg-teal-600 px-3 py-1.5 text-sm font-medium text-white">+ Nouvelle</a>
                    </nav>
                </header>

                <header class="sticky top-0 z-10 hidden items-center gap-4 border-b border-slate-100 bg-white/80 px-8 py-3 backdrop-blur print:hidden lg:flex">
                    <nav class="flex min-w-0 items-center gap-1.5 text-sm text-slate-400">
                        <a href="${pageContext.request.contextPath}/dashboard" class="transition-colors hover:text-slate-700">RestoLiv</a>
                        <span>/</span>
                        <span class="truncate font-medium text-slate-700"><c:out value="${titrePage}"/></span>
                    </nav>
                    <div class="flex flex-1 justify-center">
                        <input type="search" placeholder="Rechercher..."
                               class="w-full max-w-md rounded-xl border border-slate-200 bg-slate-50 px-4 py-2 text-sm text-slate-900 placeholder-slate-400 transition-all focus:border-teal-500 focus:bg-white focus:outline-none focus:ring-4 focus:ring-teal-500/10">
                    </div>
                    <a href="${pageContext.request.contextPath}/commandes/nouvelle"
                       class="inline-flex shrink-0 items-center gap-2 rounded-xl bg-teal-600 px-4 py-2 text-sm font-medium text-white transition-colors hover:bg-teal-700 active:bg-teal-800">
                        <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 5v14M5 12h14"/></svg>
                        Nouvelle commande
                    </a>
                </header>

                <main class="flex-1 p-4 sm:p-6 lg:p-8">
                    <div class="mx-auto w-full max-w-7xl rounded-3xl border border-slate-100/60 bg-white p-5 shadow-xl shadow-slate-200/50 sm:p-7 print:rounded-none print:border-0 print:bg-white print:p-0 print:shadow-none">