<%-- 
    Document   : taxiBooked
    Created on : 25-Nov-2018, 19:59:16
    Author     : Oos
--%>

<%@ page language="java" 
         contentType="text/html; charset=windows-1256"
         pageEncoding="windows-1256"
         import="obj.UserBean"
         %>

<html>
    <head>
        <link rel="stylesheet" href="primaryStyle.css">
        <title> Customer Home Page </title>
    </head>

    <body>
        <%
            //allow access only if session exists
            String user = null;
            if (session.getAttribute("user") == null) {
                response.sendRedirect("index.html");
            } else {
                user = (String) session.getAttribute("user");
            }

            String userName = null;
            String sessionID = null;
            String userType = null;

            Cookie[] cookies = request.getCookies(); // Assign user variables
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("userName")) {
                        userName = cookie.getValue();
                    }
                    if (cookie.getName().equals("JSESSIONID")) {
                        sessionID = cookie.getValue();
                    }
                    if (cookie.getName().equals("userType")) {
                        userType = cookie.getName();
                    }
                }
            } else {
                sessionID = session.getId();
            }
        %>
        <div class="container">
            <div class="subHeader">
                Welcome Customer <%=userName%>! <br>

You have successfully booked a taxi at -. You will be picked up at - and arrive at -.

        </div>
    </body>
</html>