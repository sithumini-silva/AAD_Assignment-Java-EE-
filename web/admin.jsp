<%@ page import="org.example.Model.User" %>
<%@ page import="org.example.Model.Complaint" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root { --sidebar-width: 250px; }
        body {
            display: flex;
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .sidebar {
            width: var(--sidebar-width);
            background: #343a40;
            color: white;
            padding: 20px 0;
        }
        .main-content {
            flex: 1;
            padding: 20px;
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 5px 10px;
            border-radius: 20px;
        }
        .status-pending { background-color: #6c757d; color: white; }
        .status-in_progress { background-color: #ffc107; color: black; }
        .status-resolved { background-color: #28a745; color: white; }
        .status-rejected { background-color: #dc3545; color: white; }
        .nav-link.active { background-color: #495057; }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="text-center mb-4">
        <h4>Admin Panel</h4>
    </div>
    <ul class="nav flex-column nav-pills" id="adminTabs" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="complaints-tab" data-bs-toggle="pill" href="#complaints" role="tab" aria-controls="complaints" aria-selected="true">
                <i class="fas fa-list"></i> Complaints
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="users-tab" data-bs-toggle="pill" href="#users" role="tab" aria-controls="users" aria-selected="false">
                <i class="fas fa-users"></i> Users
            </a>
        </li>
        <li class="nav-item mt-3">
            <a class="nav-link text-danger" href="login.jsp">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="tab-content" id="adminTabContent">

        <!-- Complaints Tab -->
        <div class="tab-pane fade show active" id="complaints" role="tabpanel" aria-labelledby="complaints-tab">
            <h2 class="mb-4">Complaint Management</h2>
            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>User</th>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Remarks</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
                                if (complaints != null && !complaints.isEmpty()) {
                                    for (Complaint complaint : complaints) {
                                        String status = complaint.getStatus() != null ? complaint.getStatus().toLowerCase() : "pending";
                                        String statusClass = "";
                                        switch (status) {
                                            case "in_progress": statusClass = "status-in_progress"; break;
                                            case "resolved": statusClass = "status-resolved"; break;
                                            case "rejected": statusClass = "status-rejected"; break;
                                            default: statusClass = "status-pending";
                                        }
                            %>
                            <tr>
                                <td><%= complaint.getComplaintId() %></td>
                                <td><%= complaint.getUserId() %></td>
                                <td><%= complaint.getTitle() %></td>
                                <td><%= complaint.getDescription() %></td>
                                <td><span class="status-badge <%= statusClass %>"><%= status.toUpperCase().replace('_', ' ') %></span></td>
                                <td>
                                    <button class="btn btn-sm btn-warning" onclick="openStatusModal(<%= complaint.getComplaintId() %>)">
                                        <i class="fas fa-edit"></i> Update
                                    </button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteComplaint(<%= complaint.getComplaintId() %>)">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="7" class="text-center text-muted">No complaints found</td>
                            </tr>
                            <%
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Users Tab -->
        <div class="tab-pane fade" id="users" role="tabpanel" aria-labelledby="users-tab">
            <h2 class="mb-4">User Management</h2>
            <%
                List<User> users = (List<User>) request.getAttribute("users");
            %>
            <table class="table table-hover">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Department</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (users != null && !users.isEmpty()) {
                        for (User user : users) {
                %>
                <tr>
                    <td><%= user.getId() %></td>
                    <td><%= user.getName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getRole() %></td>
                    <td><%= user.getDepartment() %></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="5" class="text-center text-muted">No users found</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

    </div>
</div>

<!-- Status Update Modal -->
<div class="modal fade" id="statusModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Update Complaint Status</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="statusForm">
                    <input type="hidden" id="complaintId">
                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <select class="form-select" id="statusSelect" required>
                            <option value="pending">Pending</option>
                            <option value="in_progress">In Progress</option>
                            <option value="resolved">Resolved</option>
                            <option value="rejected">Rejected</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Remarks</label>
                        <textarea class="form-control" id="remarksText" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="updateStatus()">Save Changes</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openStatusModal(complaintId) {
        document.getElementById('complaintId').value = complaintId;
        const modal = new bootstrap.Modal(document.getElementById('statusModal'));
        modal.show();
    }

    function updateStatus() {
        const complaintId = document.getElementById('complaintId').value;
        const status = document.getElementById('statusSelect').value;
        const remarks = document.getElementById('remarksText').value;

        fetch('<%= request.getContextPath() %>/update-complaint-status', {  // You need to implement this servlet
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                id: complaintId,
                status: status,
                remarks: remarks
            })
        })
            .then(response => {
                if (!response.ok) throw new Error('Update failed');
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    alert('Status updated successfully!');
                    document.querySelector('#statusModal .btn-close').click();
                    location.reload();  // Reload to refresh complaints table
                } else {
                    throw new Error('Update failed');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to update status: ' + error.message);
            });
    }

    function deleteComplaint(complaintId) {
        if (!confirm('Are you sure you want to delete this complaint?')) return;

        fetch(`<%= request.getContextPath() %>/delete-complaint?id=${complaintId}`, {  // Implement this servlet too
            method: 'DELETE'
        })
            .then(response => {
                if (!response.ok) throw new Error('Delete failed');
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    alert('Complaint deleted successfully!');
                    location.reload();
                } else {
                    throw new Error('Delete failed');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to delete complaint: ' + error.message);
            });
    }
</script>

</body>
</html>
