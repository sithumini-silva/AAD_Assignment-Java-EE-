package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import org.example.DAO.ComplaintDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ComplaintServlet", urlPatterns = {"/ComplaintServlet"})
public class ComplaintServlet extends HttpServlet {
    private final ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        Map<String, Object> result = new HashMap<>();

        try {
            // Read JSON data from request
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            String json = sb.toString();

            // Parse JSON manually
            JSONObject jsonObject = new JSONObject(json);
            Complaint complaint = new Complaint();
            complaint.setUserId(jsonObject.getString("user_id"));
            complaint.setEmployeeName(jsonObject.getString("employee_name"));
            complaint.setTitle(jsonObject.getString("title"));
            complaint.setDescription(jsonObject.getString("description"));
            complaint.setStatus("PENDING"); // Default status

            // Save complaint to database
            boolean success = complaintDAO.createComplaint(complaint);

            if (success) {
                result.put("success", true);
                result.put("message", "Complaint submitted successfully!");
            } else {
                result.put("success", false);
                result.put("message", "Failed to submit complaint. Please try again.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "An error occurred: " + e.getMessage());
        }

        out.print(new JSONObject(result).toString());
        out.flush();
    }
}