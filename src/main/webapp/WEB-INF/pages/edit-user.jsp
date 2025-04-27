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
<html lang="pt-BR">
<head>
    <meta charset="UTF-8"/>
    <title>Edição de Usuário</title>
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

        <h1 class="mb-4">Editar Usuário</h1>

        <!-- Formulário -->
        <form id="userEditForm" action="<c:url value='/users/edit?id=${userForm.userID}'/>" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Nome</label>
                <input type="text" id="name" name="name" class="form-control"
                       value="${userForm.name}" required />
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">E-mail</label>
                <input type="email" id="email" name="email" class="form-control"
                       value="${userForm.email}" required />
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Nova Senha (deixe em branco para manter a senha atual)</label>
                <input type="password" id="password" name="password" class="form-control"/>
                <small class="form-text text-muted">Se preenchido, deve ter pelo menos 6 caracteres.</small>
            </div>

            <button type="submit" class="btn btn-primary" id="submitButton" style="background-color:#01cc66; border-color:#01cc66;">Salvar</button>
            <a href="<c:url value='/users'/>" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>

    <script src="<c:url value='/assets/public/js/jquery-3.5.0.min.js'/>"></script>
    <script src="<c:url value='/assets/public/js/bootstrap.min.js'/>"></script>
    <script>
        $(document).ready(function() {

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

            $('#userEditForm').submit(function(e) {

                if ($('#name').val().trim() === '') {
                    e.preventDefault();
                    $('#notificationMessage').text("O campo nome não pode estar vazio.");
                    $('#notification').fadeIn(500);
                    setTimeout(function() { $('#notification').fadeOut(500); }, 5000);
                    return false;
                }

                const email = $('#email').val().trim();
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (email === '') {
                    e.preventDefault();
                    $('#notificationMessage').text("O campo e-mail não pode estar vazio.");
                    $('#notification').fadeIn(500);
                    setTimeout(function() { $('#notification').fadeOut(500); }, 5000);
                    return false;
                } else if (!emailRegex.test(email)) {
                    e.preventDefault();
                    $('#notificationMessage').text("Formato de e-mail inválido.");
                    $('#notification').fadeIn(500);
                    setTimeout(function() { $('#notification').fadeOut(500); }, 5000);
                    return false;
                }

                const password = $('#password').val();
                if (password !== '' && password.length < 6) {
                    e.preventDefault();
                    $('#notificationMessage').text("A senha deve ter pelo menos 6 caracteres.");
                    $('#notification').fadeIn(500);
                    setTimeout(function() { $('#notification').fadeOut(500); }, 5000);
                    return false;
                }

            });
        });
    </script>
</body>
</html>