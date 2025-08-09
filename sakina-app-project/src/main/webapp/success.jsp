<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Successful - Web App</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .success-container {
            background: white;
            padding: 60px 40px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        
        .success-icon {
            width: 80px;
            height: 80px;
            background: #28a745;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            font-size: 40px;
            color: white;
        }
        
        .success-container h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 20px;
        }
        
        .success-message {
            color: #666;
            font-size: 18px;
            margin-bottom: 40px;
            line-height: 1.6;
        }
        
        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: transform 0.2s ease;
            display: inline-block;
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
        
        .user-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin: 30px 0;
            text-align: left;
        }
        
        .user-info h3 {
            color: #333;
            margin-bottom: 15px;
            text-align: center;
        }
        
        .user-info p {
            margin: 8px 0;
            color: #666;
        }
        
        .user-info strong {
            color: #333;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon">
            ✓
        </div>
        
        <h1>Welcome Aboard!</h1>
        
        <div class="success-message">
            <% if (request.getAttribute("success") != null) { %>
                <%= request.getAttribute("success") %>
            <% } else { %>
                Your account has been created successfully!
            <% } %>
        </div>
        
        <div class="btn-group">
            <a href="index.jsp" class="btn btn-primary">Go to Home</a>
            <a href="users" class="btn btn-secondary">View All Users</a>
        </div>
    </div>
</body>
</html>
