<%@ page import="org.example.Model.Complaint, java.util.List" %>
<%@ page import="org.example.Model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Complaint List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-color: #121212;
            --card-bg: #1e1e1e;
            --header-bg: #272727;
            --text-color: #e0e0e0;
            --accent: #4f8cff;
            --danger: #e74c3c;
            --warning: #f39c12;
            --success: #27ae60;
            --info: #3498db;
        }

        body {
            background: var(--bg-color);
            color: var(--text-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        .container {
            background: var(--card-bg);
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.5);
            padding: 30px;
            margin-top: 30px;
        }

        h2 {
            text-align: center;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--accent);
            border-bottom: 2px solid rgba(79, 140, 255, 0.3);
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .table {
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
        }

        .table thead th {
            background: var(--header-bg);
            color: var(--text-color);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
            padding: 12px;
        }

        .table tbody tr {
            transition: background 0.3s;
        }

        .table tbody tr:hover {
            background: rgba(79, 140, 255, 0.1);
        }

        .table td {
            padding: 10px;
            vertical-align: middle;
        }

        .action-icons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .action-icon {
            color: #fff;
            background: var(--accent);
            border-radius: 50%;
            width: 34px;
            height: 34px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .action-icon:hover {
            transform: scale(1.1);
            box-shadow: 0 0 10px var(--accent);
        }

        .edit-icon {
            background: var(--info);
        }

        .delete-icon {
            background: var(--danger);
        }

        .edit-icon:hover {
            box-shadow: 0 0 10px var(--info);
        }

        .delete-icon:hover {
            box-shadow: 0 0 10px var(--danger);
        }

        .btn-secondary {
            background: var(--accent);
            color: #fff;
            border: none;
            border-radius: 20px;
            padding: 10px 20px;
            text-transform: uppercase;
            font-weight: 600;
            transition: background 0.3s, box-shadow 0.3s;
        }

        .btn-secondary:hover {
            background: #3a73cc;
            box-shadow: 0 0 10px #3a73cc;
        }

        .alert-danger {
            background: var(--danger);
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
        }

        .text-muted {
            color: #7f8c8d !important;
            font-style: italic;
        }

    </style>
</head>
<body>
<div class="container my-4">
    <h2 class="text-center">Users List</h2>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-danger">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <table class="table table-bordered table-hover text-center align-middle">
        <thead class="table-light">
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Email</th>
            <th>Password</th>
            <th>Role</th>
            <th>Department</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody data-url="/user-details">
        </tbody>
    </table>

    <a href="admin.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
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
