import Utility.Database;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int proudctID = Integer.parseInt(req.getParameter("productID"));

        PreparedStatement statement;
        Connection connection;

        try {
            connection = Database.getConnection();

            statement = connection.prepareStatement("DELETE FROM products WHERE id = ?");
            statement.setInt(1, proudctID);

            statement.execute();

            res.sendRedirect("dashboard.jsp");
        }
        catch (SQLException e) {
            req.setAttribute("isError", true);
            req.setAttribute("errorMessage", "Unable to delete the product");

            RequestDispatcher dispatcher = req.getRequestDispatcher("dashboard.jsp");
            dispatcher.forward(req, res);
        }
    }
}