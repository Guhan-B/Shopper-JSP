import Utility.Database;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;
import java.sql.*;

public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productID"));
        String productName = req.getParameter("product-name");
        String productUnit = req.getParameter("product-unit");
        int productCost = Integer.parseInt(req.getParameter("product-cost"));
        int productStock = Integer.parseInt(req.getParameter("product-stock"));
        int costPer = Integer.parseInt(req.getParameter("cost-per"));

        PreparedStatement statement;
        Connection connection;

        try {
            connection = Database.getConnection();

            statement = connection.prepareStatement("UPDATE products SET name=?,price=?," +
                    "stock=?, per=?, unit=? WHERE id=?");
            statement.setString(1, productName);
            statement.setInt(2, productCost);
            statement.setInt(3, productStock);
            statement.setInt(4, costPer);
            statement.setString(5, productUnit);
            statement.setInt(6,productId);

            statement.execute();

            res.sendRedirect("dashboard.jsp");
        }
        catch (SQLException e) {
            req.setAttribute("isError", true);
            req.setAttribute("errorMessage", "Unable to edit product");

            RequestDispatcher dispatcher = req.getRequestDispatcher("dashboard.jsp");
            dispatcher.forward(req, res);
        }
    }
}