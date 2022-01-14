import Utility.Database;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;
import java.sql.*;

public class AddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String productName = req.getParameter("product-name");
        String productUnit = req.getParameter("product-unit");
        int productCost = Integer.parseInt(req.getParameter("product-cost"));
        int productStock = Integer.parseInt(req.getParameter("product-stock"));
        int costPer = Integer.parseInt(req.getParameter("cost-per"));

        PreparedStatement statement;
        Connection connection;

        try {
            connection = Database.getConnection();

            statement = connection.prepareStatement("INSERT INTO products(name, price, stock, per, unit) VALUES(?, ?, ?, ?, ?)");
            statement.setString(1, productName);
            statement.setInt(2, productCost);
            statement.setInt(3, productStock);
            statement.setInt(4, costPer);
            statement.setString(5, productUnit);

            statement.execute();

            res.sendRedirect("dashboard.jsp");
        }
        catch (SQLException e) {
            req.setAttribute("isError", true);
            req.setAttribute("errorMessage", "Unable to add product");

            RequestDispatcher dispatcher = req.getRequestDispatcher("dashboard.jsp");
            dispatcher.forward(req, res);
        }
    }
}