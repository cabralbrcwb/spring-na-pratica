Java 11

Spring Boot 2.7.1:

spring-boot-starter-web

spring-boot-starter-data-jpa

spring-boot-starter-security

spring-boot-starter-validation (Bean Validation)

MySQL (banco de dados)

MySQL Connector (driver)

Apache Tiles (layout e organização de páginas JSP)

MessageSource para i18n (messages.properties)

3. Configuração do Banco de Dados
Crie um schema no MySQL, por exemplo vmtecdb.

Crie um usuário (por exemplo vmtec_admin) com as permissões necessárias.

No arquivo application.properties, configure a conexão com o MySQL, definindo URL, usuário e senha:

properties
Copiar
spring.datasource.url=jdbc:mysql://localhost:3306/vmtecdb
spring.datasource.username=vmtec_admin
spring.datasource.password=SUASENHA
spring.jpa.hibernate.ddl-auto=update
O parâmetro spring.jpa.hibernate.ddl-auto=update fará com que o Hibernate crie ou atualize as tabelas automaticamente (em um ambiente de produção, avalie a estratégia de geração de schema).

4. Estrutura de Pastas e Pacotes

5. Principais Funcionalidades
Cadastro de Usuário
DTO: UserRegistrationDto

Contém campos como name, email, password, etc.

Controller: SignUpController

GET em /register: exibe o formulário de cadastro (JSP).

POST em /register: processa o DTO, chama o UserService e retorna mensagens de sucesso ou erro.

UserService

Método registerNewUser(...):

Verifica se o e-mail já está em uso; se sim, lança exceção.

Codifica a senha (BCrypt).

Persiste os dados no banco.

Envia (simulado) o e-mail de boas-vindas.

Listagem Paginada
Controller: UserController em /users

Recebe parâmetros (nome, page, size).

Chama userService.findAll(nome, pageable).

Retorna para a JSP list-users.jsp (via Tiles ou outro método) contendo a lista paginada.

Edição de Usuário
Método updateUser(Integer id, UserRegistrationDto dto) em UserService:

Verifica se o ID existe; se não, lança exceção.

Se o e-mail foi alterado, checa se já está em uso.

Codifica a nova senha, se fornecida.

Salva as alterações.

Envia e-mail informando a atualização.

Envio de E-mail
EmailService e EmailServiceImpl:

Implementam o método enviarEmail(...).

Por padrão, o envio de e-mail é apenas simulado com impressão no console (System.out.println(...)), mas pode ser integrado a um servidor SMTP real.

Internacionalização (i18n)
Configuração via MessageSource para carregar mensagens em diferentes idiomas.

Arquivos de exemplo:

messages_pt.properties

messages_en.properties

Nos controladores e serviços, utilizamos messageSource.getMessage("chave", null, locale) para obter a mensagem correta conforme o idioma definido.

6. Executando o Projeto
Clonar o repositório:

git clone https://github.com/seu-usuario/vmtec_cabralbrcwb.git
Configurar o MySQL:

Criar o schema vmtecdb ou ajustar o nome no application.properties.

Ajustar usuário e senha de acordo com a instalação local.

Compilar e Executar:
cd vmtec_cabralbrcwb
mvn spring-boot:run

Por padrão, a aplicação estará disponível na porta 8080.

Acessar as rotas:
http://localhost:8080/login    (Autenticação)

http://localhost:8080/register (cadastro de usuários para autenticação e listagem paginada)

http://localhost:8080/users (listagem paginada)

7. Observações
O envio de e-mail está simulado (apenas imprime no console).

O locale pode ser definido via interceptores do Spring ou via Accept-Language no navegador.

O HTML/CSS é personalizável (o projeto traz exemplos com JSP + Bootstrap).

A aplicação tem configuração básica de Spring Security, podendo ser expandida para exigir autenticação nas rotas de listagem, edição etc.

O template foi obtido de fonte aberta na internet e posteriormente personalizado para atender às necessidades específicas do layout das interfaces. Embora tenha sido utilizado como base estrutural, todos os elementos (Bootstrap, JavaScript, jQuery, CSS e imagens) foram adaptados e customizados de maneira significativa, resultando em uma implementação original que não constitui uma simples reprodução do material de referência.

Enquanto os elementos visuais e de interface foram adaptados a partir de um template de código aberto, toda a implementação da camada de backend—incluindo lógica de negócios, processamento de dados, integração com sistemas e funcionalidades do servidor—foi desenvolvida integralmente por mim, constituindo trabalho original e proprietário.