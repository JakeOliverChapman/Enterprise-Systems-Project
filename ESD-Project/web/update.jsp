<%@page import="model.ConnectionManager"%>
<%@page import="model.ConnectionManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%

    String id = request.getParameter("d");
    String userType = request.getParameter("j");
    String firstName = request.getParameter("fn");
    String lastName = request.getParameter("ln");
    String email = request.getParameter("em");
    String userPassword = request.getParameter("pw");
    String dateOfBirth = request.getParameter("dob");

    System.out.println(id);

    currentCon = ConnectionManager.getConnection();
    stmt = currentCon.createStatement();

    System.out.println(userType);
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
        } else if (userType == "Driver") {
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

