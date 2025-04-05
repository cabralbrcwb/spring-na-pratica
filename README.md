 VMTEC – Cadastro de Usuários - Aplicação disponível em: 
 https://vmtec-0e7049358cd1.herokuapp.com/

Aplicação em Spring Boot para cadastro, listagem e edição de usuários. Inclui autenticação com Spring Security, envio de e-mails (simulado) e layout modular com Apache Tiles.

# 1. Visão Geral
Este projeto foi desenvolvido para demonstrar um CRUD de Usuários em um ambiente Spring Boot, com persistência via MySQL e segurança básica por meio do Spring Security.

O objetivo principal é fornecer um exemplo completo de aplicação web em camadas, incluindo:

- Cadastro de novos usuários com verificação de e-mail único.

- Listagem paginada e filtrável de usuários.

- Edição dos dados de cada usuário.

- Autenticação via formulário de login.

- Envio de e-mails simulado no console para fins de notificação e rollback da transação quando ocorrer erro no cadastro do usuário.

# 2. Principais Funcionalidades
Registro de Usuários: Endpoint público para criar um novo cadastro, com validação de dados (Bean Validation).

Autenticação: Login tradicional controlado pelo Spring Security, com senha criptografada em BCrypt.

Gerenciamento de Usuários:

Listagem paginada e filtrável por nome.

Edição de dados, incluindo troca de e-mail (checa duplicidade) e atualização de senha.

Internacionalização (i18n): Mensagens de erro/sucesso em mais de um idioma (ex.: messages_pt.properties e messages_en.properties).

Layout usando Apache Tiles para organização de templates JSP.

# 3. Arquitetura em Camadas

Controller (Apresentação)  ->  Service (Regra de Negócio)  ->  Repository (Persistência)  ->  Model (Entidades)

# 4. Tecnologias e Dependências Principais
Java 11
Spring Boot 2.7.x
Starter Web (Spring MVC)
Starter Data JPA (Hibernate)
Starter Security (Autenticação)
Starter Validation (Bean Validation)
MySQL (Driver JDBC)
Apache Tiles (Layout de páginas JSP)
Spring Security OAuth (dependência disponível, mas login social não implementado)
JUnit 5 e Mockito (via spring-boot-starter-test) para testes.

No arquivo pom.xml constam detalhes de versão e demais bibliotecas auxiliares.

# 5. Estrutura de Pacotes

- User: Entidade JPA que representa o usuário (campos de nome, email, senha, datas(último login, criação, atualização, etc.).

- UserRegistrationDto: Captura dados de formulário para cadastro/edição de usuários.

- UserServiceImpl: Lógica principal de cadastro de usuário (verifica duplicidade, criptografa senha, envia e-mail).

- UserRepository: Métodos de consulta por email, busca paginada etc.

# 6. Internacionalização (i18n)
A classe MessageSourceConfig carrega messages_en.properties e messages_pt.properties. 
O Bean Validation também usa essas mensagens para feedback de erros.

Mensagens de sucesso e erro de cadastro, duplicidade de e-mail etc. 
São obtidas do MessageSource, respeitando o Locale do cliente.

# 7. Frontend (JSP + Tiles)
Tiles: O arquivo WEB-INF/tiles.xml define o layout principal (template.jsp) e as páginas (list-users, edit-user, login, register).

Páginas públicas: sign-in.jsp e sign-up.jsp (não usam o template principal; têm layout próprio).

Páginas autenticadas: list-users.jsp, edit-user.jsp (estendem o template base).

Recursos estáticos: Em src/main/resources/static/assets (CSS, JS, imagens).

AJAX no registro de usuário: SignUpController retorna ResponseEntity (código HTTP 200 ou 400)
e a página sign-up.jsp exibe alertas.

# 8. Segurança (Spring Security)
- Segurança configurada em SecurityConfig.java, com CSRF desabilitado para facilitar chamadas AJAX.

- Rotas liberadas: /assets/**, /register, /forgot-password (não implementada).

- Protegidas: todas as demais rotas exigem login.

- Login: página em /login, envia credenciais para /j_spring_security_check e, se bem-sucedido, redireciona para /users.

- Logout: acessível em /logout.

# 9. Testes
UserServiceImplTest: Exemplifica testes unitários com JUnit/Mockito, validando:

- Registro bem-sucedido.

- Falha ao tentar cadastrar usuário com e-mail duplicado.

- Criptografia de senha.

- Contexto Spring: VmtecApplicationTests verifica se a aplicação carrega corretamente.
