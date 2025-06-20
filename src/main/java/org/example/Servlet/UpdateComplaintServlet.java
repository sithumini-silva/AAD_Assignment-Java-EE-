package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.DAO.ComplaintDAO;
import org.example.Model.Complaint;
import org.example.Model.User;

import java.io.IOException;

@WebServlet("/update-complaint")
public class UpdateComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String complaintIdStr = req.getParameter("complaint_id");
        String title = req.getParameter("title");
        String description = req.getParameter("description");

        if (complaintIdStr == null || title == null || description == null ||
                complaintIdStr.trim().isEmpty() || title.trim().isEmpty() || description.trim().isEmpty()) {

            req.setAttribute("error", "All fields are required");
            forwardToForm(req, resp, complaintIdStr);
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdStr);
            ComplaintDAO complaintDAO = new ComplaintDAO();

            boolean success = complaintDAO.updateComplaint(complaintId, title, description);

            if (success) {
                req.setAttribute("success", "Complaint updated successfully");
            } else {
                req.setAttribute("error", "Failed to update complaint");
            }

            forwardToForm(req, resp, complaintIdStr);

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid Complaint ID");
            forwardToForm(req, resp, complaintIdStr);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Internal server error");
            forwardToForm(req, resp, complaintIdStr);
        }
    }

    private void forwardToForm(HttpServletRequest req, HttpServletResponse resp, String complaintIdStr)
            throws ServletException, IOException {
        try {
            if (complaintIdStr != null && !complaintIdStr.trim().isEmpty()) {
                int complaintId = Integer.parseInt(complaintIdStr);
                ComplaintDAO dao = new ComplaintDAO();
                Complaint complaint = dao.getComplaintById(complaintId);
                req.setAttribute("complaint", complaint);
            }
        } catch (Exception ignored) {}

        req.getRequestDispatcher("/update-complaint.jsp").forward(req, resp);
    }
}
