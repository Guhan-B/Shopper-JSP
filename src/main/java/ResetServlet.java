import Utility.Database;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class ResetServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String password = req.getParameter("password");
        String cpassword = req.getParameter("cpassword");

        PreparedStatement statement;
        Connection connection;
        ResultSet result;

        try {

            connection = Database.getConnection();
            if(password.equals(cpassword)){

                MessageDigest ms = MessageDigest.getInstance("SHA-224");
                ms.update(password.getBytes());
                byte[] r = ms.digest();
                StringBuilder sb = new StringBuilder();

                for(byte b: r) {
                    sb.append(String.format("%02x", b));
                }

                String hashedPassword = sb.toString();

                statement = connection.prepareStatement("Update users set password= ? where id = ?");

                statement.setString(1, hashedPassword);
                statement.setInt(2, id);

                statement.executeUpdate();

                HttpSession session = req.getSession();
                session.removeAttribute("resetPassword");

                res.sendRedirect("login.jsp");
            }
            else {
                req.setAttribute("isError", true);
                req.setAttribute("errorMessage", "Password doesn't match");

                RequestDispatcher dispatcher = req.getRequestDispatcher("reset.jsp");
                dispatcher.forward(req, res);
            }
        } catch (SQLException | NoSuchAlgorithmException e) {
            System.out.println(e);
            req.setAttribute("isError", true);
            req.setAttribute("errorMessage", "Unable to Reset. Try Again later");

            RequestDispatcher dispatcher = req.getRequestDispatcher("reset.jsp");
            dispatcher.forward(req, res);
        }
    }
}
