<%@ page import="org.example.Model.Complaint, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Complaint List</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container my-4">
  <h2 class="text-center">Complaint List</h2>

  <%
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    if (complaints != null && !complaints.isEmpty()) {
  %>
  <table class="table table-bordered table-hover text-center align-middle">
    <thead class="table-light">
    <tr>
      <th>ID</th>
      <th>Employee</th>
      <th>Title</th>
      <th>Description</th>
      <th>Status</th>
    </tr>
    </thead>
    <tbody>
    <%
      for (Complaint c : complaints) {
    %>
    <tr>
      <td><%= c.getComplaintId() %></td>
      <td><%= c.getEmployeeName() != null ? c.getEmployeeName() : "N/A" %></td>
      <td><%= c.getTitle() %></td>
      <td><%= c.getDescription() %></td>
      <td><%= c.getStatus() %></td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <% } else { %>
  <p class="text-muted text-center">No complaints found.</p>
  <% } %>

  <a href="<%= request.getContextPath() %>/dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>
</body>
</html>
