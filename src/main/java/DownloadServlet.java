import Utility.Variables;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

public class DownloadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int BYTES_DOWNLOAD = 1024;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            res.setContentType("application/pdf");
            res.setHeader("Content-Disposition", "attachment;filename=" + req.getParameter("value"));

            File file =
                    new File(Variables.invoicePath + "\\"
                            + req.getParameter("value"));
            FileInputStream in = new FileInputStream(file);

            int read = 0;
            byte[] bytes = new byte[BYTES_DOWNLOAD];

            OutputStream out = res.getOutputStream();

            while((read = in.read(bytes))!= -1){
                out.write(bytes, 0, read);
            }

            out.flush();
            out.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
