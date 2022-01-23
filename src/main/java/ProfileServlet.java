import Utility.Database;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();

        int userId = (int) session.getAttribute("userId");
        long mobileNumber = Long.parseLong(req.getParameter("mobile-number"));

        String fullName = req.getParameter("full-name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String dateOfBirth = req.getParameter("dob");

        try {
            Connection connection = Database.getConnection();
            PreparedStatement statement = connection.prepareStatement("UPDATE users SET fullName = ?, mobileNumber = ?, email = ?, dob = Cast(? as DATETIME) WHERE id = ?");

            statement.setString(1, fullName);
            statement.setLong(2, mobileNumber);
            statement.setString(3, email);
            statement.setString(4, dateOfBirth);
            statement.setInt(5, userId);
            statement.execute();

            if(password.length() > 0) {
                String hashedPassword = Database.hashPassword(password);
                statement = connection.prepareStatement("UPDATE users SET password = ? WHERE id = ?");

                statement.setString(1, hashedPassword);
                statement.setInt(2, userId);
                statement.execute();
            }

            res.sendRedirect("catalouge.jsp");
        } catch (SQLException | NoSuchAlgorithmException e) {
            e.printStackTrace();

            req.setAttribute("isError", true);
            req.setAttribute("errorMessage", "Unable to save. Try Again");

            RequestDispatcher dispatcher = req.getRequestDispatcher("profile.jsp");
            dispatcher.forward(req, res);
        }
    }
}