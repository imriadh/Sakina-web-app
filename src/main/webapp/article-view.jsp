<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.webapp.model.Article" %>
<%@ page import="com.webapp.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    Article article = (Article) request.getAttribute("article");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= article != null ? article.getTitle() : "Article" %> - Sakina</title>
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
            line-height: 1.6;
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
            font-size: 28px;
            font-weight: 700;
            color: #4facfe;
            text-decoration: none;
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
        
        /* Article Content */
        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: white;
            color: #4facfe;
            padding: 12px 20px;
            border: 2px solid #4facfe;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }
        
        .back-btn:hover {
            background: #4facfe;
            color: white;
        }
        
        .article-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .article-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }
        
        .article-icon {
            font-size: 60px;
            margin-bottom: 20px;
        }
        
        .article-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 15px;
            line-height: 1.3;
        }
        
        .article-meta {
            font-size: 16px;
            opacity: 0.9;
        }
        
        .article-body {
            padding: 50px;
        }
        
        .article-content {
            font-size: 18px;
            line-height: 1.8;
            color: #333;
        }
        
        /* Typography for article content */
        .article-content h2 {
            color: #2c3e50;
            font-size: 28px;
            margin: 40px 0 20px 0;
            font-weight: 600;
            border-bottom: 3px solid #4facfe;
            padding-bottom: 10px;
        }
        
        .article-content h3 {
            color: #34495e;
            font-size: 24px;
            margin: 30px 0 15px 0;
            font-weight: 600;
        }
        
        .article-content h4 {
            color: #4facfe;
            font-size: 20px;
            margin: 25px 0 12px 0;
            font-weight: 600;
        }
        
        .article-content p {
            margin-bottom: 20px;
            text-align: justify;
        }
        
        .article-content ul,
        .article-content ol {
            margin: 20px 0;
            padding-left: 30px;
        }
        
        .article-content li {
            margin-bottom: 12px;
        }
        
        .article-content strong {
            color: #2c3e50;
            font-weight: 600;
        }
        
        .article-content ul li {
            position: relative;
        }
        
        .article-content ul li::marker {
            color: #4facfe;
        }
        
        /* Quote styles */
        .article-content blockquote {
            background: #f8f9fa;
            border-left: 5px solid #4facfe;
            padding: 20px;
            margin: 25px 0;
            font-style: italic;
            color: #555;
        }
        
        .article-footer {
            padding: 30px 50px;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
            text-align: center;
        }
        
        .footer-text {
            color: #666;
            font-size: 16px;
            margin-bottom: 20px;
        }
        
        .back-to-articles {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 14px 30px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-block;
        }
        
        .back-to-articles:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.4);
        }
        
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .article-header {
                padding: 30px 20px;
            }
            
            .article-title {
                font-size: 26px;
            }
            
            .article-body {
                padding: 30px 25px;
            }
            
            .article-content {
                font-size: 16px;
            }
            
            .article-content h2 {
                font-size: 24px;
            }
            
            .article-content h3 {
                font-size: 20px;
            }
            
            .article-footer {
                padding: 25px 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="dashboard" class="nav-brand">🧘‍♀️ Sakina</a>
            <div class="nav-links">
                <a href="dashboard" class="nav-link">Dashboard</a>
                <a href="articles" class="nav-link active">Articles</a>
                <a href="books" class="nav-link">Books</a>
                <a href="breathing" class="nav-link">Breathing</a>
            </div>
            <div class="nav-user">
                <span class="welcome-text">Welcome, <%= user.getFirstName() %>!</span>
                <a href="logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <a href="articles" class="back-btn">
            ← Back to Articles
        </a>
        
        <% if (article != null) { %>
            <div class="article-container">
                <div class="article-header">
                    <div class="article-icon">📝</div>
                    <h1 class="article-title"><%= article.getTitle() %></h1>
                    <div class="article-meta">
                        By <%= article.getAuthor() %> • 
                        <%= article.getDatePosted() != null ? 
                            article.getDatePosted().toLocalDate().toString() : "Recent" %>
                    </div>
                </div>
                
                <div class="article-body">
                    <div class="article-content">
                        <!-- Render HTML content directly instead of escaping it -->
                        <%= article.getContent() %>
                    </div>
                </div>
                
                <div class="article-footer">
                    <p class="footer-text">
                        We hope this article was helpful for your mental well-being journey. 
                        Remember to practice self-care and seek professional help if needed.
                    </p>
                    <a href="articles" class="back-to-articles">
                        Explore More Articles
                    </a>
                </div>
            </div>
        <% } else { %>
            <div class="article-container">
                <div class="article-body" style="text-align: center; padding: 60px;">
                    <h2>Article Not Found</h2>
                    <p style="margin: 20px 0;">The article you're looking for doesn't exist or has been removed.</p>
                    <a href="articles" class="back-to-articles">
                        Back to Articles
                    </a>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html>