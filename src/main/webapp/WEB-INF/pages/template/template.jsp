<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!doctype html>
<html lang="en" class="theme-fs-md">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Vm Tec - Cadastro de Usuário</title>

    <link rel="shortcut icon" href="<c:url value='/assets/images/favicon.ico'/>" />
    <link rel="stylesheet" href="<c:url value='/assets/css/libs.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/socialv.css?v=5.0.2'/>">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500&display=swap" rel="stylesheet">
    <!-- flatpickr css -->
    <link rel="stylesheet" href="<c:url value='/assets/vendor/flatpickr/dist/flatpickr.min.css'/>" />
    <!-- Sweetlaert2 css -->
    <link rel="stylesheet" href="<c:url value='/assets/vendor/sweetalert2/dist/sweetalert2.min.css'/>" />
    <!-- vanillajs css -->
    <link rel="stylesheet" href="<c:url value='/assets/vendor/vanillajs-datepicker/dist/css/datepicker.min.css'/>">
    <!-- color customizer css -->
    <link rel="stylesheet" href="<c:url value='/assets/css/customizer.css'/>">
</head>

<body class="iq-bg-primary">
    <!-- Wrapper Start -->
    <div class="wrapper">
        <tiles:insertAttribute name="body" />
    </div>
    <!-- Wrapper END -->

    <!-- Incluir a biblioteca jQuery -->
    <script src="<c:url value='/assets/js/libs.min.js'/>"></script>
    <script src="<c:url value='/assets/js/jquery-ui.min.js'/>"></script>
    <script src="<c:url value='/assets/vendor/lodash/lodash.min.js'/>"></script>
    <script src="<c:url value='/assets/js/setting/utility.js'/>"></script>
    <script src="<c:url value='/assets/js/setting/setting.js'/>"></script>
    <script src="<c:url value='/assets/js/setting/setting-init.js'/>" defer></script>
    <script src="<c:url value='/assets/js/slider.js'/>"></script>
    <script src="<c:url value='/assets/js/masonry.pkgd.min.js'/>"></script>
    <script src="<c:url value='/assets/js/enchanter.js'/>"></script>
    <script src="<c:url value='/assets/vendor/sweetalert2/dist/sweetalert2.min.js'/>" async></script>
    <script src="<c:url value='/assets/js/sweet-alert.js'/>" defer></script>
    <script src="<c:url value='/assets/js/customizer.js'/>"></script>
    <script src="<c:url value='/assets/js/charts/weather-chart.js'/>"></script>
    <script src="<c:url value='/assets/js/app.js'/>"></script>
    <script src="<c:url value='/assets/vendor/flatpickr/dist/flatpickr.min.js'/>"></script>
    <script src="<c:url value='/assets/js/fslightbox.js'/>" defer></script>
    <script src="<c:url value='/assets/vendor/vanillajs-datepicker/dist/js/datepicker.min.js'/>"></script>
    <script src="<c:url value='/assets/js/lottie.js'/>"></script>
    <script src="<c:url value='/assets/js/select2.js'/>"></script>
    <script src="<c:url value='/assets/js/show-notification.js'/>"></script>
</body>
</html>