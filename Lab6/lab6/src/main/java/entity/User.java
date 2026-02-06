package entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Users")
public class User {

    @Id
    @Column(name = "Id")
    private String id;

    @Column(name = "Password", nullable = false, length = 64)
    private String password;

    @Column(name = "Email", unique = true, nullable = false)
    private String email;

    @Column(name = "Fullname")
    private String fullname;

    @Column(name = "Admin")
    private Boolean admin = false;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Favorite> favorites;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Share> shares;

    // ===== Constructor =====
    public User() {
    }

    public User(String id, String password, String email, String fullname, Boolean admin) {
        this.id = id;
        this.password = password;
        this.email = email;
        this.fullname = fullname;
        this.admin = admin;
    }

    // ===== Getter & Setter =====
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    // Password phải là chuỗi đã HASH
    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public Boolean getAdmin() {
        return admin;
    }

    public void setAdmin(Boolean admin) {
        this.admin = admin;
    }

    public List<Favorite> getFavorites() {
        return favorites;
    }

    public void setFavorites(List<Favorite> favorites) {
        this.favorites = favorites;
    }

    public List<Share> getShares() {
        return shares;
    }

    public void setShares(List<Share> shares) {
        this.shares = shares;
    }
}
