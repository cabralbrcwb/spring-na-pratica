package br.com.vmtec.service.impl;

import br.com.vmtec.dto.UserRegistrationDto;
import br.com.vmtec.exception.UserAlreadyExistAuthenticationException;
import br.com.vmtec.exception.VmTecException;
import br.com.vmtec.model.User;
import br.com.vmtec.repository.UserRepository;
import br.com.vmtec.service.EmailService;
import br.com.vmtec.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // substitui javax.transaction.Transactional
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.context.i18n.LocaleContextHolder;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final EmailService emailService;
    private final PasswordEncoder passwordEncoder;
    private final MessageSource messageSource;

    @Autowired
    public UserServiceImpl(UserRepository userRepository,
                           EmailService emailService,
                           PasswordEncoder passwordEncoder,
                           MessageSource messageSource) {
        this.userRepository = userRepository;
        this.emailService = emailService;
        this.passwordEncoder = passwordEncoder;
        this.messageSource = messageSource;
    }

    @Override
    @Transactional
    public User registerNewUser(UserRegistrationDto userRegistrationDto)
            throws UserAlreadyExistAuthenticationException {


        if (userRepository.existsByEmail(userRegistrationDto.getEmail())) {

            String emailInUseMessage = messageSource.getMessage(
                    "message.registration.error",
                    new Object[]{ userRegistrationDto.getEmail() },
                    LocaleContextHolder.getLocale()
            );
            throw new UserAlreadyExistAuthenticationException(emailInUseMessage);
        }


        User user = new User();
        user.setName(userRegistrationDto.getName());
        user.setEmail(userRegistrationDto.getEmail());

        user.setPassword(passwordEncoder.encode(userRegistrationDto.getPassword()));
        user.setEnabled(true);


        User userSaved = userRepository.save(user);

        // Envia e-mail de boas-vindas

        String subject = messageSource.getMessage(
                "message.sendemail.subject.register",
                null,
                LocaleContextHolder.getLocale()
        );
        String content = messageSource.getMessage(
                "message.sendemail.content.register",
                new Object[]{ userSaved.getName() }, // placeholder {0} para o nome
                LocaleContextHolder.getLocale()
        );

        emailService.enviarEmail(userSaved.getEmail(), subject);

        return userSaved;
    }

    @Override
    public Page<User> findAll(String nome, Pageable pageable) {
        if (nome != null && !nome.isEmpty()) {
            return userRepository.findByNameContainingIgnoreCase(nome, pageable);
        }
        return userRepository.findAll(pageable);
    }

    @Override
    public User findById(Integer id) {
        return userRepository.findById(id).orElseThrow(() -> {
            String notFoundMsg = messageSource.getMessage(
                    "message.user.notfound",
                    new Object[]{ id },
                    LocaleContextHolder.getLocale()
            );
            return new VmTecException(notFoundMsg);
        });
    }

    @Override
    public User findByEmailAndPassword(String email, String rawPassword) {
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            if (passwordEncoder.matches(rawPassword, user.getPassword())) {
                return user;
            }
        }
        return null;
    }

    @Transactional
    public User updateUser(Integer id, UserRegistrationDto dto)
            throws UserAlreadyExistAuthenticationException {

        User user = userRepository.findById(id)
                .orElseThrow(() -> {
                    String notFoundMsg = messageSource.getMessage("message.user.notfound",
                            new Object[]{ id }, LocaleContextHolder.getLocale());
                    return new VmTecException(notFoundMsg);
                });

        // Verifica se o email foi alterado
        if (!user.getEmail().equals(dto.getEmail())) {
            if (userRepository.existsByEmail(dto.getEmail())) {
                String emailInUseMessage = messageSource.getMessage("message.registration.error",
                        new Object[]{ dto.getEmail() }, LocaleContextHolder.getLocale());
                throw new UserAlreadyExistAuthenticationException(emailInUseMessage);
            }
            user.setEmail(dto.getEmail());
        }

        user.setName(dto.getName());

        // Atualiza senha somente se informada
        if (dto.getPassword() != null && !dto.getPassword().isEmpty()) {
            user.setPassword(passwordEncoder.encode(dto.getPassword()));
        }

        User updatedUser = userRepository.save(user);

        // Envia email de notificação
        String subject = messageSource.getMessage("message.sendemail.subject.update",
                null, LocaleContextHolder.getLocale());
        emailService.enviarEmail(updatedUser.getEmail(), subject);

        return updatedUser;
    }

}
