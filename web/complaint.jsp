<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Submit Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --success-color: #28a745;
            --gradient-start: #6a11cb;
            --gradient-end: #2575fc;
            --light-bg: #f0f4f8;
        }

        body {
            background: linear-gradient(135deg, var(--secondary-color), #1a252f);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding: 2rem;
            color: #333;
        }

        .complaint-container {
            max-width: 800px;
            margin: auto;
            padding: 2rem;
            background: linear-gradient(to top, #ada996, #f2f2f2, #dbdbdb, #eaeaea);
            border-radius: 18px;
            box-shadow: 0 0.8rem 1.5rem rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .complaint-container:hover {
            transform: scale(1.02);
        }

        .form-header {
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
            color: var(--secondary-color);
        }

        .form-header h3 {
            background: linear-gradient(90deg, var(--gradient-start), var(--gradient-end));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
        }

        .employee-info {
            background-color: var(--light-bg);
            border-left: 5px solid var(--primary-color);
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--secondary-color);
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .btn-submit {
            background: linear-gradient(90deg, var(--gradient-start), var(--gradient-end));
            color: white;
            border: none;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
            border-radius: 30px;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn-submit:hover {
            background: linear-gradient(90deg, var(--gradient-end), var(--gradient-start));
            transform: translateY(-2px);
        }

        .btn-secondary {
            border-radius: 30px;
            font-weight: 600;
        }

        .character-count {
            font-size: 0.8rem;
            text-align: right;
            color: #6c757d;
        }

        #charCount.warning {
            color: #dc3545;
        }

        /* Alert styles */
        .alert {
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }

        /* Form control plaintext styling */
        .form-control-plaintext {
            font-weight: 500;
            color: var(--secondary-color);
            padding: 0.375rem 0;
        }
    </style>
</head>
<body>
<div class="complaint-container">
    <div class="form-header">
        <h3><i class="fas fa-exclamation-circle me-2"></i> Submit New Complaint</h3>
        <p class="text-muted">Please provide details about your issue</p>
    </div>

    <!-- Display error message if exists -->
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <!-- Display success message if exists -->
    <% if (request.getAttribute("successMessage") != null) { %>
    <div class="alert alert-success" role="alert">
        <%= request.getAttribute("successMessage") %>
    </div>
    <% } %>

    <!-- Employee Information (Auto-filled) -->
    <div class="employee-info row">
        <div class="col-md-6 mb-3">
            <label class="form-label">Employee ID</label>
            <input type="text" class="form-control-plaintext"
                   value="<%= session.getAttribute("userId") %>" readonly>
        </div>
        <div class="col-md-6 mb-3">
            <label class="form-label">Employee Name</label>
            <input type="text" class="form-control-plaintext"
                   value="<%= session.getAttribute("userName") %>" readonly>
        </div>
    </div>

    <!-- Complaint Form -->
    <form id="complaintForm" method="POST" action="submit-complaint">
        <input type="hidden" name="user_id" value="<%= session.getAttribute("userId") %>">
        <input type="hidden" name="employee_name" value="<%= session.getAttribute("userName") %>">

        <div class="mb-3">
            <label for="title" class="form-label">Complaint Title *</label>
            <input type="text" class="form-control" id="title" name="title" required
                   placeholder="Summary of your complaint">
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Detailed Description *</label>
            <textarea class="form-control" id="description" name="description" rows="5" required
                      placeholder="Please describe your complaint in detail"
                      oninput="updateCharacterCount()" maxlength="1000"></textarea>
            <div class="character-count">
                <span id="charCount">0</span>/1000 characters
            </div>
        </div>

        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <button type="reset" class="btn btn-secondary me-md-2">
                <i class="fas fa-times me-1"></i> Clear
            </button>
            <button type="submit" class="btn btn-submit">
                <i class="fas fa-paper-plane me-1"></i> Submit Complaint
            </button>
        </div>
    </form>
</div>

<script>
    // Client-side validation only
    function updateCharacterCount() {
        const description = document.getElementById('description');
        const charCount = document.getElementById('charCount');
        charCount.textContent = description.value.length;

        if (description.value.length > 900) {
            charCount.classList.add('warning');
        } else {
            charCount.classList.remove('warning');
        }
    }

    // Initialize character count on page load
    document.addEventListener('DOMContentLoaded', function() {
        updateCharacterCount();
    });
</script>
</body>
</html>