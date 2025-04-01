package br.com.vmtec.service.impl;

import br.com.vmtec.dto.UserRegistrationDto;
import br.com.vmtec.exception.UserAlreadyExistAuthenticationException;
import br.com.vmtec.model.User;
import br.com.vmtec.repository.UserRepository;
import br.com.vmtec.service.EmailService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.context.MessageSource;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Locale;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;


@ExtendWith(MockitoExtension.class)
class UserServiceImplTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private EmailService emailService;

    @Mock
    private PasswordEncoder passwordEncoder;

    @Mock
    private MessageSource messageSource;

    @InjectMocks
    private UserServiceImpl userService;

    private UserRegistrationDto validDto;

    @BeforeEach
    void setup() {
        validDto = new UserRegistrationDto();
        validDto.setName("Daniel Silva");
        validDto.setEmail("daniel@silva.com");
        validDto.setPassword("123456");
    }

    /**
     * Testa se o sistema rejeita cadastros com emails duplicados.
     * <p>
     * Este teste configura um cenário onde o email "daniel@silva.com" já existe no cadastro
     * e verifica se uma exceção de usuário já existente é lançada quando tentamos
     * registrar novamente o mesmo email.
     * <p>
     * O teste também confirma que, quando o email já existe, o sistema não tenta
     * salvar o usuário nem enviar email de boas-vindas, interrompendo o processo
     * logo no início da validação.
     */
    @Test
    void shouldThrowExceptionIfEmailExists() {
        when(messageSource.getMessage(anyString(), any(), any(Locale.class)))
                .thenReturn("Email já cadastrado");

        when(userRepository.existsByEmail("daniel@silva.com")).thenReturn(true);

        // Act & Assert
        assertThrows(UserAlreadyExistAuthenticationException.class, () -> {
            userService.registerNewUser(validDto);
        });

        // Verifica se não chamou save nem emailService
        verify(userRepository, never()).save(any(User.class));
        verify(emailService, never()).enviarEmail(anyString(), anyString());
    }

    /**
     * Testa como funciona o cadastro de um novo usuário e o envio do email de boas-vindas.
     * <p>
     * Este teste checa várias coisas:
     * - Se o sistema verifica que o email ainda não está cadastrado
     * - Se a senha é devidamente codificada pelo encriptador
     * - Se o novo usuário é salvo corretamente no cadastro
     * - Se os dados salvados têm o email certo e a senha já codificada
     * - Se o cadastro realmente salva o usuário como deveria
     * - Se o sistema de email é chamado com os dados certos do usuário
     * <p>
     * No fim, o teste confirma que tudo funciona junto: o cadastro, o encriptador
     * e o serviço de email trabalham corretamente durante todo o processo.
     *
     * @throws Exception caso algo dê errado durante o teste
     */
    @Test
    void shouldRegisterNewUserAndSendEmail() throws Exception {
        lenient().when(messageSource.getMessage(anyString(), any(), any(Locale.class)))
                .thenReturn("João");

        lenient().when(userRepository.existsByEmail("daniel@silva.com")).thenReturn(false);
        lenient().when(passwordEncoder.encode("123456")).thenReturn("encoded_123456");

        // Simula retorno de User salvo
        User savedMock = new User();
        savedMock.setId(1);
        savedMock.setName("João");
        savedMock.setEmail("daniel@silva.com");
        savedMock.setPassword("encoded_123456");

        when(userRepository.save(any(User.class))).thenReturn(savedMock);

        // Act
        User savedUser = userService.registerNewUser(validDto);

        // Assert
        assertNotNull(savedUser);
        assertEquals("daniel@silva.com", savedUser.getEmail());
        assertEquals("encoded_123456", savedUser.getPassword());

        verify(userRepository).save(any(User.class));
        verify(emailService).enviarEmail(eq("daniel@silva.com"), eq("João"));
    }

    /**
     * Testa o cenário onde o login falha quando a senha informada não bate com a versão
     * codificada armazenada no banco.
     * <p>
     * Este teste simula um cadastro de usuário contendo uma senha já codificada e também
     * um encriptador de senha para testar quando a autenticação falha.
     * <p>
     * O teste confirma que o método devolve null e que o encriptador é chamado corretamente
     * quando as senhas não batem.
     */
    @Test
    void shouldNotLoginIfPasswordDoesNotMatch() {
        User userMock = new User();
        userMock.setEmail("daniel@silva.com");
        userMock.setPassword("encoded_senha");

        when(userRepository.findByEmail("daniel@silva.com"))
                .thenReturn(Optional.of(userMock));
        when(passwordEncoder.matches("wrong_pass", "encoded_senha"))
                .thenReturn(false);

        User result = userService.findByEmailAndPassword("daniel@silva.com", "wrong_pass");

        assertNull(result, "Deveria retornar null se a senha não confere");
        verify(passwordEncoder).matches("wrong_pass", "encoded_senha");
    }

    /**
     * Testa o login bem-sucedido quando o usuário informa a senha correta.
     * <p>
     * Este teste simula um cadastro com um usuário que tem email e senha codificada.
     * Configuramos o encriptador para confirmar que a senha informada corresponde
     * à versão codificada guardada no banco.
     * <p>
     * Verificamos que o método retorna o usuário correto quando as credenciais
     * são válidas e que o encriptador é chamado para fazer a verificação da senha.
     */
    @Test
    public void loginUserCorrectPassword_returnsUser() {
        // Arrange
        String emailMock = "user@test.com";
        String plainPassword = "securePassword";
        String encodedPassword = "securePasswordEncoded";
        // Create a mock user
        User userMock = new User();
        userMock.setId(1);
        userMock.setName("Daniel Silva");
        userMock.setEmail(emailMock);
        userMock.setPassword(encodedPassword);
        // Simulate repository and passwordEncoder behavior
        when(userRepository.findByEmail(emailMock)).thenReturn(Optional.of(userMock));
        when(passwordEncoder.matches(plainPassword, encodedPassword)).thenReturn(true);
        // Act
        User returnedUser = userService.findByEmailAndPassword(emailMock, plainPassword);
        // Assert
        assertNotNull(returnedUser, "O retorno do objeto não deveria ser nulo.");
        assertEquals(emailMock, returnedUser.getEmail(), "O usuario deve ter o mesmo email.");
        verify(passwordEncoder).matches(plainPassword, encodedPassword);
    }
}