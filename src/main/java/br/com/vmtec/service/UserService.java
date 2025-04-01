package br.com.vmtec.service;

import br.com.vmtec.dto.UserRegistrationDto;
import br.com.vmtec.exception.UserAlreadyExistAuthenticationException;
import br.com.vmtec.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface UserService {
    User registerNewUser(UserRegistrationDto userRegistrationDto) throws UserAlreadyExistAuthenticationException;
    Page<User> findAll(String nome, Pageable pageable);
    User findById(Integer id);
    User findByEmailAndPassword(String email, String password);
    User updateUser(Integer id, UserRegistrationDto dto) throws UserAlreadyExistAuthenticationException;
}
