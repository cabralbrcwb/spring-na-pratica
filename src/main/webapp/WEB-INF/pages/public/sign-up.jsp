<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8"/>
    <title>Edição de Usuário</title>
    <link rel="stylesheet" href="<c:url value='/assets/public/css/bootstrap.min.css'/>" />

    <!-- Estilos adicionais para notificação fixa -->
    <style>
      #notification, #successNotification {
        z-index: 10000;
        width: 100%;
        display: none;
        border-radius: 0; /* Para ficar como barra */
        margin: 0;       /* Retirar margens extras */
      }
    </style>
</head>

<body>
    <!-- Barra de Notificação de Sucesso -->
    <div id="successNotification" class="alert alert-success text-center fixed-top" role="alert">
        <strong>Sucesso:</strong> <span id="successMessage">Dados atualizados com sucesso!</span>
    </div>

    <!-- Barra de Notificação de Erro -->
    <div id="notification" class="alert alert-danger text-center fixed-top" role="alert">
        <strong>Erro:</strong> <span id="notificationMessage"></span>
    </div>

    <div class="container mt-5">
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
                <label for="password" class="form-label">Nova Senha (opcional)</label>
                <input type="password" id="password" name="password" class="form-control"/>
            </div>

            <button type="submit" class="btn btn-primary" id="submitButton">Salvar</button>
            <a href="<c:url value='/users'/>" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>

    <script src="<c:url value='/assets/public/js/jquery-3.5.0.min.js'/>"></script>
    <script src="<c:url value='/assets/public/js/bootstrap.min.js'/>"></script>
    <script>
        $(document).ready(function() {
            // Verifica se há mensagens do servidor ao carregar a página
            <c:if test="${not empty successMessage}">
                $('#successMessage').text("${successMessage}");
                $('#successNotification').fadeIn(500);
                setTimeout(function() { $('#successNotification').fadeOut(500); }, 5000);
            </c:if>

            <c:if test="${not empty errorMessage}">
                $('#notificationMessage').text("${errorMessage}");
                $('#notification').fadeIn(500);
                setTimeout(function() { $('#notification').fadeOut(500); }, 5000);
            </c:if>

            // Validação do formulário
            $('#userEditForm').on('submit', function(e) {
                e.preventDefault();

                // Valida o nome
                const name = $('#name').val().trim();
                if (!name) {
                    showErrorNotification('O campo nome não pode estar vazio.');
                    return false;
                }

                // Valida o e-mail
                const email = $('#email').val().trim();
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!email) {
                    showErrorNotification('O campo e-mail não pode estar vazio.');
                    return false;
                }
                if (!emailRegex.test(email)) {
                    showErrorNotification('Formato de e-mail inválido.');
                    return false;
                }

                // Valida a senha (se preenchida)
                const password = $('#password').val();
                if (password && password.length < 6) {
                    showErrorNotification('A senha deve ter pelo menos 6 caracteres.');
                    return false;
                }

                // Envia o formulário via AJAX
                $.ajax({
                    type: 'POST',
                    url: $(this).attr('action'),
                    data: $(this).serialize(),
                    success: function(response) {
                        $('#successMessage').text(response);
                        $('#successNotification').fadeIn(500);
                        setTimeout(function() {
                            $('#successNotification').fadeOut(500);
                        }, 5000);
                    },
                    error: function(xhr) {
                        $('#notificationMessage').text(xhr.responseText);
                        $('#notification').fadeIn(500);
                        setTimeout(function() {
                            $('#notification').fadeOut(500);
                        }, 5000);
                    }
                });
            });

            // Função para mostrar notificação de erro
            function showErrorNotification(message) {
                $('#notificationMessage').text(message);
                $('#notification').fadeIn(500);
                setTimeout(function() {
                    $('#notification').fadeOut(500);
                }, 5000);
            }
        });
    </script>
</body>
</html>