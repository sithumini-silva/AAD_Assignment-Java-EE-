<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>WorkNet Employee Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/animate.css@4.1.1/animate.min.css">
    <style>
        :root {
            --primary: #e67e22;       /* Vibrant orange accent */
            --primary-dark: #d35400;  /* Deeper orange for hover */
            --bg-dark: #f4f4f4;       /* Light background */
            --bg-darker: #e9e9e9;     /* Slightly darker light gray */
            --card-bg: #ffffff;       /* Pure white card bg */
            --navbar-bg: #f0f0f0;     /* Light navbar bg */
            --text-light: #333333;    /* Dark text for contrast */
            --text-muted: #777777;    /* Muted text */
        }


        body {
            background-color: var(--bg-dark);
            color: var(--text-light);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background-color: var(--navbar-bg);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.5);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
        }

        .navbar h1 {
            color: var(--primary);
            font-size: 1.8rem;
            margin: 0;
        }

        .navbar-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 15px;
            border: 2px solid var(--primary);
        }

        .nav-links {
            display: flex;
            align-items: center;
        }

        .navbar a {
            color: var(--text-light);
            text-decoration: none;
            margin-left: 20px;
            transition: color 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .navbar a:hover {
            color: var(--primary);
        }

        .notification-badge {
            background-color: #ff4757;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            position: absolute;
            top: -5px;
            right: -5px;
        }

        .dashboard {
            padding: 40px 20px;
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: center;
            flex: 1;
        }

        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--primary);
            border-radius: 10px;
            width: 280px;
            padding: 25px;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                    transparent,
                    rgba(0, 234, 255, 0.1),
                    transparent
            );
            transform: rotate(45deg);
            transition: all 0.6s ease;
            opacity: 0;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 25px rgba(0, 234, 255, 0.3);
        }

        .card:hover::before {
            animation: shine 1.5s;
            opacity: 1;
        }

        @keyframes shine {
            0% {
                left: -50%;
                top: -50%;
            }
            100% {
                left: 150%;
                top: 150%;
            }
        }

        .card i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--primary);
        }

        .card h3 {
            font-size: 1.3rem;
            margin-bottom: 12px;
            font-weight: 600;
            color: #1abc9c;
        }

        .card p {
            font-size: 0.95rem;
            margin-bottom: 20px;
            color: var(--text-muted);
            line-height: 1.5;
        }

        .btn-neon {
            border: none;
            padding: 10px 25px;
            border-radius: 25px;
            background: var(--primary);
            color: #121212;
            font-weight: bold;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .btn-neon:hover {
            background: var(--primary-dark);
            color: white;
            box-shadow: 0 0 15px rgba(0, 234, 255, 0.5);
        }

        .btn-neon::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(255, 255, 255, 0.2),
                    transparent
            );
            transform: translateX(-100%);
            transition: 0.5s;
        }

        .btn-neon:hover::after {
            transform: translateX(100%);
        }

        footer {
            text-align: center;
            padding: 15px;
            font-size: 0.9rem;
            color: var(--text-muted);
            background-color: var(--navbar-bg);
            margin-top: auto;
        }

        .welcome-banner {
            background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
            padding: 30px;
            margin: 20px auto;
            border-radius: 10px;
            max-width: 1200px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            border-left: 5px solid var(--primary);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-text h2 {
            color: var(--primary);
            margin-bottom: 10px;
            font-size: 1.8rem;
        }

        .welcome-text p {
            color: var(--text-light);
            margin: 0;
            opacity: 0.9;
        }

        .stats-card {
            background-color: var(--bg-darker);
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            min-width: 120px;
        }

        .stats-card .number {
            font-size: 1.8rem;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 5px;
        }

        .stats-card .label {
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .quick-actions {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .quick-action-btn {
            background: rgba(0, 234, 255, 0.1);
            border: 1px solid var(--primary);
            color: var(--primary);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .quick-action-btn:hover {
            background: var(--primary);
            color: #121212;
        }

        .notification-icon {
            position: relative;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                padding: 15px;
            }

            .nav-links {
                margin-top: 15px;
            }

            .welcome-banner {
                flex-direction: column;
                text-align: center;
                gap: 20px;
            }

            .quick-actions {
                justify-content: center;
            }
        }

        /* Dark mode toggle */
        .theme-toggle {
            background: none;
            border: none;
            color: var(--text-light);
            cursor: pointer;
            font-size: 1.2rem;
            margin-left: 15px;
        }

        /* Animation classes */
        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Toast notification */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1100;
        }

        .toast {
            background-color: var(--card-bg);
            border-left: 4px solid var(--primary);
            color: var(--text-light);
            padding: 15px;
            border-radius: 4px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            transform: translateX(150%);
            transition: transform 0.3s ease;
        }

        .toast.show {
            transform: translateX(0);
        }

        .toast i {
            color: var(--primary);
        }
        .nav-link, .btn-neon {
            display: inline-block;
            padding: 10px 70px;
            border-radius: 25px;
            background: var(--primary);
            color: var(--bg-dark) !important;
            font-weight: bold;
            text-decoration: none;
            border: none;
            cursor: pointer;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            font-family: 'Segoe UI', sans-serif;
            font-size: 0.95rem;
            margin: 5px 0;
        }

        /* Hover effects for both */
        .nav-link:hover, .btn-neon:hover {
            background: var(--primary-dark);
            color: var(--text-light) !important;
            box-shadow: 0 0 15px rgba(0, 234, 255, 0.5);
            transform: translateY(-2px);
        }

        /* Shine animation for both */
        .nav-link::after, .btn-neon::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(255, 255, 255, 0.2),
                    transparent
            );
            transform: translateX(-100%);
            transition: 0.5s;
        }

        .nav-link:hover::after, .btn-neon:hover::after {
            transform: translateX(100%);
        }

        /* Specific adjustments for nav-items */
        .nav-item {
            list-style: none;
            margin: 0;
            padding: 0;
            display: inline-block;
        }

        /* Make sure text-white works */
        .text-white {
            color: var(--bg-dark) !important;
        }
    </style>
