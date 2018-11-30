<%-- 
    Document   : addDriver
    Created on : 11-Nov-2018, 17:58:45
    Author     : jonasarud
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
            <link rel="stylesheet" href="primaryStyle.css">

        
             <meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
            <title>Add Driver Page</title>
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
            <div class="mainHeader" align="center">
                Register
            </div>
            <form class="formCenter" role="form" action="RegisterServlet" method="post">
                <input type="text" class="textField" name="fn" placeholder="First name">
                <br>
                <input type="text" class="textField" name="ln" placeholder="Last name">
                <br>
                <input type="text" class="textField" name="un" placeholder="Email address">
                <br>
                <input type="password" class="textField" name ="pw" placeholder="Password">
                <br>
                <input type="text" class="textField" name="pw1" placeholder="Confirm password">
                <br>
                <input  type="text" class="textField dateField" name="date" placeholder="Date of birth" onfocusin="(this.type='date')" onfocusout="(this.type='text')">
                <br><br>
                <button type="submit" class="submitButton"> Create account </button>
            </form>
        </div></body>
</html>
