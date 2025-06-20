<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --sidebar-width: 250px;
        }
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
            margin-left: var(--sidebar-width);
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
        .nav-link.active {
            background-color: #495057;
        }
        .tab-content > .tab-pane {
            display: none;
        }
        .tab-content > .active {
            display: block;
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <div class="text-center mb-4">
        <h4>Admin Panel</h4>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link active" href="#complaints" data-bs-toggle="tab">
                <i class="fas fa-list"></i> Complaints
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#users" data-bs-toggle="tab">
                <i class="fas fa-users"></i> Users
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#settings" data-bs-toggle="tab">
                <i class="fas fa-cog"></i> Settings
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
    <div class="tab-content">
        <!-- Complaints Tab -->
        <div class="tab-pane fade show active" id="complaints">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Complaint Management</h2>
            </div>

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
                            <tbody id="complaintsTableBody">
                            <tr>
                                <td colspan="7" class="text-center">Loading complaints...</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Users Tab -->
        <div class="tab-pane fade" id="users">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>User Management</h2>
            </div>
            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Department</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody id="usersTableBody">
                            <tr>
                                <td colspan="6" class="text-center">Loading users...</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Settings Tab -->
        <div class="tab-pane fade" id="settings">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>System Settings</h2>
            </div>
            <div class="card shadow-sm">
                <div class="card-body">
                    <p>System settings will be displayed here.</p>
                </div>
            </div>
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

<!-- User Edit Modal -->
<div class="modal fade" id="userModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="userForm">
                    <input type="hidden" id="userId">
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" class="form-control" id="userName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" id="userEmail" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Role</label>
                        <select class="form-select" id="userRole" required>
                            <option value="user">User</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Department</label>
                        <input type="text" class="form-control" id="userDepartment">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="saveUser()">Save Changes</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Sample data for demonstration
    const sampleComplaints = [
        {
            complaintId: 1,
            userId: 101,
            userName: "John Doe",
            title: "Broken Window",
            description: "Window in room 203 is broken and needs replacement",
            status: "pending",
            remarks: "Needs inspection"
        },
        {
            complaintId: 2,
            userId: 102,
            userName: "Jane Smith",
            title: "Leaky Faucet",
            description: "Kitchen faucet is leaking continuously",
            status: "in_progress",
            remarks: "Plumber assigned"
        },
        {
            complaintId: 3,
            userId: 103,
            userName: "Bob Johnson",
            title: "Electrical Issue",
            description: "Lights flickering in hallway",
            status: "resolved",
            remarks: "Fixed on 10/15/2023"
        }
    ];

    const sampleUsers = [
        {
            id: 101,
            name: "John Doe",
            email: "john@example.com",
            role: "user",
            department: "Sales"
        },
        {
            id: 102,
            name: "Jane Smith",
            email: "jane@example.com",
            role: "admin",
            department: "IT"
        },
        {
            id: 103,
            name: "Bob Johnson",
            email: "bob@example.com",
            role: "user",
            department: "Marketing"
        }
    ];

    document.addEventListener('DOMContentLoaded', function() {
        loadComplaints();
        loadUsers();

        // Tab switching
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const tabId = this.getAttribute('href').substring(1);
                showTab(tabId);

                // Update active class
                document.querySelectorAll('.nav-link').forEach(nav => {
                    nav.classList.remove('active');
                });
                this.classList.add('active');
            });
        });
    });

    function showTab(tabId) {
        // Hide all tab panes
        document.querySelectorAll('.tab-pane').forEach(pane => {
            pane.classList.remove('show', 'active');
        });

        // Show selected tab
        const tabPane = document.getElementById(tabId);
        if (tabPane) {
            tabPane.classList.add('show', 'active');
        }
    }

    function loadComplaints() {
        // In a real application, you would fetch this from your backend
        // fetch('/api/complaints').then(...)

        // For demo purposes, we'll use the sample data
        const tbody = document.getElementById('complaintsTableBody');
        tbody.innerHTML = '';

        if (sampleComplaints.length > 0) {
            sampleComplaints.forEach(complaint => {
                const statusClass = getStatusClass(complaint.status);
                const statusText = formatStatusText(complaint.status);

                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${complaint.complaintId}</td>
                    <td>${complaint.userName || complaint.userId}</td>
                    <td>${complaint.title}</td>
                    <td>${complaint.description}</td>
                    <td><span class="status-badge ${statusClass}">${statusText}</span></td>
                    <td>${complaint.remarks || '-'}</td>
                    <td>
                        <button class="btn btn-sm btn-warning" onclick="openStatusModal(${complaint.complaintId}, '${complaint.status}', '${complaint.remarks || ''}')">
                            <i class="fas fa-edit"></i> Update
                        </button>
                        <button class="btn btn-sm btn-danger" onclick="deleteComplaint(${complaint.complaintId})">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </td>
                `;
                tbody.appendChild(row);
            });
        } else {
            tbody.innerHTML = `
                <tr>
                    <td colspan="7" class="text-center text-muted">
                        No complaints found
                    </td>
                </tr>`;
        }
    }

    function loadUsers() {
        fetch('/admin/users')
            .then(response => response.json())
            .then(users => {
                const tbody = document.getElementById('usersTableBody');
                tbody.innerHTML = '';

                if (users.length > 0) {
                    users.forEach(user => {
                        const row = document.createElement('tr');
                        row.innerHTML = `
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td>${user.role}</td>
                        <td>${user.department || '-'}</td>
                        <td>
                            <button class="btn btn-sm btn-primary" onclick="editUser(${user.id}, '${user.name}', '${user.email}', '${user.role}', '${user.department || ''}')">
                                <i class="fas fa-edit"></i> Edit
                            </button>
                            <button class="btn btn-sm btn-danger" onclick="deleteUser(${user.id})">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </td>
                    `;
                        tbody.appendChild(row);
                    });
                } else {
                    tbody.innerHTML = `
                    <tr>
                        <td colspan="6" class="text-center text-muted">
                            No users found
                        </td>
                    </tr>`;
                }
            })
            .catch(error => {
                console.error('Error loading users:', error);
                document.getElementById('usersTableBody').innerHTML = `
                <tr>
                    <td colspan="6" class="text-center text-danger">
                        Error loading users
                    </td>
                </tr>`;
            });
    }
    function openStatusModal(complaintId, currentStatus = 'pending', currentRemarks = '') {
        document.getElementById('complaintId').value = complaintId;
        document.getElementById('statusSelect').value = currentStatus;
        document.getElementById('remarksText').value = currentRemarks;

        const modal = new bootstrap.Modal(document.getElementById('statusModal'));
        modal.show();
    }

    function updateStatus() {
        const complaintId = document.getElementById('complaintId').value;
        const status = document.getElementById('statusSelect').value;
        const remarks = document.getElementById('remarksText').value;

        // In a real application, you would send this to your backend
        // fetch('/api/complaints/update', { method: 'POST', body: JSON.stringify(...) })

        // For demo purposes, we'll just update the sample data
        const complaint = sampleComplaints.find(c => c.complaintId == complaintId);
        if (complaint) {
            complaint.status = status;
            complaint.remarks = remarks;

            alert('Status updated successfully!');
            document.getElementById('statusModal').querySelector('.btn-close').click();
            loadComplaints();
        } else {
            alert('Complaint not found!');
        }
    }

    function deleteComplaint(complaintId) {
        if (!confirm('Are you sure you want to delete this complaint?')) return;

        // In a real application, you would call your backend
        // fetch(`/api/complaints/${complaintId}`, { method: 'DELETE' })

        // For demo purposes, we'll just update the sample data
        const index = sampleComplaints.findIndex(c => c.complaintId == complaintId);
        if (index !== -1) {
            sampleComplaints.splice(index, 1);
            alert('Complaint deleted successfully!');
            loadComplaints();
        } else {
            alert('Complaint not found!');
        }
    }

    function editUser(userId, name, email, role, department) {
        document.getElementById('userId').value = userId;
        document.getElementById('userName').value = name;
        document.getElementById('userEmail').value = email;
        document.getElementById('userRole').value = role;
        document.getElementById('userDepartment').value = department || '';

        const modal = new bootstrap.Modal(document.getElementById('userModal'));
        modal.show();
    }

    function saveUser() {
        const userId = document.getElementById('userId').value;
        const name = document.getElementById('userName').value;
        const email = document.getElementById('userEmail').value;
        const role = document.getElementById('userRole').value;
        const department = document.getElementById('userDepartment').value;

        // In a real application, you would send this to your backend
        // fetch('/api/users/update', { method: 'POST', body: JSON.stringify(...) })

        // For demo purposes, we'll just update the sample data
        const user = sampleUsers.find(u => u.id == userId);
        if (user) {
            user.name = name;
            user.email = email;
            user.role = role;
            user.department = department;

            alert('User updated successfully!');
            document.getElementById('userModal').querySelector('.btn-close').click();
            loadUsers();
        } else {
            alert('User not found!');
        }
    }

    function deleteUser(userId) {
        if (!confirm('Are you sure you want to delete this user?')) return;

        // In a real application, you would call your backend
        // fetch(`/api/users/${userId}`, { method: 'DELETE' })

        // For demo purposes, we'll just update the sample data
        const index = sampleUsers.findIndex(u => u.id == userId);
        if (index !== -1) {
            sampleUsers.splice(index, 1);
            alert('User deleted successfully!');
            loadUsers();
        } else {
            alert('User not found!');
        }
    }

    function getStatusClass(status) {
        if (!status) return 'status-pending';
        switch(status.toLowerCase()) {
            case 'in_progress': return 'status-in_progress';
            case 'resolved': return 'status-resolved';
            case 'rejected': return 'status-rejected';
            default: return 'status-pending';
        }
    }

    function formatStatusText(status) {
        if (!status) return 'PENDING';
        return status.toUpperCase().replace('_', ' ');
    }
</script>
</body>
</html>