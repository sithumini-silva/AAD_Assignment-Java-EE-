package org.example.Servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.example.DAO.ComplaintDAO;
import org.example.Model.Complaint;

import java.io.IOException;

@WebServlet(name = "ComplaintViewServlet", value = "/complaint-view")
public class ComplaintViewServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;

    @Override
    public void init() throws ServletException {
        complaintDAO = new ComplaintDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Check if user is logged in
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int complaintId = Integer.parseInt(request.getParameter("id"));
            int userId = (Integer) session.getAttribute("userId");

            // Get complaint details
            Complaint complaint = complaintDAO.getComplaintById(complaintId);

            // Verify the complaint belongs to the logged-in user
            if (complaint == null || complaint.getUserId() != userId) {
                request.setAttribute("errorMessage", "Complaint not found or access denied");
                request.getRequestDispatcher("/my-complaints.jsp").forward(request, response);
                return;
            }

            request.setAttribute("complaint", complaint);
            request.getRequestDispatcher("/complaint-view.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid complaint ID");
            request.getRequestDispatcher("/my-complaints.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving complaint: " + e.getMessage());
            request.getRequestDispatcher("/my-complaints.jsp").forward(request, response);
        }
    }
}
