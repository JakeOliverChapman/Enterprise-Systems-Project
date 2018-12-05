<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%
    System.out.println("Job completion box ticked.");
    String id = request.getParameter("d");
    String jobComplete = request.getParameter("jobCompleted");
    String driverName = "org.apache.derby.jdbc.ClientDriver";
    String connectionUrl = "jdbc:derby://localhost:1527/userlogin";
    String userId = "pass";
    String password = "pass";

    try {
        Class.forName(driverName).newInstance();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    // Connect to database and change job completion status
    Connection connection = DriverManager.getConnection(connectionUrl, userId, password);
    try {
        PreparedStatement ps = connection.prepareStatement("UPDATE PASS.DRIVER_TABLE SET JOBCOMPLETED = ? WHERE DRIVERID = " + id);
        ps.setObject(1, jobComplete);
        ps.executeUpdate();
        response.sendRedirect("driverHome.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }

%>

