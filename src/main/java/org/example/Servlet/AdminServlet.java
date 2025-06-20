package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.DAO.ComplaintDAO;
import org.example.DAO.UserDAO;
import org.example.Model.Complaint;
import org.example.Model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/users-details")
public class AdminServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<User> users = userDAO.getAllUsers();
            List<Complaint> complaints = complaintDAO.getAllComplaints();

            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }

            req.setAttribute("users", users);
            req.setAttribute("complaints", complaints);

            req.getRequestDispatcher("/admin.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Failed to load data.");
            req.getRequestDispatcher("/admin.jsp").forward(req, resp);
        }
    }
}
