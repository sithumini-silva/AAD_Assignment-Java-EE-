package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.DAO.UserDAO;
import org.example.Model.User;

import java.io.IOException;

@WebServlet("/user-login")
public class UserLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("user_email");
        String password = request.getParameter("user_password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Authenticate user
        UserDAO userDAO = new UserDAO();
        User user = userDAO.authenticate(email, password);

        if (user != null) {
            HttpSession session = request.getSession();

            // Set full User object (if needed elsewhere)
            session.setAttribute("user", user);

            // Set userId and userName separately for easier access
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());

            // Debug log (optional)
            System.out.println("Login successful: ID=" + user.getId() + ", Name=" + user.getName() + ", Role=" + user.getRole());

            String role = user.getRole();

            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("admin.jsp");
            } else if ("employee".equalsIgnoreCase(role)) {
                response.sendRedirect("employee.jsp");
            } else {
                request.setAttribute("error", "Unauthorized role");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
