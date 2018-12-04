<%@ page language="java"
         contentType="text/html; charset=windows-1256"
         pageEncoding="windows-1256"
         import="obj.UserBean"
         %>

<html>
    <head>
        <link rel="stylesheet" href="primaryStyle.css">
        <title> Customer Home Page </title>
        <style>
            
        /* for custom scrollbar for webkit browser*/

        ::-webkit-scrollbar {
            width: 6px;
        } 
        ::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
        } 
        ::-webkit-scrollbar-thumb {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
        }
        a.button:link, a.button:visited {
            background-color: #f44336;
            color: white;
            padding: 14px 25px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }


        a.button:hover, a.button:active {
            background-color: red;
        }

        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
        }

        li {
            float: left;
        }

        li a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        li a:hover:not(.active) {
            background-color: #111;
        }

        .active {
            background-color: #4CAF50;
        }
        input.ButtonSubmit{
            background-color: #f44336;
            color: white;
            padding: 14px 25px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            border:0px;
        }
        </style>
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
        <ul>
            <li><a href="customerHome.jsp">View bookings</a></li>
            <li><a class="active" href="bookACab.jsp">Book</a></li>
            <li style="float:right" ><a><%=userName%></a></li>
        </ul>
        <div class="container">
            <div class="subHeader">
                                <form action="LogoutServlet" method="post">
                    <input style="float:right" class="ButtonSubmit" type="submit" value="Logout" >
                </form>
            </div><br>
                Welcome Customer <%=userName%>! <br>

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
                    <button type="submit" class="submitButton"> Book Cab </button>
                </div>
            </form>

            <br>

        </div>
    </body>
</html>