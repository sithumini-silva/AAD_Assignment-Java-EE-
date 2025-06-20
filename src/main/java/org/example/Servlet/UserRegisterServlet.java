package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.DAO.UserDAO;
import org.example.Model.User;

import java.io.IOException;

@WebServlet("/user-register")
public class UserRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String name = request.getParameter("user_name");
        String email = request.getParameter("user_email");
        String password = request.getParameter("user_password");
        String role = request.getParameter("user_role");
        String department = "admin".equals(role) ? "Administration" : request.getParameter("user_department");

        // Validate input
        if (name == null || email == null || password == null || role == null ||
                name.isEmpty() || email.isEmpty() || password.isEmpty() || role.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        UserDAO userDAO = new UserDAO();
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email already registered");
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
            return;
        }

        // Create user object
        User user = new User(name, email, password, role, department);

        // Register user
        if (userDAO.registerUser(user)) {
            // Registration successful
            response.sendRedirect("login.jsp");
        } else {
            // Registration failed
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

}