<%-- 
    Document   : edit
    Created on : 30-Nov-2018, 13:53:26
    Author     : Willi
--%>

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

        <title> View Drivers </title>

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
            if (userType.equals("HeadOffice")) {
                System.out.println("Welcome admin");

            } else {
                System.out.println("You are not an admin.. GET OUT!");
                response.sendRedirect("index.html");
            }

        %>

        <ul>
            <li><a href="headOfficeHome.jsp">Home</a></li>
            <li><a href="customers.jsp">Edit Customer</a></li>
            <li><a class="active" href="drivers.jsp">Edit Drivers</a></li>
            <li style="float:right" ><a><%=userName%></a></li>
        </ul>
        <div class="subHeader">
            <form action="LogoutServlet" method="post">
                <input style="float:right" class="ButtonSubmit" type="submit" value="Logout" >
            </form>
        </div><br>
        <a class="button" href='drivers.jsp' role="button">Go back</a><br><br>
        <h2 align="center">DRIVER INFORMATION</h2><br>


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
                        <td><b>ID</b></td>
                        <td><b>First Name</b></td>
                        <td><b>Last Name</b></td>
                        <td><b>Email</b></td>
                        <td><b>Password</b></td>
                        <td><b>Date Of Birth</b></td>
                        <td><b>Is Driving</b></td>
                        <td><b>Action</b></td>
                    </tr>
                </table>
            </div>
            <%
                try {
                    connection = DriverManager.getConnection(connectionUrl, userId, password);
                    statement = connection.createStatement();
                    int id = Integer.parseInt(request.getParameter("d"));
                    String sql = "SELECT * FROM PASS.DRIVER_TABLE WHERE DRIVERID=" + id;
                    resultSet = statement.executeQuery(sql);

                    
                    //resultSet.next();
                    System.out.println(id);
                    System.out.println(resultSet);
                    while (resultSet.next()) {
            %>
            <div id="tbl-content">
                <table>
                    <tr>
                    <FORM ACTION="update.jsp?d=<%=resultSet.getString("driverID")%>&j=<%="Driver"%>" METHOD="POST">
                        <td><%=resultSet.getString("driverID")%></td>
                        <td><input type="text" class="textField" name="fn" value="<%=resultSet.getString("firstName")%>" default_value="test"></td>
                        <td><input type="text" class="textField" name="ln" value="<%=resultSet.getString("lastName")%>"></td>
                        <td><input type="text" class="textField" name="em" value="<%=resultSet.getString("email")%>"></td>
                        <td><input type="text" class="textField" name="pw" value="<%=resultSet.getString("password")%>"></td>
                        <td><input type="text" class="textField" name="dob" value="<%=resultSet.getString("dateOfBirth")%>"></td>
                        <td><%=resultSet.getString("isDriving")%></td>
                        <td><INPUT TYPE="SUBMIT" value="Submit"></td>
                    </form>
                    </tr>
                </table>
            </div>
            <%
                   }
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("Driver not found");
                }
            %>


        </section>

    </body>

</html>