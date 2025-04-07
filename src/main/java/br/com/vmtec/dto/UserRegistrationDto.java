package br.com.vmtec.dto;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class UserRegistrationDto {

    private Integer userID;
    private String providerUserId;

    @NotEmpty(message = "{NotEmpty.userDto.name}")
    private String name;

    @NotEmpty(message = "{NotEmpty.userDto.email}")
    @Email(message = "{Email.userDto.email}")
    private String email;

    @NotEmpty(message = "{NotEmpty.userDto.password}")
    @Size(min = 6, message = "{Size.userDto.password}")
    private String password;

    private String errorMessage;

    public UserRegistrationDto() {
    }

    public UserRegistrationDto(String name, String email, String password, String imageUrl) {
        this.name = name;
        this.email = email;
        this.password = password;
    }

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }

    public String getProviderUserId() {
        return providerUserId;
    }

    public void setProviderUserId(String providerUserId) {
        this.providerUserId = providerUserId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(final String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(final String password) {
        this.password = password;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
}
