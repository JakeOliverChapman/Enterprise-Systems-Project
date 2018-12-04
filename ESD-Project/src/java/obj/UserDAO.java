package obj;

import model.ConnectionManager;
import java.sql.*;

public class UserDAO {

    static Connection currentCon = null;
    static ResultSet rs = null;

    public static UserBean login(UserBean bean) {

        // preparing some objects for connection 
        Statement stmt = null;
        String email = bean.getEmail();
        String password = bean.getPassword();

        // Create query by user type
        String customerQuery
                = "SELECT CUSTOMERID, FIRSTNAME, LASTNAME, EMAIL,PASSWORD FROM PASS.CUSTOMER_TABLE WHERE EMAIL='"
                + email + "' AND PASSWORD='"
                + password + "'";

        String headOfficeQuery
                = "SELECT ADMINID, FIRSTNAME, LASTNAME, EMAIL,PASSWORD FROM PASS.HEAD_OFFICE WHERE EMAIL='"
                + email + "' AND PASSWORD='"
                + password + "'";

        String driverQuery
                = "SELECT DRIVERID, FIRSTNAME, LASTNAME, EMAIL,PASSWORD FROM PASS.DRIVER_TABLE WHERE EMAIL='"
                + email + "' AND PASSWORD='"
                + password + "'";
        try {
            boolean more = false;
            String type = null;
            String ID = null;

            // Connect to DB
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();

            // Find user / type
            if (!more) {
                rs = stmt.executeQuery(customerQuery);
                more = rs.next();
                type = "Customer";
                if (more) {
                    ID = rs.getString("CUSTOMERID");
                }
            }

            if (!more) {
                rs = stmt.executeQuery(headOfficeQuery);
                more = rs.next();
                type = "HeadOffice";
                if (more) {
                    ID = rs.getString("ADMINID");
                }
            }

            if (!more) {
                rs = stmt.executeQuery(driverQuery);
                more = rs.next();
                type = "Driver";
                if (more) {
                    ID = rs.getString("DRIVERID");
                }
            }

            if (!more) {
                // User does not exist
                System.out.println("Sorry, you are not a registered user! Please sign up first");
                bean.setValid(false);
            }

            // If user exists set the isValid variable to true
            if (more) {
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");

                // Assign user session variables
                bean.setFirstName(firstName);
                bean.setLastName(lastName);
                bean.setValid(true);
                bean.setID(ID);
                bean.setType(type);
            }
        } catch (SQLException ex) {
            System.out.println("Log In failed: An Exception has occurred! " + ex);
        } // Some exception handling
        finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                }
                rs = null;
            }

            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                }
                stmt = null;
            }

            if (currentCon != null) {
                try {
                    currentCon.close();
                } catch (SQLException e) {
                }
                currentCon = null;
            }
        }

        return bean;
    }

    public static UserBean register(UserBean bean) {
        return bean;
    }
}
