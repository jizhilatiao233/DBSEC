package org.example;

import javax.servlet.http.*;
import java.io.IOException;

public class CheckSessionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("username") != null);

        // Debugging
        if(loggedIn) {
            System.out.println("User is logged in as " + session.getAttribute("username") + ", role:" + session.getAttribute("role"));
        } else {
            System.out.println("User is not logged in");
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"loggedIn\": " + loggedIn + "}" );
    }
}