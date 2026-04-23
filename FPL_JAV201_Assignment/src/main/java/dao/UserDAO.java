package dao;

import entity.User;

import java.util.List;

public interface UserDAO {
    List<User> findAll();

    User findById(Integer id);

    User findByEmail(String email);

    void create(User user);

    void update(User user);

    void delete(Integer id);

    User findByIdOrEmail(String input);

}
