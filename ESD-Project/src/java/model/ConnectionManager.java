package model;

import java.sql.*;

public class ConnectionManager {

    static Connection connection;
    static String url;
    static String username = "pass";
    static String password = "pass";

    public static Connection getConnection() {
        System.out.println("Attempting onnecton.");
        try {
            String connectionURL = "jdbc:derby://localhost:1527/userlogin";
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try {
                connection = DriverManager.getConnection(connectionURL, username, password);
            } catch (SQLException e) {
                System.out.println(e);
            }
        } catch (ClassNotFoundException e) {
            System.out.println(e);
        }
        return connection;
    }
}
