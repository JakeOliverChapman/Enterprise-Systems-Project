<%-- 
    Document   : update
    Created on : 30-Nov-2018, 15:46:49
    Author     : Willi
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%
//    
    String id = request.getParameter("d");
    String userType = request.getParameter("j");
    String firstName = request.getParameter("fn");
    String lastName = request.getParameter("ln");
    String email = request.getParameter("em");
    String userPassword = request.getParameter("pw");
    String dateOfBirth = request.getParameter("dob");

//  int number = Integer.parseInt(id);
//  System.out.println(userType);
//  System.out.println(number);
    String driverName = "org.apache.derby.jdbc.ClientDriver";
    String connectionUrl = "jdbc:derby://localhost:1527/userlogin";
    String userId = "pass";
    String password = "pass";
    try {
        Class.forName(driverName).newInstance();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    Connection connection = null;
    Statement statement = null;

    connection = DriverManager.getConnection(connectionUrl, userId, password);

    try {
        if (userType == "Customer") {
            PreparedStatement ps = connection.prepareStatement("UPDATE PASS.CUSTOMER_TABLE SET FIRSTNAME = ?, LASTNAME = ?, EMAIL = ?, PASSWORD = ?, DATEOFBIRTH= ? WHERE CUSTOMERID=" + id);
            ps.setObject(1, firstName);
            ps.setObject(2, lastName);
            ps.setObject(3, email);
            ps.setObject(4, userPassword);
            ps.setObject(5, dateOfBirth);
            System.out.println("Customer");
            ps.executeUpdate();
        } else {
            PreparedStatement ps = connection.prepareStatement("UPDATE PASS.DRIVER_TABLE SET FIRSTNAME = ?, LASTNAME = ?, EMAIL = ?, PASSWORD = ?, DATEOFBIRTH= ? WHERE DRIVERID=" + id);
            ps.setObject(1, firstName);
            ps.setObject(2, lastName);
            ps.setObject(3, email);
            ps.setObject(4, userPassword);
            ps.setObject(5, dateOfBirth);
            System.out.println("Driver");
            ps.executeUpdate();
        }
        
        response.sendRedirect("headOfficeHome.jsp");
        
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Yeet");
    }

%>
