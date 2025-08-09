<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.webapp.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Sakina</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        
        /* Navigation Bar */
        .navbar {
            background: white;
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .nav-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 28px;
            font-weight: 700;
            color: #4facfe;
            text-decoration: none;
        }
        
        .nav-brand i {
            font-size: 32px;
        }
        
        .nav-links {
            display: flex;
            gap: 30px;
            align-items: center;
        }
        
        .nav-link {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        
        .nav-link:hover, .nav-link.active {
            color: #4facfe;
        }
        
        .nav-user {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .welcome-text {
            color: #666;
            font-size: 14px;
        }
        
        .logout-btn {
            background: #ff6b6b;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            transition: background 0.3s ease;
        }
        
        .logout-btn:hover {
            background: #ff5252;
        }
        
        /* Main Content */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 50px;
        }
        
        .page-title {
            font-size: 36px;
            color: #333;
            margin-bottom: 10px;
            font-weight: 700;
        }
        
        .page-subtitle {
            font-size: 18px;
            color: #666;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }
        
        .user-greeting {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            margin-bottom: 40px;
        }
        
        .greeting-icon {
            font-size: 60px;
            margin-bottom: 15px;
        }
        
        .greeting-text {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .greeting-subtitle {
            font-size: 16px;
            opacity: 0.9;
        }
        
        /* Statistics Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            text-align: center;
            transition: all 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        
        .stat-number {
            font-size: 32px;
            font-weight: 700;
            color: #4facfe;
            margin-bottom: 10px;
        }
        
        .stat-label {
            color: #666;
            font-size: 14px;
        }
        
        /* Quick Actions */
        .quick-actions {
            margin-bottom: 40px;
        }
        
        .section-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 25px;
            text-align: center;
        }
        
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }
        
        .quick-action {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
            transition: all 0.3s ease;
        }
        
        .quick-action:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }
        
        .quick-action i {
            font-size: 24px;
            margin-bottom: 10px;
        }
        
        .action-title {
            font-size: 18px;
            font-weight: 500;
            color: #333;
            margin-bottom: 5px;
        }
        
        .action-desc {
            color: #666;
            font-size: 14px;
        }
        
        /* Recent Activity */
        .recent-activity {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .activity-list {
            max-height: 300px;
            overflow-y: auto;
        }
        
        .recent-activity-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .recent-activity-item:last-child {
            border-bottom: none;
        }
        
        .recent-activity-item i {
            width: 40px;
            height: 40px;
            background: #f0f8ff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #4facfe;
            font-size: 16px;
            flex-shrink: 0;
        }
        
        .activity-content {
            flex-grow: 1;
        }
        
        .activity-title {
            font-size: 16px;
            color: #333;
            margin-bottom: 5px;
        }
        
        .activity-time {
            color: #999;
            font-size: 14px;
        }
        
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .page-title {
                font-size: 28px;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .actions-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="dashboard" class="nav-brand">
                <i class="fas fa-heart"></i>
                Sakina
            </a>
            <div class="nav-links">
                <a href="dashboard" class="nav-link active">Dashboard</a>
                <a href="articles" class="nav-link">Articles</a>
                <a href="books" class="nav-link">Books</a>
            </div>
            <div class="nav-user">
                <span class="welcome-text">Welcome, <%= user.getFirstName() %>!</span>
                <a href="logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Mental Wellness Dashboard</h1>
            <p class="page-subtitle">Track your mental health journey and access personalized resources</p>
        </div>

        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <i class="fas fa-newspaper" style="color: #4facfe;"></i>
                <div class="stat-number">12</div>
                <div class="stat-label">Articles Read</div>
            </div>
            <div class="stat-card">
                <i class="fas fa-book-open" style="color: #27ae60;"></i>
                <div class="stat-number">3</div>
                <div class="stat-label">Books Downloaded</div>
            </div>
            <div class="stat-card">
                <i class="fas fa-clock" style="color: #f39c12;"></i>
                <div class="stat-number">8h 30m</div>
                <div class="stat-label">Total Meditation</div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <h2 class="section-title">Quick Actions</h2>
            <div class="actions-grid">
                <a href="articles" class="quick-action">
                    <i class="fas fa-newspaper" style="color: #4facfe;"></i>
                    <div class="action-title">Read Articles</div>
                    <div class="action-desc">Explore mental health articles</div>
                </a>
                <a href="books" class="quick-action">
                    <i class="fas fa-book-open" style="color: #27ae60;"></i>
                    <div class="action-title">Browse Books</div>
                    <div class="action-desc">Download wellness resources</div>
                </a>
                <a href="support" class="quick-action">
                    <i class="fas fa-life-ring" style="color: #9b59b6;"></i>
                    <div class="action-title">Get Support</div>
                    <div class="action-desc">Access help and mental health resources</div>
                </a>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="recent-activity">
            <h2 class="section-title">Recent Activity</h2>
            <div class="activity-list">
                <div class="recent-activity-item">
                    <i class="fas fa-book-open"></i>
                    <div class="activity-content">
                        <div class="activity-title">Read "Understanding Anxiety"</div>
                        <div class="activity-time">2 hours ago</div>
                    </div>
                </div>
                
                <div class="recent-activity-item">
                    <i class="fas fa-download"></i>
                    <div class="activity-content">
                        <div class="activity-title">Downloaded "Mindfulness Guide"</div>
                        <div class="activity-time">1 day ago</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
