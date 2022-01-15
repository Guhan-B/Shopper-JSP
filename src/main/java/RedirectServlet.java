import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;



public class RedirectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        res.sendRedirect("catalouge.jsp");
    }
}