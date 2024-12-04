package org.example;

import javax.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        String redirect = request.getParameter("redirect");
        if (redirect != null) {
            response.sendRedirect(redirect);
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}