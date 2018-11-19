package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GoogleMapsServlet extends HttpServlet {

    // private static String api = "AIzaSyC30fCnCqt0kI4tdOqRMm4mg0kW5oe1tGo";
    // private static String origins = "";
    // private static String destinations = "";
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String api = "AIzaSyC30fCnCqt0kI4tdOqRMm4mg0kW5oe1tGo";
        String origins = request.getParameter("origins");
        String destinations = request.getParameter("destinations");

        if (origins.isEmpty() || destinations.isEmpty()) {
            RequestDispatcher rd = request.getRequestDispatcher("customerHome.jsp");
            out.println("<font color=red>Please fill both the fields</font>");
            rd.include(request, response);
        } else {
            try {
                URL url = new URL("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=" + origins + ",UK&destinations=" + destinations + ",UK&key=" + api);
            } catch (MalformedURLException ex) {
            }
        }
    }
}
