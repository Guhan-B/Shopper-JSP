import Utility.CheckOut;
import Utility.Database;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;


public class PurchaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        Statement st;
        Connection connection;
        ArrayList<CheckOut> products = new ArrayList<>();

        try {
            connection = Database.getConnection();
            st = connection.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM products");

            CheckOut.grandTotal=0;

            while (rs.next()) {
                int productId = rs.getInt(1);
                String productName = rs.getString(2);
                int price = rs.getInt(3);
                int stock = rs.getInt(4);
                int per = rs.getInt(5);
                int quantity = Integer.parseInt(req.getParameter(Integer.toString(productId)));
                if (quantity > stock) {
                    throw new Exception("Stock is not sufficient");
                } else if (quantity == 0) {
                    continue;
                } else {
                    double priceOfOneProduct = price / (double) per;
                    double totalPrice = priceOfOneProduct * quantity;
                    CheckOut.grandTotal += totalPrice;
                    CheckOut product = new CheckOut(productId, productName, quantity, totalPrice);
                    products.add(product);
                }
            }

            req.setAttribute("products", products);
            RequestDispatcher dispatcher = req.getRequestDispatcher("invoice.jsp");
            dispatcher.forward(req, res);

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}