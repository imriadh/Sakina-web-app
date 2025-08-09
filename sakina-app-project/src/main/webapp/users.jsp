<%@ page import="java.util.List" %>
<%@ page import="com.webapp.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registered Users - Web App</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .header p {
            font-size: 16px;
            opacity: 0.9;
        }
        
        .content {
            padding: 40px;
        }
        
        .stats {
            display: flex;
            justify-content: center;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: #f8f9fa;
            padding: 20px 40px;
            border-radius: 10px;
            text-align: center;
            border-left: 4px solid #667eea;
        }
        
        .stat-number {
            font-size: 36px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #666;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .users-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .user-card {
            background: #fff;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            padding: 25px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        
        .user-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .user-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .user-name {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        
        .user-email {
            color: #666;
            font-size: 14px;
            margin-bottom: 8px;
        }
        
        .user-phone {
            color: #888;
            font-size: 14px;
        }
        
        .no-users {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .no-users i {
            font-size: 48px;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        .actions {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 30px;
            margin: 0 10px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-secondary {
            background: #f8f9fa;
            color: #333;
            border: 2px solid #e9ecef;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Registered Users</h1>
            <p>Welcome to our growing community</p>
        </div>
        
        <div class="content">
            <%
                List<User> users = (List<User>) request.getAttribute("users");
                int userCount = users != null ? users.size() : 0;
            %>
            
            <div class="stats">
                <div class="stat-card">
                    <div class="stat-number"><%= userCount %></div>
                    <div class="stat-label">Total Users</div>
                </div>
            </div>
            
            <% if (users != null && !users.isEmpty()) { %>
                <div class="users-grid">
                    <% for (User user : users) { %>
                        <div class="user-card">
                            <div class="user-avatar">
                                <%= user.getFirstName().substring(0, 1).toUpperCase() %><%= user.getLastName().substring(0, 1).toUpperCase() %>
                            </div>
                            <div class="user-name">
                                <%= user.getFirstName() %> <%= user.getLastName() %>
                            </div>
                            <div class="user-email">
                                📧 <%= user.getEmail() %>
                            </div>
                            <% if (user.getPhone() != null && !user.getPhone().trim().isEmpty()) { %>
                                <div class="user-phone">
                                    📱 <%= user.getPhone() %>
                                </div>
                            <% } %>
                        </div>
                    <% } %>
                </div>
            <% } else { %>
                <div class="no-users">
                    <div style="font-size: 48px; margin-bottom: 20px;">👥</div>
                    <h3>No users registered yet</h3>
                    <p>Be the first to join our community!</p>
                </div>
            <% } %>
            
            <div class="actions">
                <a href="signup" class="btn btn-primary">Sign Up New User</a>
                <a href="login" class="btn btn-secondary">Sign In</a>
                <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
            </div>
        </div>
    </div>
</body>
</html>
