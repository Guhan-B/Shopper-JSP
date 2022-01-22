import Utility.Database;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;
import java.sql.*;

public class VerifyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String userEmail = req.getParameter("email");
        String userDob = req.getParameter("dob");

        PreparedStatement statement;
        Connection connection;
        ResultSet result;

        try {
            connection = Database.getConnection();
            statement = connection.prepareStatement("SELECT * FROM users where email = ?");;

            statement.setString(1, userEmail);

            result = statement.executeQuery();

            if(result.next()) {
                String dob = result.getDate(7).toString();

                if(userDob.equals(dob)){
                    HttpSession session = req.getSession();
                    session.setAttribute("resetPassword",result.getInt(1));
                    res.sendRedirect("reset.jsp");
                }else{
                    req.setAttribute("isError", true);
                    req.setAttribute("errorMessage", "Date of Birth is Incorrect");

                    RequestDispatcher dispatcher = req.getRequestDispatcher("forgot.jsp");
                    dispatcher.forward(req, res);
                }
            }
            else {
                req.setAttribute("isError", true);
                req.setAttribute("errorMessage", "Email address is not registered");

                RequestDispatcher dispatcher = req.getRequestDispatcher("forgot.jsp");
                dispatcher.forward(req, res);
            }
        } catch (SQLException e) {
            req.setAttribute("isError", true);
            req.setAttribute("errorMessage", "Unable to verify. Try Again later");

            RequestDispatcher dispatcher = req.getRequestDispatcher("forgot.jsp");
            dispatcher.forward(req, res);
        }
    }
}
