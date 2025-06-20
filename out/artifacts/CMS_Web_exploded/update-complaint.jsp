<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.Model.Complaint" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Update Complaint</h2>

    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        Complaint complaint = (Complaint) request.getAttribute("complaint");
    %>

    <% if (success != null) { %>
    <div class="alert alert-success">Complaint updated successfully.</div>
    <% } %>

    <% if (error != null) { %>
    <div class="alert alert-danger">
        <%=
        "missing_fields".equals(error) ? "Please fill in all required fields." :
                "unauthorized".equals(error) ? "You are not authorized to update this complaint." :
                        "update_failed".equals(error) ? "Update failed. Please try again." :
                                "server_error".equals(error) ? "Server error occurred." :
                                        "invalid_cid".equals(error) ? "Invalid complaint ID." :
                                                "missing_cid".equals(error) ? "Complaint ID is missing." :
                                                        "An error occurred."
        %>
    </div>
    <% } %>

    <form action="update-complaint" method="post">
        <input type="hidden" name="complaint_id" value="<%= (complaint != null) ? complaint.getComplaintId() : "" %>" />

        <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input type="text" class="form-control" id="title" name="title"
                   value="<%= (complaint != null) ? complaint.getTitle() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="5" required><%=
            (complaint != null) ? complaint.getDescription() : ""
            %></textarea>
        </div>

        <div class="mb-3">
            <label for="status" class="form-label">Status</label>
            <select class="form-select" id="status" name="status" required>
                <option value="">Select status</option>
                <option value="pending" <%= (complaint != null && "pending".equalsIgnoreCase(complaint.getStatus())) ? "selected" : "" %>>Pending</option>
                <option value="in_progress" <%= (complaint != null && "in_progress".equalsIgnoreCase(complaint.getStatus())) ? "selected" : "" %>>In Progress</option>
                <option value="resolved" <%= (complaint != null && "resolved".equalsIgnoreCase(complaint.getStatus())) ? "selected" : "" %>>Resolved</option>
                <option value="rejected" <%= (complaint != null && "rejected".equalsIgnoreCase(complaint.getStatus())) ? "selected" : "" %>>Rejected</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Update</button>
    </form>
</div>
</body>
</html>
