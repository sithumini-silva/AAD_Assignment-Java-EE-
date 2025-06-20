<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Complaints Management System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary: #4361ee;
      --secondary: #3f37c9;
      --success: #4cc9f0;
      --danger: #f72585;
      --warning: #ff9f1c;
      --light: #f8f9fa;
      --dark: #212529;
    }

    body {
      background-color: #f5f7fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .complaints-container {
      background: white;
      border-radius: 10px;
      box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
      padding: 2rem;
      margin-top: 2rem;
    }

    .status-badge {
      display: inline-block;
      padding: 5px 12px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 600;
      text-transform: capitalize;
    }

    .status-pending { background-color: #fff3cd; color: #856404; }
    .status-in_progress { background-color: #cce5ff; color: #004085; }
    .status-resolved { background-color: #d4edda; color: #155724; }
    .status-rejected { background-color: #f8d7da; color: #721c24; }

    .action-btn {
      width: 30px;
      height: 30px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
      transition: all 0.3s;
    }

    .btn-view { background-color: rgba(67, 97, 238, 0.1); color: var(--primary); }
    .btn-view:hover { background-color: var(--primary); color: white; }

    .btn-edit { background-color: rgba(255, 159, 28, 0.1); color: var(--warning); }
    .btn-edit:hover { background-color: var(--warning); color: white; }

    .btn-delete { background-color: rgba(247, 37, 133, 0.1); color: var(--danger); }
    .btn-delete:hover { background-color: var(--danger); color: white; }

    .table-responsive {
      border-radius: 8px;
      overflow: hidden;
    }

    .table thead th {
      background-color: var(--primary);
      color: white;
      font-weight: 500;
    }

    .table tbody tr {
      transition: all 0.2s;
    }

    .table tbody tr:hover {
      background-color: rgba(67, 97, 238, 0.03);
    }
  </style>
</head>
<body>
<div class="container">
  <div class="complaints-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2 class="mb-0"><i class="fas fa-exclamation-circle me-2"></i>Complaints</h2>
      <a href="add-complaint.jsp" class="btn btn-primary">
        <i class="fas fa-plus me-2"></i>Add New
      </a>
    </div>

    <c:if test="${not empty successMessage}">
      <div class="alert alert-success alert-dismissible fade show">
          ${successMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
      <div class="alert alert-danger alert-dismissible fade show">
          ${errorMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    </c:if>

    <div class="table-responsive">
      <table class="table table-hover align-middle">
        <thead>
        <tr>
          <th>ID</th>
          <th>Employee</th>
          <th>Title</th>
          <th>Status</th>
          <th>Date Submitted</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="complaint" items="${complaints}">
          <tr>
            <td>${complaint.complaintId}</td>
            <td>${complaint.employeeName}</td>
            <td>${complaint.title}</td>
            <td>
                                <span class="status-badge status-${complaint.status}">
                                    ${complaint.status}
                                </span>
            </td>
            <td>
              <fmt:formatDate value="${complaint.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
            <td>
              <div class="d-flex gap-2">
                <a href="view-complaint?id=${complaint.complaintId}" class="action-btn btn-view" title="View">
                  <i class="fas fa-eye"></i>
                </a>
                <a href="edit-complaint?id=${complaint.complaintId}" class="action-btn btn-edit" title="Edit">
                  <i class="fas fa-edit"></i>
                </a>
                <a href="#" class="action-btn btn-delete" title="Delete"
                   onclick="confirmDelete(${complaint.complaintId})">
                  <i class="fas fa-trash-alt"></i>
                </a>
              </div>
            </td>
          </tr>
        </c:forEach>

        <c:if test="${empty complaints}">
          <tr>
            <td colspan="6" class="text-center py-4 text-muted">
              No complaints found
            </td>
          </tr>
        </c:if>
        </tbody>
      </table>
    </div>

    <!-- Pagination -->
    <nav aria-label="Page navigation" class="mt-4">
      <ul class="pagination justify-content-center">
        <c:if test="${currentPage > 1}">
          <li class="page-item">
            <a class="page-link" href="complaint-list?page=${currentPage - 1}">Previous</a>
          </li>
        </c:if>

        <c:forEach begin="1" end="${totalPages}" var="i">
          <li class="page-item ${i == currentPage ? 'active' : ''}">
            <a class="page-link" href="complaint-list?page=${i}">${i}</a>
          </li>
        </c:forEach>

        <c:if test="${currentPage < totalPages}">
          <li class="page-item">
            <a class="page-link" href="complaint-list?page=${currentPage + 1}">Next</a>
          </li>
        </c:if>
      </ul>
    </nav>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function confirmDelete(id) {
    if (confirm('Are you sure you want to delete complaint #' + id + '?')) {
      window.location.href = 'delete-complaint?id=' + id;
    }
  }
</script>
</body>
</html>