</head>

<body>
<!-- Toast Notification -->
<div class="toast-container">
    <div class="toast" id="notification-toast">
        <i class="fas fa-bell"></i>
        <div>
            <div class="toast-title">New Notification</div>
            <div class="toast-message">Welcome back to your dashboard!</div>
        </div>
    </div>
</div>

<div class="navbar">
    <div class="navbar-brand">
        <img src="https://ui-avatars.com/api/?name=Employee+Name&background=0D8ABC&color=fff" alt="Profile" class="navbar-avatar">
        <h1>WorkNet</h1>
    </div>
    <div class="nav-links">
        <a href="notifications.jsp" class="notification-icon">
            <i class="fas fa-bell"></i>
            <span class="notification-badge">3</span>
        </a>
        <a href="profile.jsp"><i class="fas fa-user"></i> Profile</a>
        <a href="settings.jsp"><i class="fas fa-cog"></i> Settings</a>
        <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        <button class="theme-toggle" id="themeToggle">
            <i class="fas fa-moon"></i>
        </button>
    </div>
</div>

<div class="welcome-banner animate__animated animate__fadeIn">
    <div class="welcome-text">
        <h2>Welcome back, Employee!</h2>
        <p>Here's what's happening with your complaints today.</p>
        <div class="quick-actions">
            <button class="quick-action-btn" onclick="location.href='userList.jsp'">
                <i class="fas fa-plus"></i> System Users
            </button>
            <button class="quick-action-btn" onclick="location.href=''">
                <i class="fas fa-history"></i> Recent Activity
            </button>
        </div>
    </div>
    <div class="stats-container" style="display: flex; gap: 15px;">
        <div class="stats-card">
            <div class="number">10</div>
            <div class="label">Total Users</div>
        </div>
        <div class="stats-card">
            <div class="number">8</div>
            <div class="label">Total Complaints</div>
        </div>
        <div class="stats-card">
            <div class="number">5</div>
            <div class="label">Urgent</div>
        </div>
    </div>
</div>

