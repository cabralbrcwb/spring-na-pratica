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
      <style>
         #notification {
         z-index: 10000;
         width: 100%;
         display: none;
         }
      </style>
   <body>
      <!-- Notições de sucesso e erro -->
      <div id="successNotification" class="alert alert-success fixed-top text-center" role="alert" style="display: none;">
         <strong>Sucesso:</strong> <span id="successMessage">Usuário cadastrado com sucesso! Por favor, faça o login.</span>
      </div>
      <div id="notification" class="alert alert-danger fixed-top text-center" role="alert">
         <strong>Erro:</strong> <span id="notificationMessage"></span>
      </div>
      <!--[if lt IE 8]>
      <p class="browserupgrade">Você está usando um navegador <strong>desatualizado</strong>. Por favor <a href="http://browsehappy.com/">atualize seu navegador</a> para melhorar sua experiência.</p>
      <![endif]-->
      <div id="preloader" class="preloader">
         <div class='inner'>
            <div class='line1'></div>
            <div class='line2'></div>
            <div class='line3'></div>
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
         </div>
         <!-- Video Area Start Here -->
         <div class="container">
            <div class="row align-items-center justify-content-center">
               <div class="col-lg-3 col-12">
                  <div class="fxt-header">

                  </div>
               </div>
               <div class="col-lg-6 col-12">
                  <div class="fxt-content">
                     <h2>Registre-se para uma nova conta</h2>
                     <div class="fxt-form">
                        <c:url value="/register" var="actionUrl" />
                        <form:form name="register" id="register" modelAttribute="userRegistrationForm" action="${actionUrl}" method="post">
                           <form:hidden path="errorMessage" id="hiddenErrorMessage" />
                           <div class="form-group">
                              <div class="fxt-transformY-50 fxt-transition-delay-1">
                                 <input type="text" id="name" class="form-control" name="name" placeholder="Nome" required="required" autocomplete="new-password">
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="fxt-transformY-50 fxt-transition-delay-1">
                                 <input type="email" id="email" class="form-control" name="email" placeholder="E-mail" required="required" autocomplete="new-password">
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="fxt-transformY-50 fxt-transition-delay-2">
                                 <input id="password" type="password" class="form-control" name="password" placeholder="Senha" required="required" autocomplete="new-password">
                                 <i toggle="#password" class="fa fa-fw fa-eye toggle-password field-icon"></i>
                              </div>
                           </div>
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
                           <div class="form-group">
                              <div class="fxt-transformY-50 fxt-transition-delay-4">

                                 <button type="submit" class="fxt-btn-fill" style="background-color:#01cc66" id="doRegister">Cadastrar</button>
                              </div>
                           </div>
                        </form:form>
                     </div>
                     <div class="fxt-footer">
                        <div class="fxt-transformY-50 fxt-transition-delay-9">
                           <p>Já possui uma conta?<a href="<c:url value='/login'/>" class="switcher-text2 inline-text">Entrar</a></p>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </section>
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
         $(document).ready(function() {

             // Evento de clique para o botão de registro
             $('#doRegister').on('click', function(e) {
                 e.preventDefault();

                 var formData = {
                     name: $('#name').val(),
                     email: $('#email').val(),
                     password: $('#password').val(),
                     socialProvider: $('#socialProvider').val()
                 };

                 $.ajax({
                     type: 'POST',
                     url: $('#register').attr('action'),
                     data: formData,
                     success: function(response) {
                         console.log("Sucesso na chamada AJAX.");

                         $('#successNotification').fadeIn(500);

                         setTimeout(function() {
                             $('#successNotification').fadeOut(500, function() {
                                 window.location.href = "/home"; // Ou a URL que você quiser redirecionar após a notificação
                             });
                         }, 5000);
                     },
                     error: function(error) {
                         console.log("Erro na chamada AJAX.");
                         $('#notificationMessage').text(error.responseText || 'Erro ao registrar. Por favor, tente novamente.');
                         $('#notification').fadeIn(500);

                         setTimeout(function() {
                             $('#notification').fadeOut(500);
                         }, 5000);
                     }
                 });
             });

         });


      </script>
   </body>
</html>