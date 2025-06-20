<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>WorkNet Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* your CSS here, same as before or simplified for brevity */
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --admin-color: #e74c3c;
        }
        body {
            background: linear-gradient(135deg, var(--secondary-color), #1a252f);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
        }
        .register-container {
            background: rgba(255,255,255,0.1);
            padding: 25px;
            border-radius: 15px;
            width: 350px;
            box-shadow: 0 0 15px rgba(0,0,0,0.5);
        }
        .role-selector {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }
        .role-option {
            flex: 1;
            padding: 10px;
            border-radius: 10px;
            cursor: pointer;
            text-align: center;
            background: rgba(255,255,255,0.15);
            transition: background 0.3s;
        }
        .role-option.active {
            background: rgba(52, 152, 219, 0.7);
        }
        .role-option.admin.active {
            background: rgba(231, 76, 60, 0.7);
        }
        .form-group {
            margin-bottom: 15px;
        }
        select, input {
            width: 100%;
            padding: 8px 12px;
            border-radius: 5px;
            border: none;
            font-size: 1rem;
        }
        button.btn-register {
            width: 100%;
            background: var(--primary-color);
            border: none;
            padding: 10px;
            border-radius: 25px;
            font-weight: bold;
            color: white;
            cursor: pointer;
            transition: background 0.3s;
        }
        button.btn-register:hover {
            background: #2980b9;
        }
        .error-message {
            background: #e74c3c;
            padding: 8px 12px;
            border-radius: 5px;
            margin-bottom: 15px;
            color: white;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2 class="text-center mb-3">Create Account</h2>

    <!-- Show error message if any -->
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <form action="user-register" method="post" id="registerForm">
        <!-- Role selector -->
        <div class="role-selector">
            <div class="role-option" id="roleEmployee" onclick="selectRole(this, 'employee')">
                <input type="radio" name="user_role" value="employee" style="display:none;" required>
                <i class="fas fa-user-tie"></i><br>Employee
            </div>
            <div class="role-option admin" id="roleAdmin" onclick="selectRole(this, 'admin')">
                <input type="radio" name="user_role" value="admin" style="display:none;" required>
                <i class="fas fa-user-shield"></i><br>Admin
            </div>
        </div>

        <div class="form-group">
            <input type="text" name="user_name" placeholder="Full Name" required autocomplete="off" />
        </div>

        <div class="form-group">
            <input type="email" name="user_email" placeholder="Email" required autocomplete="off" />
        </div>

        <div class="form-group" id="departmentField">
            <select name="user_department" required>
                <option value="" disabled selected>Select Department</option>
                <option value="IT">IT</option>
                <option value="HR">HR</option>
                <option value="Finance">Finance</option>
                <option value="Marketing">Marketing</option>
                <option value="Operations">Operations</option>
                <option value="Sales">Sales</option>
                <option value="Support">Support</option>
                <option value="R&D">R&D</option>
            </select>
        </div>

        <div class="form-group">
            <input type="password" name="user_password" placeholder="Password" required autocomplete="new-password" />
        </div>

        <div class="form-group">
            <input type="password" id="confirm_password" placeholder="Confirm Password" required autocomplete="new-password" />
        </div>

        <button type="submit" class="btn-register">Register</button>
    </form>
</div>

<script>
    // Initialize role selection to employee by default
    window.onload = function() {
        selectRole(document.getElementById('roleEmployee'), 'employee');
    }

    function selectRole(element, role) {
        document.querySelectorAll('.role-option').forEach(opt => {
            opt.classList.remove('active');
            opt.querySelector('input[type="radio"]').checked = false;
        });

        element.classList.add('active');
        element.querySelector('input[type="radio"]').checked = true;

        const deptSelect = document.querySelector('select[name="user_department"]');
        const deptField = document.getElementById('departmentField');

        if (role === 'admin') {
            deptField.style.display = 'none';
            deptSelect.disabled = true;
            deptSelect.required = false;
        } else {
            deptField.style.display = 'block';
            deptSelect.disabled = false;
            deptSelect.required = true;
        }
    }

    // Password confirmation check
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const password = this.user_password.value;
        const confirmPassword = document.getElementById('confirm_password').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            alert('Passwords do not match!');
            return false;
        }
        return true;
    });
</script>

</body>
</html>
