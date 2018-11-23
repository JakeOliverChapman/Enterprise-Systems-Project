<%-- 
    Document   : delete
    Created on : 11-Nov-2018, 14:13:16
    Author     : jonasarud
--%>

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>

<% 
    
  String id = request.getParameter("d");
  String userType = request.getParameter("j");
  
  int number = Integer.parseInt(id);
  System.out.println(userType);
  System.out.println(number);
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
    statement=connection.createStatement();
    
    if(userType.equals("Customer")){
        statement.executeUpdate("delete from PASS.CUSTOMER_TABLE WHERE customerID="+ number);
        response.sendRedirect("customers.jsp");
    }else{
        statement.executeUpdate("delete from PASS.DRIVER_TABLE WHERE driverID="+ number);       
        response.sendRedirect("drivers.jsp");
    }
        
   %>
