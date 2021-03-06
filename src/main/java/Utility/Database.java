package Utility;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    private static Connection connection = null;

    public static Connection getConnection() throws SQLException {
        if(connection != null)
            return connection;

        DriverManager.registerDriver (new com.mysql.cj.jdbc.Driver());

        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopper","root", Variables.SqlPassword);
        return connection;
    }

    public static String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-224");
        digest.update(password.getBytes());

        byte[] r = digest.digest();
        StringBuilder builder = new StringBuilder();

        for(byte b: r) {
            builder.append(String.format("%02x", b));
        }

        return builder.toString();
    }
}
