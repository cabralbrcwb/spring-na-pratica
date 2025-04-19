<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%
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
    <link rel="stylesheet" href="<c:url value='/assets/public/css/bootstrap.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/assets/public/css/fontawesome-all.min.css'/>" />
    <style>
        #successNotification, #notification {
            z-index: 10000;
            width: 100%;
            display: none;
            border-radius: 0;
            margin: 0;
            position: fixed;
            top: 0;
            left: 0;
        }
    </style>
</head>
<body>
    <!-- Barras de notificação -->
    <div id="successNotification" class="alert alert-success text-center fixed-top" role="alert">
        <strong><spring:message code="label.success" text="Sucesso"/>:</strong> <span id="successMessage"></span>
    </div>

    <div id="notification" class="alert alert-danger text-center fixed-top" role="alert">
        <strong><spring:message code="label.error" text="Erro"/>:</strong> <span id="notificationMessage"></span>
    </div>

    <div class="container mt-4">
        <!-- Cabeçalho com botão de logout e nome do usuário -->
        <div class="row align-items-center mb-4">
            <div class="col-auto d-flex align-items-center">
                <form action="<c:url value='/logout'/>" method="post" class="me-3">
                    <button type="submit" class="btn"
                            style="background-color: #999; color: #fff; font-size: 1.5rem;"
                            title="Sair">
                        <i class="fas fa-power-off"></i>
                    </button>
                </form>

                <span style="font-size: 1.1rem;">
                    Olá, <strong><c:out value="${loggedUserName}" /></strong>
                </span>
            </div>
        </div>

        <h1 class="mb-4">Lista de Usuários</h1>

        <!-- Filtro de pesquisa -->
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
            <c:if test="${not users.first}">
                <a class="btn btn-outline-secondary"
                   href="?page=${users.number - 1}&size=${users.size}&nome=${param.nome}">
                    &laquo; Anterior
                </a>
            </c:if>

            <span class="align-self-center">
                Página ${users.number + 1} de ${users.totalPages}
            </span>

            <c:if test="${not users.last}">
                <a class="btn btn-outline-secondary"
                   href="?page=${users.number + 1}&size=${users.size}&nome=${param.nome}">
                    Próxima &raquo;
                </a>
            </c:if>
        </div>
    </div>

    <script src="<c:url value='/assets/public/js/jquery-3.5.0.min.js'/>"></script>
    <script src="<c:url value='/assets/public/js/bootstrap.min.js'/>"></script>

    <script>
        $(document).ready(function() {
            // Processamento das mensagens flash
            var successMessage = "${successMessage}";
            var errorMessage = "${errorMessage}";

            if (successMessage && successMessage.trim() !== "") {
                $('#successMessage').text(successMessage);
                $('#successNotification').fadeIn(500);
                setTimeout(function() {
                    $('#successNotification').fadeOut(500);
                }, 5000);
            }

            if (errorMessage && errorMessage.trim() !== "") {
                $('#notificationMessage').text(errorMessage);
                $('#notification').fadeIn(500);
                setTimeout(function() {
                    $('#notification').fadeOut(500);
                }, 5000);
            }
        });
    </script>
</body>
</html>