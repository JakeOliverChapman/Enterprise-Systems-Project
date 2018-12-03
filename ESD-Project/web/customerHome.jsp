<%-- 
    Document   : taxiBooked
    Created on : 25-Nov-2018, 19:59:16
    Author     : Oos
--%>

<%@page import="java.sql.DriverManager"%>
<%@ page language="java" 
         contentType="text/html; charset=windows-1256"
         pageEncoding="windows-1256"
         import="obj.UserBean"
         import="java.sql.DriverManager"
         import="java.sql.ResultSet"
         import="java.sql.Statement"
         import="java.sql.Connection"
         %>

<html>
    <head>
        <link rel="stylesheet" href="primaryStyle.css">
        <title> Customer Home Page </title>
    </head>
    <style>

        h1{
            font-size: 30px;
            color: #fff;
            text-transform: uppercase;
            font-weight: 300;
            text-align: center;
            margin-bottom: 15px;
        }
        table{
            width:100%;
            table-layout: fixed;
        }
        table.tbl-header{
            background-color: rgba(255,255,255,0.3);
        }
        table.tbl-content{
            height:300px;
            overflow-x:auto;
            margin-top: 0px;
            border: 1px solid rgba(255,255,255,0.3);
        }
        th{
            padding: 20px 15px;
            text-align: left;
            font-weight: 500;
            font-size: 12px;
            color: #fff;
            text-transform: uppercase;
        }
        td{
            padding: 15px;
            text-align: left;
            vertical-align:middle;
            font-weight: 300;
            font-size: 15px;
            color: #fff;
            border-bottom: solid 1px rgba(255,255,255,0.1);
        }



        body{
            background: -webkit-linear-gradient(left, #252228, #252228);
            background: linear-gradient(to right, #252228, #252228);
            font-family: 'Roboto', sans-serif;
        }
        section{
            margin: 50px;
        }

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
                int Id = -1;
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
                        if (cookie.getName().equals("userId")) {
                            Id = Integer.parseInt(cookie.getValue());
                        }
                    }
                } else {
                    sessionID = session.getId();
                }
            %>
            <ul>
                <li><a class="active" href="customerHome.jsp">View bookings</a></li>
                <li><a href="bookACab.jsp">Book</a></li>
                <li style="float:right" ><a><%=userName%></a></li>
            </ul>
            
            <div class="subHeader">
                <form action="LogoutServlet" method="post">
                    <input style="float:right" class="ButtonSubmit" type="submit" value="Logout" >
                </form>
            </div><br>
            <div class="container">
                <div class="subHeader">
                    <%
                        String driverName = "org.apache.derby.jdbc.ClientDriver";
                        String connectionUrl = "jdbc:derby://localhost:1527/userlogin";
                        String userId = "pass";
                        String password = "pass";

                        try {
                            Class.forName(driverName);
                        } catch (ClassNotFoundException e) {
                            e.printStackTrace();
                        }

                        Connection connection = null;
                        Statement statement = null;
                        ResultSet resultSet = null;
                    %>
                    <section>
                        <div id="tbl-header">
                            <table>
                                <tr>
                                    <td><b>Booking Reference</b></td>
                                    <td><b>Start</b></td>
                                    <td><b>Distance (Miles)</b></td>
                                    <td><b>Amount</b></td>
                                </tr>
                            </table>
                        </div>
                        <%
                            try {
                                connection = DriverManager.getConnection(connectionUrl, userId, password);
                                statement = connection.createStatement();
                                String sql = "SELECT * FROM PASS.BOOKING_TABLE WHERE customerID=" + Id;

                                resultSet = statement.executeQuery(sql);
                                while (resultSet.next()) {
                        %>
                        <div id="tbl-content">
                            <table>
                                <tr>
                                    <td><%=resultSet.getString("bookingreference")%></td>
                                    <td><%=resultSet.getString("starttime")%></td>
                                    <td><%=resultSet.getString("distanceinmiles")%></td>
                                    <td><%=resultSet.getString("paymentamount")%></td>
                                </tr>
                            </table>
                        </div>

                        <%
                                }

                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </section>
                    <br>
                </div>
            </div>
    </body>
</html>