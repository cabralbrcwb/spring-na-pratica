<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!doctype html>
<html class="no-js" lang="pt">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Vm Tec | Formulários de Login e Registro</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<c:url value='/assets/public/css/bootstrap.min.css'/>">
    <!-- Fontawesome CSS -->
    <link rel="stylesheet" href="<c:url value='/assets/public/css/fontawesome-all.min.css'/>">
    <!-- Flaticon CSS -->
    <link rel="stylesheet" href="<c:url value='/assets/public/font/flaticon.css'/>">
    <!-- Google Web Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<c:url value='/assets/public/css/style.css'/>">

    <!-- Estilos adicionais para notificação fixa -->
    <style>
      #notification, #successNotification {
        z-index: 10000;
        width: 100%;
        display: none;
        border-radius: 0; /* Para ficar como barra */
        margin: 0;       /* Retirar margens extras */
      }
      /* Para dar um pequeno espaço entre a barra e o topo se quiser:
         #notification, #successNotification { top: 0.5rem; }
       */
    </style>
</head>

<body>
    <!--[if lt IE 8]>
      <p class="browserupgrade">Você está usando um navegador <strong>desatualizado</strong>.
      Por favor, <a href="http://browsehappy.com/">atualize seu navegador</a> para melhorar sua experiência.</p>
    <![endif]-->

    <!-- Barra de Notificação de Sucesso -->
    <div id="successNotification" class="alert alert-success text-center fixed-top" role="alert">
        <strong>Sucesso:</strong> <span id="successMessage">Usuário cadastrado com sucesso! Por favor, faça o login.</span>
    </div>

    <!-- Barra de Notificação de Erro -->
    <div id="notification" class="alert alert-danger text-center fixed-top" role="alert">
        <strong>Erro:</strong> <span id="notificationMessage"></span>
    </div>

    <!-- Preloader -->
    <div id="preloader" class="preloader">
      <div class="inner">
          <div class="line1"></div>
          <div class="line2"></div>
          <div class="line3"></div>
      </div>
    </div>

    <section class="fxt-template-animation fxt-template-layout24" data-bg-image="img/figure/bg24-l.jpg">
        <!-- Video Area Start Here -->
        <div class="fxt-video-background">
            <div class="fxt-video">
                <div id="fxtVideo" data-property="{
                    videoURL:'n_30MdZ9kL8',
                    autoPlay:true,
                    mute:true,
                    loop:true,
                    startAt:0,
                    opacity:1,
                    quality:'default',
                    showControls:false,
                    optimizeDisplay:true,
                    containment:'.fxt-video-background'
                }">
                </div>
            </div>
        </div>
        <!-- Video Area End Here -->

        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-lg-3 col-12">
                    <div class="fxt-header"></div>
                </div>
                <div class="col-lg-6 col-12">
                    <div class="fxt-content">
                        <h2>Registre-se para uma nova conta</h2>
                        <div class="fxt-form">
                            <c:url value="/register" var="actionUrl" />
                            <form:form name="register" id="register"
                                       modelAttribute="userRegistrationForm"
                                       action="${actionUrl}"
                                       method="post">
                                <form:hidden path="errorMessage" id="hiddenErrorMessage" />

                                <div class="form-group">
                                    <div class="fxt-transformY-50 fxt-transition-delay-1">
                                        <input type="text" id="name" class="form-control" name="name"
                                               placeholder="Nome" required="required" autocomplete="new-password">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="fxt-transformY-50 fxt-transition-delay-1">
                                        <input type="email" id="email" class="form-control" name="email"
                                               placeholder="E-mail" required="required" autocomplete="new-password">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="fxt-transformY-50 fxt-transition-delay-2">
                                        <input id="password" type="password" class="form-control" name="password"
                                               placeholder="Senha" required="required" autocomplete="new-password">
                                        <i toggle="#password" class="fa fa-fw fa-eye toggle-password field-icon"></i>
                                    </div>
                                </div>
                                <!--
                                <div class="form-group">
                                    <div class="fxt-transformY-50 fxt-transition-delay-3">
                                        <div class="fxt-checkbox-area">
                                            <div class="checkbox">
                                                <input id="checkbox1" type="checkbox">
                                                <label for="checkbox1">Mantenha-me conectado</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                -->

                                <div class="form-group">
                                    <div class="fxt-transformY-50 fxt-transition-delay-4">
                                        <button type="submit" class="fxt-btn-fill" style="background-color:#01cc66" id="doRegister">
                                            Cadastrar
                                        </button>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                        <div class="fxt-footer">
                            <div class="fxt-transformY-50 fxt-transition-delay-9">
                                <p>Já possui uma conta?
                                    <a href="<c:url value='/login'/>" class="switcher-text2 inline-text">
                                        Entrar
                                    </a>
                                </p>
                            </div>
                        </div>
                    </div> <!-- /fxt-content -->
                </div> <!-- /col -->
            </div> <!-- /row -->
        </div> <!-- /container -->
    </section>
    <spring:message code="message.registration.fillAllFields" var="fillAllFieldsMsg"/>
    <spring:message code="message.registration.invalidEmailFormat" var="invalidEmailMsg"/>
    <!-- jquery-->
    <script src="<c:url value='/assets/public/js/jquery-3.5.0.min.js'/>"></script>
    <!-- Bootstrap js -->
    <script src="<c:url value='/assets/public/js/bootstrap.min.js'/>"></script>
    <!-- Imagesloaded js -->
    <script src="<c:url value='/assets/public/js/imagesloaded.pkgd.min.js'/>"></script>
    <!-- YouTube js -->
    <script src="<c:url value='/assets/public/js/jquery.mb.YTPlayer.min.js'/>"></script>
    <!-- Validator js -->
    <script src="<c:url value='/assets/public/js/validator.min.js'/>"></script>
    <!-- Custom Js -->
    <script src="<c:url value='/assets/public/js/main.js'/>"></script>

     <script>
          let messageFillAllFields = "${fillAllFieldsMsg}";
          let invalidEmailFormat = "${invalidEmailMsg}";

          $(document).ready(function() {
            $('#doRegister').on('click', function(e) {
              e.preventDefault();

              let nameVal = $('#name').val().trim();
              let emailVal = $('#email').val().trim();
              let passwordVal = $('#password').val().trim();
              let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

              if (!nameVal || !emailVal || !passwordVal) {
                $('#notificationMessage').text(messageFillAllFields);
                $('#notification').fadeIn(500);
                setTimeout(function() { $('#notification').fadeOut(500); }, 5000);
                return;
              }
              if (!emailRegex.test(emailVal)) {
                $('#notificationMessage').text(invalidEmailFormat);
                $('#notification').fadeIn(500);
                setTimeout(function() { $('#notification').fadeOut(500); }, 5000);
                return;
              }
              $.ajax({
                type: 'POST',
                url: $('#register').attr('action'),
                data: { name: nameVal, email: emailVal, password: passwordVal },
                success: function(response) {
                  $('#successMessage').text(response);
                  $('#successNotification').fadeIn(500);
                  setTimeout(function(){
                    $('#successNotification').fadeOut(500, function() {
                      window.location.href = "/login";
                    });
                  }, 5000);
                },
                error: function(error) {
                  $('#notificationMessage').text(error.responseText);
                  $('#notification').fadeIn(500);
                  setTimeout(function(){
                    $('#notification').fadeOut(500);
                  }, 5000);
                }
              });
            });
          });
    </script>
</body>
</html>
