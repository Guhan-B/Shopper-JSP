import Utility.Checkout;
import Utility.Database;
import Utility.Variables;
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

    private String generateInvoice(ArrayList<Checkout> products, double grandTotal) throws IOException, DocumentException {
        Document document = new Document();
        File invoiceFile = File.createTempFile("shopper_invoice_", ".pdf", new File(Variables.invoicePath));
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
        Chunk footerText = new Chunk("Total Price: " + grandTotal);

        footerText.setFont(FontFactory.getFont(FontFactory.COURIER, 16, BaseColor.BLACK));
        footer.add(footerText);

        document.open();
        document.add(heading);
        document.add(new Paragraph("\n"));
        document.add(table);
        document.add(new Paragraph("\n"));
        document.add(footer);
        document.close();

        return invoiceName;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        Statement statement;
        Connection connection;
        ArrayList<Checkout> products = new ArrayList<>();
        HttpSession session = req.getSession();
        double grandTotal = 0.0;

        try {
            req.setAttribute("isError", false);

            connection = Database.getConnection();
            statement = connection.createStatement();
            ResultSet result = statement.executeQuery("SELECT * FROM products");

            while(result.next()) {
                int productId = result.getInt(1);
                int stock = result.getInt(4);
                int quantity;

                String productName = result.getString(2);

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

            result = statement.executeQuery("SELECT * FROM products");

            while (result.next()) {
                int quantity;
                int productId = result.getInt(1);
                int price = result.getInt(3);
                int stock = result.getInt(4);
                int per = result.getInt(5);

                String productName = result.getString(2);

                if(req.getParameter(Integer.toString(productId)) != null) {
                    quantity = Integer.parseInt(req.getParameter(Integer.toString(productId)));
                } else {
                    continue;
                }

                if (quantity >= 0) {
                    PreparedStatement prepStatement = connection.prepareStatement("UPDATE products SET stock=? WHERE id=?");
                    prepStatement.setInt(1, stock-quantity);
                    prepStatement.setInt(2, productId);
                    prepStatement.execute();

                    double priceOfOneProduct = price / (double) per;
                    double totalPrice = priceOfOneProduct * quantity;

                    grandTotal += totalPrice;

                    products.add(new Checkout(productId, productName, quantity, totalPrice));
                }
            }

            session.removeAttribute("cartProducts");
            session.removeAttribute("cartProductsId");

            String invoiceName = generateInvoice(products, grandTotal);
            Date now = new Date(System.currentTimeMillis());

            try {
                PreparedStatement prepStatement = connection.prepareStatement("INSERT INTO history(userId, grandTotal, purchaseDate, invoiceName) VALUES(?, ?, ?, ?)");
                prepStatement.setInt(1, (int) session.getAttribute("userId"));
                prepStatement.setDouble(2, grandTotal);
                prepStatement.setDate(3, now);
                prepStatement.setString(4, invoiceName);

                prepStatement.execute();
            }
            catch (Exception e) {
                e.printStackTrace();
            }

            req.setAttribute("products", products);
            req.setAttribute("invoice", invoiceName);
            req.setAttribute("total", grandTotal);

            RequestDispatcher dispatcher = req.getRequestDispatcher("invoice.jsp");
            dispatcher.forward(req, res);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}