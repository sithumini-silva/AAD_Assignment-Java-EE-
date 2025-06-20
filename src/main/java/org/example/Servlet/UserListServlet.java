package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.DAO.UserDAO;
import org.example.Model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/user-list")
public class UserListServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Optional: Check if user is logged in (session check)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Fetch all users from DB
            List<User> users = userDAO.getAllUsers();

            // Set users attribute for JSP
            request.setAttribute("users", users);

            // Forward to JSP page
            request.getRequestDispatcher("/user-list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Set error message and forward to error page or same JSP with error info
            request.setAttribute("errorMessage", "Failed to load user list.");
            request.getRequestDispatcher("/user-list.jsp").forward(request, response);
        }
    }
}
