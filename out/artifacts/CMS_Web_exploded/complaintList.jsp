<%@ page import="org.example.Model.Complaint, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Complaint List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #6a11cb;
            --secondary: #2575fc;
            --success: #00b09b;
            --danger: #ff416c;
            --warning: #ff7e5f;
            --info: #00d2ff;
            --light: #f8f9fa;
            --dark: #212529;
            --text: #2c3e50;
            --bg-gradient: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }

        body {
            background: var(--bg-gradient);
            color: var(--text);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        .container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 30px;
            margin-bottom: 30px;
        }

        h2 {
            color: var(--primary);
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            padding-bottom: 10px;
            border-bottom: 2px solid rgba(106, 17, 203, 0.1);
        }

        .table {
            margin-top: 20px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .table thead th {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: none;
            padding: 15px;
            text-align: center;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            background-color: rgba(106, 17, 203, 0.03);
        }

        .table td {
            padding: 12px 15px;
            vertical-align: middle;
            border-color: rgba(0, 0, 0, 0.05);
        }

        .action-icons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .action-icon {
            color: white;
            padding: 8px 12px;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16);
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .edit-icon {
            background: linear-gradient(135deg, var(--info), var(--secondary));
        }

        .edit-icon:hover {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 5px 15px rgba(37, 117, 252, 0.4);
        }

        .delete-icon {
            background: linear-gradient(135deg, var(--danger), var(--warning));
        }

        .delete-icon:hover {
            transform: scale(1.1) rotate(-5deg);
            box-shadow: 0 5px 15px rgba(255, 65, 108, 0.4);
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .status-pending {
            background: linear-gradient(135deg, #f6d365, #fda085);
            color: #8e4b1a;
        }

        .status-in-progress {
            background: linear-gradient(135deg, #a1c4fd, #c2e9fb);
            color: #0d47a1;
        }

        .status-resolved {
            background: linear-gradient(135deg, #84fab0, #8fd3f4);
            color: #004d40;
        }

        .btn-back {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            border: none;
            border-radius: 30px;
            padding: 10px 25px;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(106, 17, 203, 0.2);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(106, 17, 203, 0.3);
            color: white;
        }

        .alert-danger {
            background: linear-gradient(135deg, #ff758c, #ff7eb3);
            color: white;
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(255, 117, 140, 0.2);
        }

        .text-muted {
            color: #7f8c8d !important;
            font-style: italic;
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .table tbody tr {
            animation: fadeIn 0.5s ease forwards;
            opacity: 0;
        }

        .table tbody tr:nth-child(1) { animation-delay: 0.1s; }
        .table tbody tr:nth-child(2) { animation-delay: 0.2s; }
        .table tbody tr:nth-child(3) { animation-delay: 0.3s; }
        .table tbody tr:nth-child(4) { animation-delay: 0.4s; }
        .table tbody tr:nth-child(5) { animation-delay: 0.5s; }
        /* Add more if needed */
    </style></head>
<body>
<div class="container my-4">
    <h2 class="text-center">Complaint List</h2>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-danger">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <%
        List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");

        if (complaints != null && !complaints.isEmpty()) {
    %>

    <table class="table table-bordered table-hover text-center align-middle">
        <thead class="table-light">
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Title</th>
            <th>Description</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody data-url="/complaint-details">
        <% for (int i = 0; i < complaints.size(); i++) {
            Complaint complaint = complaints.get(i);
        %>
        <tr>
            <td><%= complaint.getComplaintId() %></td>
            <td><%= complaint.getEmployeeName() != null ? complaint.getEmployeeName() : "N/A" %></td>
            <td><%= complaint.getTitle() %></td>
            <td><%= complaint.getDescription() %></td>
            <td><%= complaint.getStatus() %></td>
            <td class="text-center">
                <div class="action-icons">
                    <a href="<%= request.getContextPath() %>/update-complaint.jsp?id=<%= complaint.getComplaintId() %>"
                       class="action-icon edit-icon" title="Edit">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="<%= request.getContextPath() %>/complaint/delete?id=<%= complaint.getComplaintId() %>"
                       class="action-icon delete-icon" title="Delete"
                       onclick="return confirm('Are you sure you want to delete this complaint?')">
                        <i class="fas fa-trash-alt"></i>
                    </a>
                </div>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <% } else { %>
    <p class="text-muted text-center">No complaints found.</p>
    <% } %>

    <a href="employee.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>

<script>
    // Enhanced delete confirmation
    document.querySelectorAll('.delete-icon').forEach(icon => {
        icon.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to permanently delete this complaint?')) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>