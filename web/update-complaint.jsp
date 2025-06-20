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
        String success = (String) request.getAttribute("success");
        String error = (String) request.getAttribute("error");
        Complaint complaint = (Complaint) request.getAttribute("complaint");
    %>

    <% if (success != null) { %>
    <div class="alert alert-success"><%= success %></div>
    <% } %>

    <% if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form action="update-complaint" method="post">
        <input type="hidden" name="complaint_id" value="<%= (complaint != null) ? complaint.getComplaintId() : "" %>" />

        <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input
                    type="text"
                    class="form-control"
                    id="title"
                    name="title"
                    value="<%= (complaint != null) ? complaint.getTitle() : "" %>"
                    required />
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea
                    class="form-control"
                    id="description"
                    name="description"
                    rows="5"
                    required><%= (complaint != null) ? complaint.getDescription() : "" %></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update Complaint</button>
        <a href="complaint.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
