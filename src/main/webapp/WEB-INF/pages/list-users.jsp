<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    // Exemplo: obtendo o nome do usuário logado via Principal (Spring Security)
    String loggedUserName = (request.getUserPrincipal() != null)
            ? request.getUserPrincipal().getName()
            : "Usuário";
    pageContext.setAttribute("loggedUserName", loggedUserName);
%>

<!DOCTYPE html>
<html lang="pt-BR" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8"/>
    <title>Lista de Usuários</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<c:url value='/assets/public/css/bootstrap.min.css'/>" />
    <!-- Font Awesome (para ícones) -->
    <link rel="stylesheet" href="<c:url value='/assets/public/css/fontawesome-all.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/assets/css/list-grid.css'/>" />
</head>
<body>

<div class="container mt-4">
    <!-- Linha superior: botão de logout + nome do usuário -->
    <div class="row align-items-center mb-4">
        <div class="col-auto d-flex align-items-center">
            <!-- Form de Logout (POST) -->
            <form action="<c:url value='/logout'/>" method="post" class="me-3">
                <button type="submit" class="btn"
                        style="background-color: #999; color: #fff; font-size: 1.5rem;"
                        title="Sair">
                    <i class="fas fa-power-off"></i>
                </button>
            </form>

            <!-- Nome do usuário logado -->
            <span style="font-size: 1.1rem;">
                Olá, <strong><c:out value="${loggedUserName}" /></strong>
            </span>
        </div>
    </div>

    <h1 class="mb-4">Lista de Usuários</h1>

    <!-- Filtro por nome -->
    <form class="row g-3 mb-3" method="get" action="/users">
        <div class="col-auto">
            <input type="text" class="form-control" name="nome"
                   placeholder="Filtrar por nome"
                   value="${param.nome}" />
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary" style="background-color:#01cc66; border-color:#01cc66;">
                Buscar
            </button>
        </div>
    </form>

    <!-- Tabela de usuários -->
    <table class="table table-striped table-bordered align-middle">
        <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>E-mail</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty users.content}">
                <tr>
                    <td colspan="4" class="text-center">
                        Nenhum usuário encontrado
                    </td>
                </tr>
            </c:if>

            <c:forEach var="user" items="${users.content}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.name}</td>
                    <td>${user.email}</td>
                    <td>
                        <!-- Botão de edição quadrado, cor #01cc66 -->
                        <a href="<c:url value='/users/edit?id=${user.id}'/>"
                           class="d-flex justify-content-center align-items-center text-white"
                           style="
                                width: 2.2rem;
                                height: 2.2rem;
                                background-color: #01cc66;
                                border-radius: 0.25rem;
                                text-decoration: none;
                           "
                           title="Editar">
                            <i class="fas fa-pen-square"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Controles de paginação -->
    <div class="d-flex justify-content-between">
        <!-- Botão "Anterior" -->
        <c:if test="${not users.first}">
            <a class="btn btn-outline-secondary"
               href="?page=${users.number - 1}&size=${users.size}&nome=${param.nome}">
                &laquo; Anterior
            </a>
        </c:if>

        <!-- Exibe página atual e total de páginas -->
        <span class="align-self-center">
            Página ${users.number + 1} de ${users.totalPages}
        </span>

        <!-- Botão "Próxima" -->
        <c:if test="${not users.last}">
            <a class="btn btn-outline-secondary"
               href="?page=${users.number + 1}&size=${users.size}&nome=${param.nome}">
                Próxima &raquo;
            </a>
        </c:if>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="<c:url value='/assets/public/js/bootstrap.min.js'/>"></script>
</body>
</html>
