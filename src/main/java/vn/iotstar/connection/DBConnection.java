package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private final String serverName = "localhost";
    private final String portNumber = "3306";
    private final String dbName = "ShoppingServiceMVC";

    private final String userID = "root";
    private final String password = "12345";

    public Connection getConnection() throws Exception {

        String url = "jdbc:mysql://"
                + serverName + ":"
                + portNumber + "/"
                + dbName
                + "?useUnicode=true"
                + "&characterEncoding=UTF-8"
                + "&serverTimezone=Asia/Ho_Chi_Minh";

        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(
                url,
                userID,
                password
        );
    }
}
