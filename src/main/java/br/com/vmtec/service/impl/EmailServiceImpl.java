package br.com.vmtec.service.impl;

import br.com.vmtec.service.EmailService;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class EmailServiceImpl implements EmailService {

    @Resource
    private MessageSource messageSource;

    @Override
    public void enviarEmail(String destinatario, String nomeUsuario) {
        String logMsg = messageSource.getMessage(
                "message.sendemail.success",             // code
                new Object[]{ destinatario },            // args
                LocaleContextHolder.getLocale()          // locale atual
        );
        System.out.println(logMsg);

        String subject = messageSource.getMessage(
                "message.sendemail.subject.register",
                null,
                LocaleContextHolder.getLocale()
        );

        String content = messageSource.getMessage(
                "message.sendemail.content.register",
                new Object[]{ nomeUsuario },
                LocaleContextHolder.getLocale()
        );

        System.out.println("Assunto: " + subject);
        System.out.println("Conteúdo: " + content);

    }
}
