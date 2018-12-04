package model;

import java.sql.*;

public class ConnectionManager {

    static Connection con;
    static String url;

    public static Connection getConnection() {
        System.out.println("Trying to connect.........");
        try {
            String url = "jdbc:derby://localhost:1527/userlogin";

            Class.forName("org.apache.derby.jdbc.ClientDriver");

            try {
                con = DriverManager.getConnection(url, "pass", "pass");
                // assuming your SQL Server's username is "pass"               
                // and password is "pass"

            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            System.out.println(e);
        }

        return con;
    }
}
