package vn.iotstar.service.impl;

import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;

import java.sql.Date;

public class UserServiceImpl implements IUserService {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {

        User user = this.get(username);

        if (user != null && password.equals(user.getPassWord())) {
            return user;
        }

        return null;
    }

    private User get(String username) {
        return userDao.get(username);
    }

    @Override
    public boolean register(
            String email,
            String password,
            String username,
            String fullname,
            String phone) {

        if (userDao.checkExistUsername(username)) {
            return false;
        }

        if (userDao.checkExistEmail(email)) {
            return false;
        }

        if (userDao.checkExistPhone(phone)) {
            return false;
        }

        long millis = System.currentTimeMillis();
        Date date = new Date(millis);

        User user = new User(
                email,
                username,
                fullname,
                password,
                null,
                2,
                phone,
                date
        );

        userDao.insert(user);

        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }
}
