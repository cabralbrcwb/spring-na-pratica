package br.com.vmtec.repository;

import br.com.vmtec.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    boolean existsByEmail(String email);
    Optional<User> findByEmail(String email);
    Page<User> findByNameContainingIgnoreCase(String name, Pageable pageable);
    Optional<User> findByName(String name);
}
