package com;

import java.io.IOException;
import javax.servlet.ServletContext;
import obj.UserBean;
import obj.UserDAO;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            UserBean user = new UserBean();
            user.setEmail(request.getParameter("un"));
            user.setPassword(request.getParameter("pw"));
            user = UserDAO.login(user);

            if (user.isValid()) {
                ServletContext application = getServletConfig().getServletContext();  
                String data = (String) application.getAttribute("increment");
                System.out.println(data);
                
                HttpSession session = request.getSession();
                session.setAttribute("user", "user");
                session.setAttribute("userid", user.getID());
                //set session expiry to 30 mins
                session.setMaxInactiveInterval(30 * 60);
                Cookie userName = new Cookie("userName", user.getEmail());
                Cookie userType = new Cookie("userType", user.getType());
                Cookie userID = new Cookie("userID", user.getID());
                // set user cookies
                userName.setMaxAge(30 * 60);
                response.addCookie(userName);
                response.addCookie(userType);
                response.addCookie(userID);

                if (null != user.getType()) {
                    switch (user.getType()) { // Redirect to user home
                        case "Driver":
                            response.sendRedirect("driverHome.jsp");
                            break;
                        case "Customer":
                            response.sendRedirect("customerHome.jsp");
                            break;
                        case "HeadOffice":
                            response.sendRedirect("headOfficeHome.jsp");
                            break;
                        default:
                            break;
                    }
                }
            } else {
                response.sendRedirect("invalidLogin.jsp"); //error page 
            }
        } catch (IOException theException) {
            System.out.println(theException);
        }
    }
}
