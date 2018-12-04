<%@ page language="java" 
         contentType="text/html; charset=windows-1256"
         pageEncoding="windows-1256"
         import="obj.UserBean"
         import="java.sql.DriverManager"
         import="java.sql.ResultSet"
         import="java.sql.Statement"
         import="java.sql.Connection"
         %>
<!DOCTYPE html>

<html>
    <head>
        <link rel="stylesheet" href="primaryStyle.css">

        <title> Jobs </title>
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
                padding: 10px 15px;
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
                        userType = cookie.getValue();

                    }
                    
                }
            } else {
                sessionID = session.getId();
            }
            if(userType.equals("HeadOffice")){
                System.out.println("Welcome admin");

            }else{
                System.out.println("You are not an admin.. GET OUT!");
                response.sendRedirect("index.html");    
            }
  
        %>

        <ul>
            <li><a href="headOfficeHome.jsp">Home</a></li>
            <li><a href="customers.jsp">View Customers</a></li>
            <li><a class="active" href="drivers.jsp">View Drivers</a></li>
            <li><a href="turnover.jsp">View Turnover</a></li>
            <li><a href="completedJobs.jsp">Completed Jobs</a></li>
            <li style="float:right" ><a><%=userName%></a></li>
        </ul>
        <div class="subHeader">
            <form action="LogoutServlet" method="post">
                <input style="float:right" class="ButtonSubmit" type="submit" value="Logout" >
            </form>
        </div><br>
        <a class="button" href='drivers.jsp' role="button">Go back</a><br><br>

        <h2 align="center">BOOKING INFORMATION</h2><br>


        <%
    
            String driverName = "org.apache.derby.jdbc.ClientDriver";
            String connectionUrl = "jdbc:derby://localhost:1527/userlogin";
            String userId = "pass";
            String password = "pass";

            String id = request.getParameter("d");
            String isD = request.getParameter("j");
            boolean isDriving = Boolean.getBoolean(isD);
            int number = Integer.parseInt(id);
    
            System.out.println(id + " " + isDriving);
    
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
                        <td><b>ID</b></td>
                        <td><b>Start Time</b></td>
                        <td><b>End Time</b></td>
                        <td><b>Customer ID</b></td>
                        <td><b>Ref</b></td>
                        <td><b>Distance</b></td>
                        <td><b>Amount</b></td>
                        <td><b>When?</b></td>
                        <td><b>Complete?</b></td>
                    </tr>
                </table>
                </<div>
                    <%
                    try{ 
                    connection = DriverManager.getConnection(connectionUrl, userId, password);
                    statement=connection.createStatement();
                    String sql=null;
                    if(isDriving==false){
                        sql ="SELECT * FROM PASS.BOOKING_TABLE WHERE DRIVERID="+id+"AND JOBCOMPLETED="+false;
                    }
                    resultSet = statement.executeQuery(sql);
                    while(resultSet.next()){
                    %>
                    <div id="tbl-content">
                        <table>
                            <tr>
                                <td><%=resultSet.getString("driverID") %></td>
                                <td><%=resultSet.getString("StartTime") %></td>
                                <td><%=resultSet.getString("endTime") %></td>
                                <td><%=resultSet.getString("CustomerId") %></td>
                                <td><%=resultSet.getString("Bookingreference") %></td>
                                <td><%=resultSet.getString("Distanceinmiles") %></td>
                                <td><%=resultSet.getString("Paymentamount") %></td>
                                <td><%=resultSet.getString("PaymentTime") %></td>
                                <td><%=resultSet.getString("jobcompleted") %></td>
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
                    </body>
                    </html>

