<%--
  WorkNet Staff Registration - Final Version
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>WorkNet Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
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
            overflow: hidden;
        }

        /* Floating background circles */
        .floating-circles {
            position: absolute;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .circle {
            position: absolute;
            border-radius: 50%;
            opacity: 0.1;
            animation: float 15s infinite linear;
        }

        @keyframes float {
            0% { transform: translateY(0) rotate(0deg); }
            100% { transform: translateY(-100vh) rotate(360deg); }
        }

        .register-container {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(8px);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            padding: 25px;
            width: 100%;
            max-width: 350px;
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .register-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .register-header h2 {
            font-size: 1.5rem;
            margin-bottom: 5px;
        }

        .register-header p {
            font-size: 0.8rem;
            opacity: 0.8;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .input-group {
            position: relative;
        }

        .input-group-text {
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            background: transparent;
            border: none;
            z-index: 10;
            padding: 0 15px;
            display: flex;
            align-items: center;
            color: papayawhip;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: none;
            border-radius: 20px;
            color: white;
            padding: 8px 15px 8px 40px;
            width: 100%;
            font-size: 0.9rem;
            transition: all 0.3s;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.3);
        }

        .btn-register {
            background: var(--primary-color);
            border: none;
            border-radius: 20px;
            padding: 8px;
            font-size: 0.9rem;
            margin-top: 10px;
            width: 100%;
            transition: all 0.3s;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(0,0,0,0.2);
        }

        .role-selector {
            display: flex;
            gap: 8px;
            margin-bottom: 15px;
        }

        .role-option {
            flex: 1;
            padding: 10px;
            border-radius: 8px;
            cursor: pointer;
            background: rgba(255,255,255,0.05);
            text-align: center;
            font-size: 0.8rem;
            transition: all 0.3s;
        }

        .role-option.active {
            background: rgba(52, 152, 219, 0.2);
            border: 1px solid var(--primary-color);
        }

        .role-option.admin.active {
            background: rgba(231, 76, 60, 0.2);
            border: 1px solid var(--admin-color);
        }

        .role-option i {
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        .department-select {
            background: rgba(255,255,255,0.1);
            border: none;
            border-radius: 20px;
            color: white;
            padding: 8px 15px 8px 40px;
            width: 100%;
            font-size: 0.9rem;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 12px;
        }

        /* Colorful department options */
        .department-select option[value="IT"] { color: #3498db; }
        .department-select option[value="HR"] { color: #e74c3c; }
        .department-select option[value="Finance"] { color: #2ecc71; }
        .department-select option[value="Marketing"] { color: #f39c12; }
        .department-select option[value="Operations"] { color: #9b59b6; }
        .department-select option[value="Sales"] { color: #1abc9c; }
        .department-select option[value="Support"] { color: #d35400; }
        .department-select option[value="R&D"] { color: #27ae60; }

        .login-link {
            text-align: center;
            margin-top: 15px;
            font-size: 0.85rem;
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
        }

        .password-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: rgba(255,255,255,0.5);
            font-size: 0.9rem;
            z-index: 10;
        }
    </style>
</head>
<body>
<!-- Floating background circles -->
<div class="floating-circles">
    <div class="circle" style="width: 100px; height: 100px; background: #3498db; top: 20%; left: 10%; animation-duration: 20s;"></div>
    <div class="circle" style="width: 150px; height: 150px; background: #e74c3c; top: 60%; left: 70%; animation-duration: 25s;"></div>
    <div class="circle" style="width: 80px; height: 80px; background: #2ecc71; top: 80%; left: 30%; animation-duration: 18s;"></div>
</div>

<div class="register-container">
    <div class="register-header">
        <h2>WorkNet Staff Create Account</h2>
        <p>Join WorkNet as staff member</p>
    </div>

    <form action="user-register" method="post">
        <!-- Role Selection -->
        <!-- Modify the role selector section -->
        <div class="role-selector">
            <div class="role-option ${param.user_role == 'employee' ? 'active' : ''}"
                 onclick="selectRole(this, 'employee')">
                <i class="fas fa-user-tie"></i>
                <div>Employee</div>
                <input type="radio" name="user_role" value="employee"
                ${param.user_role == 'employee' ? 'checked' : ''}>
            </div>
            <div class="role-option admin ${param.user_role == 'admin' ? 'active' : ''}"
                 onclick="selectRole(this, 'admin')">
                <i class="fas fa-user-shield"></i>
                <div>Admin</div>
                <input type="radio" name="user_role" value="admin"
                ${param.user_role == 'admin' ? 'checked' : ''}>
            </div>
        </div>

        <!-- Add a hidden department field for admin -->
        <input type="hidden" id="adminDepartment" name="user_department" value="Administration">

        <!-- Name -->
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-user"></i></span>
                <input type="text" class="form-control" name="user_name" placeholder="Full Name" required autocomplete="off">
            </div>
        </div>

        <!-- Email -->
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                <input type="email" class="form-control" name="user_email" placeholder="Email" required autocomplete="off">
            </div>
        </div>

        <!-- Department (for employees) -->
        <div class="form-group" id="departmentField">
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-building"></i></span>
                <select class="department-select" name="user_department" required>
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
        </div>

        <!-- Password -->
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input type="password" class="form-control" name="user_password" placeholder="Password" required autocomplete="new-password">
                <span class="password-toggle" onclick="togglePassword(this)">
          <i class="fas fa-eye"></i>
        </span>
            </div>
        </div>

        <!-- Confirm Password -->
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input type="password" class="form-control" id="confirm_password" placeholder="Confirm Password" required autocomplete="new-password">
                <span class="password-toggle" onclick="togglePassword(this, 'confirm_password')">
          <i class="fas fa-eye"></i>
        </span>
            </div>
        </div>

        <button type="submit" class="btn btn-primary btn-register">
            <i class="fas fa-user-plus me-1"></i> Register
        </button>

        <div class="login-link">
            Already have an account? <a href="login.jsp">Sign In</a>
        </div>
    </form>
</div>

<script>
    // Toggle password visibility
    function togglePassword(icon, inputId) {
        const input = inputId ? document.getElementById(inputId) :
            icon.closest('.input-group').querySelector('input');
        if (input.type === 'password') {
            input.type = 'text';
            icon.innerHTML = '<i class="fas fa-eye-slash"></i>';
        } else {
            input.type = 'password';
            icon.innerHTML = '<i class="fas fa-eye"></i>';
        }
    }

    // Role selection
    // Modify the selectRole function
    function selectRole(element, role) {
        document.querySelectorAll('.role-option').forEach(opt => {
            opt.classList.remove('active');
            opt.querySelector('input[type="radio"]').checked = false;
        });

        element.classList.add('active');
        element.querySelector('input[type="radio"]').checked = true;

        if (role === 'admin') {
            document.getElementById('departmentField').style.display = 'none';
            // Set department to "Administration" for admin
            document.getElementById('adminDepartment').value = "Administration";
            document.querySelector('select[name="user_department"]').required = false;
        } else {
            document.getElementById('departmentField').style.display = 'block';
            document.querySelector('select[name="user_department"]').required = true;
        }
    }

    // Form validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const password = document.querySelector('input[name="user_password"]').value;
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