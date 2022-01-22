import Utility.Checkout;
import Utility.Database;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;


public class PurchaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private void addTableHeader(PdfPTable table) {

        String[] titles = {"Product ID", "Product Name", "Product Quantity", "Product Price"};

        for(String title : titles) {
            PdfPCell header = new PdfPCell();
            header.setBackgroundColor(BaseColor.LIGHT_GRAY);
            header.setBorderWidth(1);
            header.setPhrase(new Phrase(title));
            table.addCell(header);
        }
    }

    private void addRows(PdfPTable table, ArrayList<Checkout> data) {
        for(Checkout p : data) {
            table.addCell(Integer.toString(p.productId));
            table.addCell(p.productName);
            table.addCell(Integer.toString(p.quantity));
            table.addCell(Double.toString(p.price));
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        Statement st;
        Connection connection;
        ArrayList<Checkout> products = new ArrayList<>();

        try {
            req.setAttribute("isError", false);

            connection = Database.getConnection();
            st = connection.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM products");

            Checkout.grandTotal=0;

            while(rs.next()) {
                int productId = rs.getInt(1);
                String productName = rs.getString(2);
                int stock = rs.getInt(4);

                int quantity;
                if(req.getParameter(Integer.toString(productId)) != null) {
                    quantity = Integer.parseInt(req.getParameter(Integer.toString(productId)));
                } else {
                    continue;
                }

                if (quantity > stock) {
                    req.setAttribute("isError", true);
                    req.setAttribute("errorMessage", "Insufficient stocks for " + productName);

                    RequestDispatcher dispatcher = req.getRequestDispatcher("cart.jsp");
                    dispatcher.forward(req, res);

                    return;
                }
            }

            rs = st.executeQuery("SELECT * FROM products");
            Checkout.grandTotal=0;

            while (rs.next()) {
                int productId = rs.getInt(1);
                String productName = rs.getString(2);
                int price = rs.getInt(3);
                int stock = rs.getInt(4);
                int per = rs.getInt(5);

                int quantity;
                if(req.getParameter(Integer.toString(productId)) != null) {
                    quantity = Integer.parseInt(req.getParameter(Integer.toString(productId)));
                } else {
                    continue;
                }

                if (quantity == 0) {
                    continue;
                } else {

                    PreparedStatement statement = connection.prepareStatement("UPDATE products SET stock=? WHERE id=?");
                    statement.setInt(1, stock-quantity);
                    statement.setInt(2, productId);
                    statement.execute();

                    double priceOfOneProduct = price / (double) per;
                    double totalPrice = priceOfOneProduct * quantity;
                    Checkout.grandTotal += totalPrice;
                    Checkout product = new Checkout(productId, productName, quantity, totalPrice);
                    products.add(product);
                }
            }

            double totalPrice = 0;

            for(Checkout p : products) {
                totalPrice += p.price;
            }

            Document document = new Document();
            File invoiceFile = File.createTempFile("shopper_invoice_", ".pdf", new File("D:\\5th Sem\\Java\\Shopper-JSP\\src\\main\\webapp\\WEB-INF\\invoice"));
            String invoiceName = invoiceFile.getName();
            PdfWriter.getInstance(document, new FileOutputStream(invoiceFile));

            PdfPTable table = new PdfPTable(4);
            addTableHeader(table);
            addRows(table, products);

            Paragraph heading = new Paragraph();
            Chunk headingText = new Chunk("Shopper Invoice");

            headingText.setFont(FontFactory.getFont(FontFactory.COURIER, 20, BaseColor.BLACK));
            heading.add(headingText);

            Paragraph footer = new Paragraph();
            Chunk footerText = new Chunk("Total Price: " + totalPrice);

            footerText.setFont(FontFactory.getFont(FontFactory.COURIER, 16, BaseColor.BLACK));
            footer.add(footerText);

            document.open();
            document.add(heading);
            document.add(new Paragraph("\n"));
            document.add(table);
            document.add(new Paragraph("\n"));
            document.add(footer);
            document.close();

            HttpSession session = req.getSession();
            session.removeAttribute("cartProducts");

            req.setAttribute("products", products);
            req.setAttribute("invoice", invoiceName);
            RequestDispatcher dispatcher = req.getRequestDispatcher("invoice.jsp");
            dispatcher.forward(req, res);

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}