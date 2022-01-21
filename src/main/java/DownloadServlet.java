import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

public class DownloadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            PrintWriter out = res.getWriter();
            String name = req.getParameter("value");
            String path = getServletContext().getRealPath("D:\\\\5th Sem\\\\Java\\\\Shopper\" +\n" +
                    "                    \"-JSP\\\\invoice\\" + name);

            res.setContentType("APPLICATION/OCTET-STREAM");
            res.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");

            FileInputStream ins = new FileInputStream(path);

            int i;

            while ((i = ins.read()) != -1) {
                out.write(i);
            }

            ins.close();
            out.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
