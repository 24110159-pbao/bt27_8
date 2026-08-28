package vn.iotstar.connection;

import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        try {

            DBConnection db = new DBConnection();

            Connection connection = db.getConnection();

            System.out.println("Kết nối MySQL thành công!");

            connection.close();

        } catch (Exception e) {

            e.printStackTrace();

        }
    }
}
