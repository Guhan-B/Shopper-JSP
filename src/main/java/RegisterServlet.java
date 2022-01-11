import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;
import java.sql.*;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String fullName = req.getParameter("full-name");
        String email = req.getParameter("email");
        String mobileNumber = req.getParameter("mobile-number");
        String password = req.getParameter("password");

        PreparedStatement statement;
        Connection connection;
        ResultSet result;

        try {
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
                statement = connection.prepareStatement("INSERT INTO users(fullName, email, mobileNumber, password, userType) VALUES(?, ?, ?, ?, 0)");
                statement.setString(1, fullName);
                statement.setString(2, email);
                statement.setString(3, mobileNumber);
                statement.setString(4, password);

                statement.execute();

                res.sendRedirect("login.jsp");
            }
        } catch (SQLException e) {
            req.setAttribute("isError", true);
            req.setAttribute("errorMessage", "Unable to register. Try Again later");

            RequestDispatcher dispatcher = req.getRequestDispatcher("register.jsp");
            dispatcher.forward(req, res);
        }
    }
}
