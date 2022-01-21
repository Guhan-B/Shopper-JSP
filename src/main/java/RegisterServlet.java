import Utility.Database;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String fullName = req.getParameter("full-name");
        String email = req.getParameter("email");
        String mobileNumber = req.getParameter("mobile-number");
        String password = req.getParameter("password");
        String dob = req.getParameter("dob");

        PreparedStatement statement;
        Connection connection;
        ResultSet result;

        try {

            MessageDigest ms = MessageDigest.getInstance("SHA-224");
            ms.update(password.getBytes());
            byte[] r = ms.digest();
            StringBuilder sb = new StringBuilder();

            for(byte b: r) {
                sb.append(String.format("%02x", b));
            }

            String hashedPassword = sb.toString();

            connection = Database.getConnection();

            statement = connection.prepareStatement("SELECT COUNT(*) FROM users WHERE email = ?");
            statement.setString(1, email);

            result = statement.executeQuery();
            result.next();

            if(result.getInt(1) > 0) {
                req.setAttribute("isError", true);
                req.setAttribute("errorMessage", "Email already taken");

                RequestDispatcher dispatcher = req.getRequestDispatcher("register.jsp");
                dispatcher.forward(req, res);
            }
            else {
                statement = connection.prepareStatement("INSERT INTO users(fullName, email, mobileNumber, password, " +
                        "userType, dob) VALUES(?, ?, ?, ?, 0, Cast(? as datetime))");
                statement.setString(1, fullName);
                statement.setString(2, email);
                statement.setString(3, mobileNumber);
                statement.setString(4, hashedPassword);
                statement.setString(5,dob);

                statement.execute();

                res.sendRedirect("login.jsp");
            }
        } catch (SQLException | NoSuchAlgorithmException e) {
            System.out.println(e);
            req.setAttribute("isError", true);
            req.setAttribute("errorMessage", "Unable to register. Try Again later");

            RequestDispatcher dispatcher = req.getRequestDispatcher("register.jsp");
            dispatcher.forward(req, res);
        }
    }
}
