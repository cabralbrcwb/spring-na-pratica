package br.com.vmtec.model;


import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "user", schema = "vmtecdb")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "password", length = 200)
    private String password;

    @Column(name = "provider", length = 10)
    private String provider;

    @Column(name = "verification_key", length = 100)
    private String verificationKey;

    @Column(name = "status")
    private Byte status;

    @Column(name = "creation_date")
    private Timestamp creationDate;

    @Column(name = "activation_date")
    private Timestamp activationDate;

    @Column(name = "last_login_date")
    private Timestamp lastLoginDate;


    @Column(name = "gender")
    private Byte gender;


    @Column(name = "enabled", columnDefinition = "BIT", length = 1)
    private boolean enabled;


    public User() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getProvider() {
        return provider;
    }

    public void setProvider(String provider) {
        this.provider = provider;
    }

    public String getVerificationKey() {
        return verificationKey;
    }

    public void setVerificationKey(String verificationKey) {
        this.verificationKey = verificationKey;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    public Timestamp getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Timestamp creationDate) {
        this.creationDate = creationDate;
    }

    public Timestamp getActivationDate() {
        return activationDate;
    }

    public void setActivationDate(Timestamp activationDate) {
        this.activationDate = activationDate;
    }

    public Timestamp getLastLoginDate() {
        return lastLoginDate;
    }

    public void setLastLoginDate(Timestamp lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }

    public Byte getGender() {
        return gender;
    }

    public void setGender(Byte gender) {
        this.gender = gender;
    }


    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }


    public String getDisplayName() {
        return this.name != null ? this.name : this.email;
    }
}
