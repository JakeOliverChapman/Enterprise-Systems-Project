/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import static java.lang.Integer.parseInt;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpSession;
import model.ConnectionManager;

/**
 *
 * @author TomVM & jonasarud & CJ
 * https://developers.google.com/maps/documentation/distance-matrix/intro#DistanceMatrixRequests
 *
 */
public class GoogleMapsServlet extends HttpServlet {

    private static String api = "AIzaSyC30fCnCqt0kI4tdOqRMm4mg0kW5oe1tGo";
    static Connection currentCon = null;
    static ResultSet rs = null;
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
    private static final int mileageRate = 2;
    private static final int flatRate = 10;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String ori = request.getParameter("origins");
        String desti = request.getParameter("destinations");
        String a = ori.replace(' ', '-');
        String b = desti.replace(' ', '-');
        System.out.println(ori + " : " + a);
        System.out.println(desti + " : " + b);
        URL url = new URL("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=" + a + ",UK&destinations=" + b + ",UK&key=" + api);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.connect();

        BufferedReader in = new BufferedReader(
                new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer content = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            content.append(inputLine);
        }
        in.close();
        con.disconnect();

        JsonObject jsonObject = new JsonParser().parse(content.toString()).getAsJsonObject();

        String dest = jsonObject.get("destination_addresses").getAsString();
        String origin = jsonObject.get("origin_addresses").getAsString();
        String time = jsonObject.getAsJsonArray("rows").get(0).getAsJsonObject().get("elements").getAsJsonArray().get(0).getAsJsonObject().get("duration").getAsJsonObject().get("text").getAsString();
        String distance = jsonObject.getAsJsonArray("rows").get(0).getAsJsonObject().get("elements").getAsJsonArray().get(0).getAsJsonObject().get("distance").getAsJsonObject().get("value").getAsString();
        int dist = parseInt(distance);
        double km = dist * 0.001;
        System.out.println(km);
        float miles = (int) Math.round(km * 0.62137);
        System.out.println(miles);
        Statement stmt = null;
        String pickupTime = request.getParameter("pickupTime");
        pickupTime = pickupTime.replace("T", " ");
        pickupTime = pickupTime + ":00";
        System.out.println(pickupTime);

//        Cookie[] cookies = request.getCookies();
//        if (cookies != null) {
//            for (Cookie cookie : cookies) {
//                if (cookie.getName().equals("userId")) {
//                    System.out.println(cookie.getValue());
//                    userID = Integer.parseInt(cookie.getValue());
//                    System.out.println("USER ID: " + userID);
//                }
//            }
//        }
        int userID = -1;
        HttpSession session = request.getSession(false);
        String userIDtemp = (String) session.getAttribute("userid");
        userID = Integer.parseInt(userIDtemp);
        System.out.println(userID);

        try {
            String query = "insert into PASS.BOOKING_TABLE (DRIVERID,STARTTIME,ENDTIME,CUSTOMERID,BOOKINGREFERENCE,DISTANCEINMILES,PAYMENTAMOUNT,PAYMENTTIME,JOBCOMPLETED) values (?,?,?,?,?,?,?,?,?)";

            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            double totalCost = 0;
            PreparedStatement ps = currentCon.prepareStatement(query); // generates sql query
            int driverId = 0;
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            String ref = Long.toHexString(Double.doubleToLongBits(Math.random()));
            ps.setInt(1, driverId);
            ps.setString(2, pickupTime);
            ps.setString(3, pickupTime);
            ps.setInt(4, userID);
            ps.setString(5, ref);
            ps.setDouble(6, miles);
            // Calculate total journey cost
            if (miles < 5) {
                totalCost = flatRate;
            } else {
                totalCost = flatRate + (miles * mileageRate);
            }
            ps.setDouble(7, totalCost);
            ps.setTimestamp(8, timestamp);
            ps.setBoolean(9, false);

            ps.executeUpdate(); // execute it on test database
            System.out.println("successfuly inserted job to database");
            ps.close();
            currentCon.close();
            response.sendRedirect("customerHome.jsp");
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
