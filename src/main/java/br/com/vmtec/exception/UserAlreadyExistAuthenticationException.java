package br.com.vmtec.exception;

import org.springframework.security.core.AuthenticationException;

public class UserAlreadyExistAuthenticationException extends AuthenticationException {

    private static final long serialVersionUID = 5570981880007077317L;

    private String email;

    public UserAlreadyExistAuthenticationException(String email) {
        super("Usuário com e-mail " + email + " já existe.");
        this.email = email;
    }

    public String getEmail() {
        return email;
    }
}