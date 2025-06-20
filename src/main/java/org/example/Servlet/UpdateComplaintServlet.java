package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.DAO.ComplaintDAO;
import org.example.Model.Complaint;

import java.io.IOException;

@WebServlet("/update-complaint")
public class UpdateComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        String cidStr = req.getParameter("complaint_id");
        if (cidStr == null || cidStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/viewMyComplaints?error=missing_cid");
            return;
        }

        int complaintId;
        try {
            complaintId = Integer.parseInt(cidStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/viewMyComplaints?error=invalid_cid");
            return;
        }

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String status = req.getParameter("status");
        int userId = (int) session.getAttribute("user_id");

        if (title == null || description == null || status == null ||
                title.trim().isEmpty() || description.trim().isEmpty() || status.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/viewMyComplaints?error=missing_fields");
            return;
        }

        try {
            ComplaintDAO complaintDAO = new ComplaintDAO();
            Complaint complaint = complaintDAO.getComplaintById(complaintId);

            if (complaint == null || complaint.getUserId() != userId) {
                resp.sendRedirect(req.getContextPath() + "/viewMyComplaints?error=unauthorized");
                return;
            }

            boolean updated = complaintDAO.updateComplaintFull(complaintId, title.trim(), description.trim(), status.trim());

            if (updated) {
                resp.sendRedirect(req.getContextPath() + "/viewMyComplaints?success=true");
            } else {
                resp.sendRedirect(req.getContextPath() + "/viewMyComplaints?error=update_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/viewMyComplaints?error=server_error");
        }
    }
}
