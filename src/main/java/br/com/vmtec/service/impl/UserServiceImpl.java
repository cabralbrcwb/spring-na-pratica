package br.com.vmtec.service.impl;

import br.com.vmtec.dto.UserRegistrationDto;
import br.com.vmtec.exception.PasswordTooShortException;
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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.context.i18n.LocaleContextHolder;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    private static final int MINIMUM_PASSWORD_LENGTH = 6;

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
    public User registerNewUser(UserRegistrationDto userRegistrationDto) {
        if (userRegistrationDto.getPassword() == null ||
                userRegistrationDto.getPassword().length() < MINIMUM_PASSWORD_LENGTH) {
            int actualLength = userRegistrationDto.getPassword() != null ?
                    userRegistrationDto.getPassword().length() : 0;
            throw new PasswordTooShortException(MINIMUM_PASSWORD_LENGTH, actualLength);
        }

        if (userRepository.existsByEmail(userRegistrationDto.getEmail())) {
            throw new UserAlreadyExistAuthenticationException(userRegistrationDto.getEmail());
        }

        User user = new User();
        user.setName(userRegistrationDto.getName());
        user.setEmail(userRegistrationDto.getEmail());
        user.setPassword(passwordEncoder.encode(userRegistrationDto.getPassword()));
        user.setEnabled(true);

        User userSaved = userRepository.save(user);

        String subject = messageSource.getMessage(
                "message.sendemail.subject.register",
                null,
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
    public User updateUser(Integer id, UserRegistrationDto dto) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> {
                    String notFoundMsg = messageSource.getMessage("message.user.notfound",
                            new Object[]{ id }, LocaleContextHolder.getLocale());
                    return new VmTecException(notFoundMsg);
                });

        if (dto.getPassword() != null && !dto.getPassword().isEmpty() &&
                dto.getPassword().length() < MINIMUM_PASSWORD_LENGTH) {
            throw new PasswordTooShortException(MINIMUM_PASSWORD_LENGTH, dto.getPassword().length());
        }

        if (!user.getEmail().equals(dto.getEmail()) &&
                userRepository.existsByEmail(dto.getEmail())) {
            throw new UserAlreadyExistAuthenticationException(dto.getEmail());
        }

        user.setName(dto.getName());

        if (!user.getEmail().equals(dto.getEmail())) {
            user.setEmail(dto.getEmail());
        }

        if (dto.getPassword() != null && !dto.getPassword().isEmpty()) {
            user.setPassword(passwordEncoder.encode(dto.getPassword()));
        }

        User updatedUser = userRepository.save(user);

        String subject = messageSource.getMessage("message.sendemail.subject.update",
                null, LocaleContextHolder.getLocale());
        emailService.enviarEmail(updatedUser.getEmail(), subject);

        return updatedUser;
    }
}