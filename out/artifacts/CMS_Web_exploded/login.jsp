<%--
  Secure Staff Login Portal
  Role-based access for Employees and Admins only
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Secure Employee Access Point</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<style>
  :root {
    --primary-color: #3498db;
    --secondary-color: #2c3e50;
    --accent-color: #e74c3c;
    --light-color: #ecf0f1;
    --dark-color: #2c3e50;
  }

  body {
    background: linear-gradient(135deg, var(--secondary-color), var(--dark-color));
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    height: 100vh;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
  }

  .login-container {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    padding: 40px;
    width: 100%;
    max-width: 450px;
    color: white;
    position: relative;
    overflow: hidden;
    z-index: 1;
    border: 1px solid rgba(255, 255, 255, 0.1);
    transform-style: preserve-3d;
    transition: all 0.5s ease;
  }

  .login-container:hover {
    transform: translateY(-5px);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
  }

  .login-container::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
    z-index: -1;
    animation: rotate 15s linear infinite;
  }

  @keyframes rotate {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }

  .login-header {
    text-align: center;
    margin-bottom: 30px;
  }

  .login-header h2 {
    font-weight: 700;
    margin-bottom: 10px;
    color: var(--light-color);
    text-shadow: 0 2px 4px rgba(0,0,0,0.3);
  }

  .login-header p {
    opacity: 0.8;
    font-size: 0.9rem;
  }

  .form-group {
    position: relative;
    margin-bottom: 20px;
  }

  .form-control {
    background: rgba(255, 255, 255, 0.1);
    border: none;
    border-radius: 30px;
    color: white;
    padding: 12px 20px 12px 45px;
    width: 100%;
    transition: all 0.3s ease;
  }

  .form-control:focus {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
  }

  .form-control::placeholder {
    color: rgba(255, 255, 255, 0.6);
  }

  .input-icon {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: rgba(255, 255, 255, 0.8);
    z-index: 2;
    color: #2c3e50;
  }

  .btn-login {
    background: var(--primary-color);
    border: none;
    border-radius: 30px;
    padding: 12px;
    font-weight: 600;
    letter-spacing: 1px;
    width: 100%;
    margin-top: 10px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  .btn-login:hover {
    background: #2980b9;
    transform: translateY(-2px);
    box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
  }

  .role-selector {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
    gap: 15px;
  }

  .role-option {
    flex: 1;
    max-width: 180px;
    text-align: center;
    padding: 15px;
    border-radius: 10px;
    cursor: pointer;
    transition: all 0.3s ease;
    background: rgba(255, 255, 255, 0.05);
    border: 2px solid transparent;
  }

  .role-option:hover {
    background: rgba(255, 255, 255, 0.1);
  }

  .role-option.active {
    background: rgba(52, 152, 219, 0.2);
    border-color: var(--primary-color);
  }

  .role-option i {
    font-size: 1.5rem;
    margin-bottom: 10px;
    display: block;
  }

  .forgot-password {
    text-align: center;
    margin-top: 15px;
  }

  .forgot-password a {
    color: rgba(255, 255, 255, 0.7);
    text-decoration: none;
    font-size: 0.85rem;
    transition: color 0.3s ease;
  }

  .forgot-password a:hover {
    color: white;
    text-decoration: underline;
  }

  .floating-shapes {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    z-index: -2;
  }

  .shape {
    position: absolute;
    opacity: 0.1;
    border-radius: 50%;
    animation: float 15s infinite linear;
  }

  @keyframes float {
    0% { transform: translateY(0) rotate(0deg); }
    100% { transform: translateY(-1000px) rotate(720deg); }
  }

  .alert-notification {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 1000;
    animation: slideIn 0.5s forwards, fadeOut 0.5s 2.5s forwards;
  }

  @keyframes slideIn {
    from { transform: translateX(100%); }
    to { transform: translateX(0); }
  }

  @keyframes fadeOut {
    from { opacity: 1; }
    to { opacity: 0; }
  }

  .password-toggle {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: rgba(255, 255, 255, 0.6);
    z-index: 2;
  }

  .password-toggle:hover {
    color: white;
  }

  .signup-link {
    text-align: center;
    margin-top: 20px;
  }

  .signup-link a {
    color: var(--primary-color);
    text-decoration: none;
    font-weight: 500;
    transition: all 0.3s ease;
  }

  .signup-link a:hover {
    text-decoration: underline;
    color: #2980b9;
  }
</style>

<body>
<!-- Floating background shapes -->
<div class="floating-shapes">
  <div class="shape" style="width: 100px; height: 100px; background: #e74c3c; top: 20%; left: 10%; animation-duration: 20s;"></div>
  <div class="shape" style="width: 150px; height: 150px; background: #3498db; top: 60%; left: 70%; animation-duration: 25s;"></div>
  <div class="shape" style="width: 80px; height: 80px; background: #2ecc71; top: 80%; left: 30%; animation-duration: 18s;"></div>
  <div class="shape" style="width: 120px; height: 120px; background: #f39c12; top: 30%; left: 80%; animation-duration: 22s;"></div>
</div>

<!-- Error/Success Messages -->
<%
  String error = request.getParameter("error");
  String message = request.getParameter("message");
  if (error != null) { %>
<div class="alert alert-danger alert-notification animate__animated animate__fadeInRight">
  <i class="fas fa-exclamation-circle me-2"></i> <%= error %>
</div>
<% }
  if (message != null) { %>
<div class="alert alert-success alert-notification animate__animated animate__fadeInRight">
  <i class="fas fa-check-circle me-2"></i> <%= message %>
</div>
<% } %>

<!-- Main Login Container -->
<div class="login-container animate__animated animate__fadeInUp">
  <div class="login-header">
    <h2>WorkNet Staff Login</h2>
    <p>Please sign in to access the system</p>
  </div>

  <form action="user-login" method="post">
    <!-- Role Selection -->
    <div class="role-selector">
      <div class="role-option active" onclick="selectRole(this, 'employee')">
        <i class="fas fa-user-tie"></i>
        <span>Employee</span>
        <input type="radio" name="user_role" value="employee" checked style="display: none;">
      </div>
      <div class="role-option" onclick="selectRole(this, 'admin')">
        <i class="fas fa-user-shield"></i>
        <span>Administrator</span>
        <input type="radio" name="user_role" value="admin" style="display: none;">
      </div>
    </div>

    <!-- Email Input -->
    <div class="form-group">
      <i class="fas fa-envelope input-icon"></i>
      <input type="email" class="form-control" name="user_email" placeholder="Work Email" required>
    </div>

    <!-- Password Input with Toggle -->
    <div class="form-group">
      <i class="fas fa-lock input-icon"></i>
      <input type="password" class="form-control" id="password" name="user_password" placeholder="Password" required>
      <span class="password-toggle" onclick="togglePassword()">
        <i class="fas fa-eye" id="toggleIcon"></i>
      </span>
    </div>

    <!-- Submit Button -->
    <button type="submit" class="btn btn-login">
      <i class="fas fa-sign-in-alt me-2"></i> Sign In
    </button>

    <!-- Forgot Password Link -->
    <div class="forgot-password">
      <a href="forgot-password.jsp">Forgot your password?</a>
    </div>

    <!-- Sign Up Navigation -->
    <div class="signup-link">
      <span>Don't have an account? </span>
      <a href="signUp.jsp">Request access</a>
    </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Role selection
  function selectRole(element, role) {
    document.querySelectorAll('.role-option').forEach(opt => {
      opt.classList.remove('active');
      opt.querySelector('input').checked = false;
    });

    element.classList.add('active');
    element.querySelector('input').checked = true;
  }

  // Password toggle
  function togglePassword() {
    const passwordField = document.getElementById('password');
    const toggleIcon = document.getElementById('toggleIcon');

    if (passwordField.type === 'password') {
      passwordField.type = 'text';
      toggleIcon.classList.remove('fa-eye');
      toggleIcon.classList.add('fa-eye-slash');
    } else {
      passwordField.type = 'password';
      toggleIcon.classList.remove('fa-eye-slash');
      toggleIcon.classList.add('fa-eye');
    }
  }

  // Auto-hide notifications after 3 seconds
  setTimeout(() => {
    const alerts = document.querySelectorAll('.alert-notification');
    alerts.forEach(alert => {
      alert.style.display = 'none';
    });
  }, 3000);
</script>
</body>
</html>