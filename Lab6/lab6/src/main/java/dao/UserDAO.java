package dao;

import entity.User;

public interface UserDAO extends GenericDAO<User, String> {

    User findByIdOrEmail(String keyword);

}
