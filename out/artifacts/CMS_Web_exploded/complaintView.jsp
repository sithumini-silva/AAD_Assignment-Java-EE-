<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>All Complaints</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

  <style>
    body { background: #f5f7fa; padding: 2rem; }
    .complaint-table { background: #fff; border-radius: 10px; box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.1); }
    .complaint-table th { background: #3498db; color: #fff; }
    .badge { border-radius: 50px; font-size: 0.85rem; }
  </style>
</head>
<body>
<div class="container">
  <h1 class="mb-4 text-center">All Complaints</h1>
  <div class="card shadow-sm">
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-hover table-bordered align-middle text-center complaint-table">
          <thead>
          <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Employee</th>
            <th>Title</th>
            <th>Description</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody id="complaint-body">
          <tr><td colspan="7">Loading complaints...</td></tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    const tbody = document.getElementById('complaint-body');

    fetch('complaint-details')
            .then(response => {
              if (!response.ok) throw new Error('Network response was not ok');
              return response.json();
            })
            .then(data => {
              tbody.innerHTML = '';

              if (data.success && data.data.length > 0) {
                data.data.forEach(complaint => {
                  // Set badge class based on status
                  let badgeClass = 'badge bg-secondary';
                  switch (complaint.status) {
                    case 'pending': badgeClass = 'badge bg-secondary'; break;
                    case 'in_progress': badgeClass = 'badge bg-warning text-dark'; break;
                    case 'resolved': badgeClass = 'badge bg-success'; break;
                    case 'rejected': badgeClass = 'badge bg-danger'; break;
                  }

                  tbody.innerHTML += `
                <tr>
                  <td>${c.complaintId}</td>
                  <td>${c.userId}</td>
                  <td>${c.employeeName || 'N/A'}</td>
                  <td>${c.title || 'N/A'}</td>
                  <td>${c.description || 'N/A'}</td>
                  <td><span class="${badgeClass}">${c.status.replace('_', ' ').toUpperCase()}</span></td>
                  <td>
                    <a href="view-complaint.jsp?id=${c.complaintId}" class="btn btn-sm btn-primary">
                      <i class="fas fa-eye"></i> View
                    </a>
                    <a href="edit-complaint.jsp?id=${c.complaintId}" class="btn btn-sm btn-secondary">
                      <i class="fas fa-edit"></i> Edit
                    </a>
                  </td>
                </tr>
              `;
                });
              } else {
                tbody.innerHTML = `<tr><td colspan="7" class="text-muted">No complaints found.</td></tr>`;
              }
            })
            .catch(error => {
              tbody.innerHTML = `<tr><td colspan="7" class="text-danger">Error loading complaints: ${error.message}</td></tr>`;
              console.error('Fetch error:', error);
            });
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
