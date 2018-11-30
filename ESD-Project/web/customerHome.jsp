<%-- 
    Document   : customerHome
    Created on : 15-Nov-2018, 20:52:47
    Author     : Will
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
                Welcome Customer <%=userName%>! Login successful, Your Session ID=<%=sessionID%> <br><br>

                Book a taxi:
            </div>

            <br>
            <form class="formCenter" role="form" action="GoogleMapsServlet" method="post">
                <input type="text" class="textField" name ="origins" placeholder="Pick up location">
                <br>
                <input type="text" class="textField" name ="destinations" placeholder="Destination">
                <br>
                <input type="datetime-local" class="textField" name ="pickupTime" placeholder="">
                <br><br>
                <div class="buttonDiv">
                    <button type="submit" class="submitButton"> Get Quote </button>
                </div>
            </form>

            <br>
            <form action="LogoutServlet" method="post">
                <input type="submit" value="Logout" >
            </form>

        </div>
    </body>
</html>




