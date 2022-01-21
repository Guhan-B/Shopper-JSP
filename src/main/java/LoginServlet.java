import Utility.Database;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import java.io.IOException;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");


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
            statement = connection.prepareStatement("SELECT * FROM users WHERE email = ?");;

            statement.setString(1, email);

            result = statement.executeQuery();

            if(result.next()) {
                String savedPassword = result.getString(5);
                int userId = result.getInt(1);
                int userType = result.getInt(6);

                if(hashedPassword.equalsIgnoreCase(savedPassword)) {
                    HttpSession session = req.getSession();

                    session.setAttribute("userId", userId);
                    session.setAttribute("userType", userType);

                    if(userType == 0) {
                        res.sendRedirect("catalouge.jsp");
                    }
                    else {
                        res.sendRedirect("dashboard.jsp");
                    }
                }
                else {
                    req.setAttribute("isError", true);
                    req.setAttribute("errorMessage", "Password does not match");

                    RequestDispatcher dispatcher = req.getRequestDispatcher("login.jsp");
                    dispatcher.forward(req, res);
                }
            }
            else {
                req.setAttribute("isError", true);
                req.setAttribute("errorMessage", "Email address is not registered");

                RequestDispatcher dispatcher = req.getRequestDispatcher("login.jsp");
                dispatcher.forward(req, res);
            }
        } catch (SQLException | NoSuchAlgorithmException e) {
            req.setAttribute("isError", true);
            req.setAttribute("errorMessage", "Unable to login. Try Again later");

            RequestDispatcher dispatcher = req.getRequestDispatcher("login.jsp");
            dispatcher.forward(req, res);
        }
    }
}