<div class="dashboard">
    <div class="card animate__animated animate__fadeIn animate__delay-1s">
        <i class="fas fa-comment-dots"></i>
        <h3>User View</h3>
        <p>View and manage all registered users in the system with their details and roles.</p>
        <li class="nav-item"><a class="nav-link text-white" href="<%= request.getContextPath() %>/userList.jsp"> User View </a></li>
    </div>

    <div class="card animate__animated animate__fadeIn animate__delay-2s">
        <i class="fas fa-list"></i>
        <h3>View All Complaints</h3>
        <p>Browse and monitor all submitted complaints, including their current status and history.</p>
        <li class="nav-item"><a class="nav-link text-white" href="<%= request.getContextPath() %>/complaint-details"> View </a></li>
    </div>

    <div class="card animate__animated animate__fadeIn animate__delay-3s">
        <i class="fas fa-edit"></i>
        <h3>Manage Complaints</h3>
        <p>Control your complaints by updating or deleting them before administrative assessment.</p>
        <li class="nav-item"><a class="nav-link text-white" href="<%= request.getContextPath() %>/complaint-details"> Manage </a></li>
    </div>

    <div class="card animate__animated animate__fadeIn animate__delay-4s">
        <i class="fas fa-chart-line"></i>
        <h3>Complaint Analytics</h3>
        <p>Analyze complaint data to identify trends, response times, and overall performance.</p>
        <button class="btn-neon" onclick="location.href='analytics.jsp'">View Stats</button>
    </div>

    <div class="card animate__animated animate__fadeIn animate__delay-5s">
        <i class="fas fa-question-circle"></i>
        <h3>Help Center</h3>
        <p>Get assistance on how to file effective complaints and understand the process.</p>
        <button class="btn-neon" onclick="location.href='help.jsp'">Get Help</button>
    </div>

    <div class="card animate__animated animate__fadeIn animate__delay-6s">
        <i class="fas fa-file-download"></i>
        <h3>Export Data</h3>
        <p>Download your complaint history in various formats for record keeping.</p>
        <button class="btn-neon" onclick="location.href='export.jsp'">Export</button>
    </div>
</div>

<footer>
    &copy; 2025 WorkNet. All rights reserved. | <a href="privacy.jsp" style="color: var(--primary);">Privacy Policy</a> | <a href="terms.jsp" style="color: var(--primary);">Terms of Service</a>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Show toast notification
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(function() {
            const toast = document.getElementById('notification-toast');
            toast.classList.add('show');

            setTimeout(() => {
                toast.classList.remove('show');
            }, 5000);
        }, 1000);
    });

    // Theme toggle functionality
    const themeToggle = document.getElementById('themeToggle');
    const icon = themeToggle.querySelector('i');

    themeToggle.addEventListener('click', function() {
        document.body.classList.toggle('light-theme');

        if (document.body.classList.contains('light-theme')) {
            document.body.style.setProperty('--bg-dark', '#f5f5f5');
            document.body.style.setProperty('--bg-darker', '#e0e0e0');
            document.body.style.setProperty('--card-bg', '#ffffff');
            document.body.style.setProperty('--navbar-bg', '#ffffff');
            document.body.style.setProperty('--text-light', '#333333');
            document.body.style.setProperty('--text-muted', '#666666');
            icon.classList.replace('fa-moon', 'fa-sun');
        } else {
            document.body.style.setProperty('--bg-dark', '#121212');
            document.body.style.setProperty('--bg-darker', '#0a0a0a');
            document.body.style.setProperty('--card-bg', '#1e1e1e');
            document.body.style.setProperty('--navbar-bg', '#1f1f1f');
            document.body.style.setProperty('--text-light', '#eee');
            document.body.style.setProperty('--text-muted', '#777');
            icon.classList.replace('fa-sun', 'fa-moon');
        }
    });

    // Card hover animations
    const cards = document.querySelectorAll('.card');
    cards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.classList.add('animate__pulse');
        });

        card.addEventListener('mouseleave', function() {
            this.classList.remove('animate__pulse');
        });
    });
</script>
</body>
</html>