package br.com.vmtec.controller;

import br.com.vmtec.dto.UserRegistrationDto;
import br.com.vmtec.exception.UserAlreadyExistAuthenticationException;
import br.com.vmtec.exception.VmTecException;
import br.com.vmtec.service.UserService;
import java.io.IOException;
import java.util.Locale;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

@RestController
public class SignUpController {

    private final Logger logger = LogManager.getLogger(getClass());
    private String errorMessage;

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public ModelAndView register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        logger.info("Exibindo página de registro...");

        ModelAndView modelAndView = new ModelAndView("register");
        modelAndView.addObject("userRegistrationForm", new UserRegistrationDto());
        return modelAndView;
    }

    @PostMapping("/register")
    public ResponseEntity<String> registerUser(UserRegistrationDto userRegistrationDto,
                                               BindingResult result,
                                               final HttpServletRequest request,
                                               RedirectAttributes attributes) {
        logger.info("Registrando novo usuário...");

        Locale locale = RequestContextUtils.getLocale(request);

        try {
            // Verifica erros de validação no DTO
            if (result.hasErrors()) {
                String validationErrorKey = result.getAllErrors().get(0).getCode();
                String errorMessage = messageSource.getMessage(
                        validationErrorKey,
                        null,
                        locale
                );
                return ResponseEntity.badRequest().body(errorMessage);
            }

            userService.registerNewUser(userRegistrationDto);

            // Mensagem de sucesso (message.registration.success)
            String successMessage = messageSource.getMessage(
                    "message.registration.success",
                    null,
                    locale
            );
            return ResponseEntity.ok(successMessage);

        } catch (UserAlreadyExistAuthenticationException e) {
            // Email já cadastrado (message.registration.error)
            logger.error("Erro de usuário duplicado", e);

            String errorMessage = messageSource.getMessage(
                    "message.registration.error",
                    null,
                    locale
            );
            return ResponseEntity.badRequest().body(errorMessage);

        } catch (VmTecException e) {
            // Demais exceções da lógica de negócios
            logger.error("Erro de VmTecException", e);
            return ResponseEntity.badRequest().body(e.getMessage());

        } catch (Exception e) {
            // Qualquer erro genérico não tratado acima
            logger.error("Erro inesperado no registro de usuário", e);

            String genericError = messageSource.getMessage(
                    "message.generic.error",
                    null,
                    locale
            );
            return ResponseEntity.status(500).body(genericError);
        }
    }


    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
    public String getErrorMessage() {
        return errorMessage;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setMessageSource(MessageSource messageSource) {
        this.messageSource = messageSource;
    }
}
