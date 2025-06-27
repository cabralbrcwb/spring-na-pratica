# VMTEC – Sistema de Cadastro de Usuários

[![Status do Build](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/)


<p align="left">
  <img src="https://img.shields.io/badge/Java-11-red.svg" alt="Java 11">
  <img src="https://img.shields.io/badge/Spring_Boot-2.7.x-brightgreen.svg" alt="Spring Boot">
  <img src="https://img.shields.io/badge/MySQL-Database-blue.svg" alt="MySQL">
  <img src="https://img.shields.io/badge/JPA-Hibernate-orange.svg" alt="JPA/Hibernate">
  <img src="https://img.shields.io/badge/Spring_Security-secure-green.svg" alt="Spring Security">
  <img src="https://img.shields.io/badge/JUnit-5-lightgrey.svg" alt="JUnit 5">
  <img src="https://img.shields.io/badge/Mockito-testing-blueviolet.svg" alt="Mockito">
</p>

# VMTEC – Cadastro de Usuários



Uma aplicação completa em **Spring Boot** para cadastro, autenticação e gerenciamento de usuários, com layout modular, envio de e-mails simulado, e suporte à internacionalização.

---

## 🚀 Visão Geral

Este projeto demonstra um sistema de **CRUD de Usuários** com:

- Backend robusto em Spring Boot
- Segurança via Spring Security
- Layout com Apache Tiles
- Persistência de dados com MySQL
- Envio de e-mails (simulado)
- Internacionalização com suporte a múltiplos idiomas


---

## ✨ Funcionalidades Principais

- **Cadastro de Usuários:** Com validação e verificação de e-mail único
- **Login Seguro:** Usando Spring Security e senhas com BCrypt
- **Logout Seguro:** Usando Spring Security Config
- **Listagem e Filtro:** Paginação com busca por nome
- **Edição de Usuários:** Atualização de dados, e-mail e senha
- **Mensagens Multilíngue:** `pt` e `en` com arquivos de properties
- **Layout Modular:** Com Apache Tiles e JSP
- **Feedback Instantâneo:** Validações e mensagens via AJAX

---

## 🧠 Arquitetura em Camadas

```
Controller (Apresentação)
   ↓
Service (Regra de Negócio)
   ↓
Repository (Persistência)
   ↓
Model (Entidades)
```

---

## 🛠️ Tecnologias Utilizadas

- **Java 11**
- **Spring Boot 2.7.x**
- **Spring MVC / JPA / Security / Validation**
- **MySQL**
- **Apache Tiles**
- **JUnit 5 + Mockito**

Veja o `pom.xml` para mais detalhes das dependências.

---

## 📁 Estrutura do Projeto

- `User`: Entidade JPA com campos principais e datas
- `UserRegistrationDto`: DTO para cadastro/edição
- `UserServiceImpl`: Lógica de negócio principal
- `UserRepository`: Acesso a dados com consultas customizadas

---

## 🌍 Internacionalização (i18n)

Mensagens em `pt` e `en` são carregadas pela `MessageSourceConfig`, aplicadas em validações e respostas para o cliente conforme o `Locale`.

---

## 🖥️ Frontend com JSP + Tiles

- Layout principal em `WEB-INF/tiles.xml`
- Páginas públicas: `sign-in.jsp`, `sign-up.jsp`
- Páginas autenticadas: `list-users.jsp`, `edit-user.jsp`
- Recursos estáticos: CSS, JS, imagens em `/static/assets`
- AJAX para feedback em tempo real durante o registro

---

## 🔐 Segurança com Spring Security

- **Login:** Formulário em `/login`, autentica via `/j_spring_security_check`
- **Logout:** Acessível em `/logout`
- **Rotas públicas:** `/assets/**`, `/register`, `/forgot-password` (forgot-password não finalizada)
- **Proteção:** Demais rotas requerem autenticação
- **CSRF:** Desativado para facilitar uso com AJAX

---

## 🧪 Testes

- `UserServiceImplTest`: Testes com JUnit/Mockito para:
  - Cadastro com sucesso
  - E-mail duplicado
  - Criptografia da senha
- `VmtecApplicationTests`: Verifica se o contexto Spring carrega corretamente

---

Made with 💚 using Spring Boot.
