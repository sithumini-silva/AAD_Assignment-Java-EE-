package org.example.Servlet;

import org.example.DAO.ComplaintDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.Model.Complaint;

import java.io.IOException;

@WebServlet("/submit-complaint")
public class SubmitComplaintServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;

    @Override
    public void init() throws ServletException {
        complaintDAO = new ComplaintDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Check if user is logged in
        if (session.getAttribute("userId") == null || session.getAttribute("userName") == null) {
            request.setAttribute("errorMessage", "Please login to submit a complaint");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            int userId = (Integer) session.getAttribute("userId");
            String employeeName = (String) session.getAttribute("userName");
            String title = request.getParameter("title");
            String description = request.getParameter("description");

            if (title == null || title.trim().isEmpty() ||
                    description == null || description.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Title and description are required!");
                request.getRequestDispatcher("/submitComplaint.jsp").forward(request, response);
                return;
            }

            Complaint complaint = new Complaint(userId, employeeName, title, description, "pending");

            if (complaintDAO.saveComplaint(complaint)) {
                request.setAttribute("successMessage", "Complaint submitted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to submit complaint. Please try again.");
            }

            request.getRequestDispatcher("/complaint.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/submitComplaint.jsp").forward(request, response);
        }
    }
}