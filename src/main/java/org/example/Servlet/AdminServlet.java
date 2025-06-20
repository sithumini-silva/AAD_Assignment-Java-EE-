package org.example.Servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.DAO.ComplaintDAO;
import org.example.Model.Complaint;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/admin/complaints")
public class AdminServlet extends HttpServlet {
    private ComplaintDAO complaintDAO = new ComplaintDAO();
    private ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Complaint> complaints = complaintDAO.getAllComplaints();
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("data", complaints);
            mapper.writeValue(resp.getWriter(), response);

        } catch (SQLException e) {
            sendError(resp, "Failed to fetch complaints", e);
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Map<String, String> requestData = mapper.readValue(req.getReader(), HashMap.class);
            int complaintId = Integer.parseInt(requestData.get("id"));
            String status = requestData.get("status");
            String remarks = requestData.get("remarks");

            boolean updated = complaintDAO.updateComplaintStatus(complaintId, status, remarks);

            Map<String, Object> response = new HashMap<>();
            response.put("success", updated);
            mapper.writeValue(resp.getWriter(), response);
        } catch (Exception e) {
            sendError(resp, "Failed to update complaint", e);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int complaintId = Integer.parseInt(req.getParameter("id"));
            boolean deleted = complaintDAO.deleteComplaint(complaintId);

            Map<String, Object> response = new HashMap<>();
            response.put("success", deleted);
            mapper.writeValue(resp.getWriter(), response);
        } catch (Exception e) {
            sendError(resp, "Failed to delete complaint", e);
        }
    }

    private void sendError(HttpServletResponse resp, String message, Exception e) throws IOException {
        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        Map<String, Object> errorResponse = new HashMap<>();
        errorResponse.put("success", false);
        errorResponse.put("message", message + ": " + e.getMessage());
        mapper.writeValue(resp.getWriter(), errorResponse);
        e.printStackTrace();
    }
}