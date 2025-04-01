<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pt-BR" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8"/>
    <title>Lista de Usuários</title>
    <link rel="stylesheet" href="<c:url value='/assets/public/css/bootstrap.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/assets/css/list-grid.css'/>" />
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4">Lista de Usuários</h1>

    <!-- Filtro por nome -->
    <form class="row g-3 mb-3" method="get" action="/users">
        <div class="col-auto">
            <input type="text" class="form-control" name="nome" placeholder="Filtrar por nome"
                   value="${param.nome}" />
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary" style="background-color:#01cc66">Buscar</button>
        </div>
    </form>

    <!-- Tabela de usuários -->

    <table class="table table-striped table-bordered align-middle">
        <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>E-mail</th>
                <th>Ações</th> <!-- Nova coluna -->
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty users.content}">
                <tr>
                    <td colspan="4" class="text-center">Nenhum usuário encontrado</td>
                </tr>
            </c:if>

            <c:forEach var="user" items="${users.content}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.name}</td>
                    <td>${user.email}</td>
                    <td>
                        <!-- Botão/Link para editar -->
                        <a class="btn btn-warning btn-sm"
                           href="<c:url value='/users/edit?id=${user.id}'/>">
                            Editar
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

        <!-- Exibe página atual e total de páginas (ex: "Página 1 de 5") -->
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

<script src="<c:url value='/assets/public/js/bootstrap.min.js'/>"></script>
</body>
</html>
