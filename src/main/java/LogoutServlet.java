import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        session.removeAttribute("userId");
        session.removeAttribute("userType");
        session.invalidate();
        res.sendRedirect("index.jsp");
    }
}