package org.example.Servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.DAO.ComplaintDAO;
import org.example.Model.Complaint;

import java.io.IOException;
import java.util.*;

@WebServlet("/complaint-details")
public class ComplaintDetailsServlet extends HttpServlet {
    private final ObjectMapper mapper = new ObjectMapper();
    private ComplaintDAO complaintDAO;

    @Override
    public void init() throws ServletException {
        complaintDAO = new ComplaintDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Map<String, Object> response = new HashMap<>();

        try {
            List<Complaint> complaints = complaintDAO.getAllComplaints();
            List<Map<String, Object>> data = new ArrayList<>();

            for (Complaint c : complaints) {
                Map<String, Object> complaint = new LinkedHashMap<>();
                complaint.put("id", c.getComplaintId());
                complaint.put("userId", c.getUserId());
                complaint.put("employee", c.getEmployeeName());
                complaint.put("title", c.getTitle());
                complaint.put("description", c.getDescription());
                complaint.put("status", c.getStatus());
                data.add(complaint);
            }

            response.put("success", true);
            response.put("data", data);

            // Debug print
            System.out.println("Sending response: " + response);

        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
            e.printStackTrace();
        }

        mapper.writeValue(resp.getWriter(), response);
    }
}