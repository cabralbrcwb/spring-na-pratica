package br.com.vmtec.dto;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;


import java.util.Collection;
import java.util.Collections;

public class LocalUser extends User {
    private static final long serialVersionUID = 4856846343727949025L;

    private static final boolean ACCOUNT_NON_EXPIRED = true;
    private static final boolean ACCOUNT_NON_LOCKED = true;
    private static final boolean CREDENTIALS_NON_EXPIRED = true;
    private static final Collection<GrantedAuthority> EMPTY_AUTHORITIES = Collections.emptyList();


    private final br.com.vmtec.model.User domainUser;

    /**
     * Construtor que converte a entidade de domínio User em UserDetails para o Spring Security.
     *
     * @param domainUser Entidade de usuário do domínio da aplicação
     */
    public LocalUser(br.com.vmtec.model.User domainUser) {
        super(
                domainUser.getEmail(),    // username
                domainUser.getPassword(), // senha criptografada
                domainUser.isEnabled(),   // status de ativação da conta
                ACCOUNT_NON_EXPIRED,      // conta não expirada
                CREDENTIALS_NON_EXPIRED,  // credenciais não expiradas
                ACCOUNT_NON_LOCKED,       // conta não bloqueada
                EMPTY_AUTHORITIES         // sem definição de papéis/roles
        );

        this.domainUser = domainUser;
    }


    public br.com.vmtec.model.User getDomainUser() {
        return domainUser;
    }

    /**
     * Se quiser sobrescrever e retornar o nome completo, e-mail ou quaisquer outra informação
     */
    @Override
    public String getUsername() {
        return domainUser.getEmail();
    }
}
