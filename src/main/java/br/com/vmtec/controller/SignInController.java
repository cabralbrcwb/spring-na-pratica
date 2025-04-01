package br.com.vmtec.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class SignInController {
    private final Logger logger = LogManager.getLogger(getClass());

    @GetMapping("/login")
    public ModelAndView showSignIn() {
        logger.info("Exibindo página de login...");
        return new ModelAndView("login");
    }


}
