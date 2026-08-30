package vn.iotstar.service.impl;

import java.time.LocalDate;
import java.util.List;

import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;

public class UserServiceImpl implements IUserService {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    public void insert(User user) {

        if (checkExistUsername(user.getUsername())) {
            throw new RuntimeException("Tài khoản đã tồn tại");
        }

        if (checkExistEmail(user.getEmail())) {
            throw new RuntimeException("Email đã tồn tại");
        }

        if (checkExistPhone(user.getPhone())) {
            throw new RuntimeException("Số điện thoại đã tồn tại");
        }

        userDao.insert(user);
    }

    @Override
    public void update(User user) {

        User oldUser = userDao.findById(user.getId());

        if (oldUser == null) {
            throw new RuntimeException("Không tìm thấy User");
        }

        userDao.update(user);
    }

    @Override
    public void delete(int id) throws Exception {
        userDao.delete(id);
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public User login(String username, String password) {
        return userDao.login(username, password);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public List<User> findAll(int page, int pageSize) {
        return userDao.findAll(page, pageSize);
    }

    @Override
    public List<User> searchByName(String fullname) {
        return userDao.searchByName(fullname);
    }

    @Override
    public int count() {
        return userDao.count();
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.findByEmail(email) != null;
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.findByUsername(username) != null;
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.findByPhone(phone) != null;
    }

    @Override
    public boolean register(
            String email,
            String password,
            String username,
            String fullname,
            String phone) {

        try {

            User user = new User();

            user.setEmail(email);
            user.setPassword(password);
            user.setUsername(username);
            user.setFullname(fullname);
            user.setPhone(phone);

            user.setAvatar(null);
            user.setRoleid(2);
            user.setCreateddate(LocalDate.now());

            userDao.insert(user);

            return true;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}
