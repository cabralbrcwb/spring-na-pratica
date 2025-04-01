<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8"/>
    <title>Edição de Usuário</title>
    <link rel="stylesheet" href="<c:url value='/assets/public/css/bootstrap.min.css'/>" />
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4">Editar Usuário</h1>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <!-- Formulário -->
<form action="<c:url value='/users/edit?id=${userForm.userID}'/>" method="post">
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

        <button type="submit" class="btn btn-primary">Salvar</button>
        <a href="<c:url value='/users'/>" class="btn btn-secondary">Cancelar</a>
    </form>
</div>

<script src="<c:url value='/assets/public/js/bootstrap.min.js'/>"></script>
</body>
</html>
