<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.webapp.model.Article" %>
<%@ page import="com.webapp.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    List<Article> articles = (List<Article>) request.getAttribute("articles");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mental Health Articles - Sakina</title>
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
            font-size: 42px;
            color: #333;
            margin-bottom: 15px;
            font-weight: 700;
        }
        
        .page-subtitle {
            font-size: 18px;
            color: #666;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }
        
        /* Articles Grid */
        .articles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .article-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        
        .article-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        
        .article-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 20px;
            text-align: center;
        }
        
        .article-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }
        
        .article-content {
            padding: 25px;
        }
        
        .article-title {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
            line-height: 1.4;
        }
        
        .article-excerpt {
            color: #666;
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .article-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            font-size: 13px;
            color: #888;
        }
        
        .article-author {
            font-weight: 500;
        }
        
        .read-more-btn {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            display: inline-block;
            transition: all 0.3s ease;
            width: 100%;
            text-align: center;
        }
        
        .read-more-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.4);
        }
        
        .no-articles {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .page-title {
                font-size: 32px;
            }
            
            .articles-grid {
                grid-template-columns: 1fr;
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
            <h1 class="page-title">Mental Health Articles</h1>
            <p class="page-subtitle">
                Explore our collection of expert-written articles on mental health, mindfulness, 
                wellness strategies, and personal growth to support your mental well-being journey.
            </p>
        </div>
        
        <% if (error != null) { %>
            <div class="error-message">
                <%= error %>
            </div>
        <% } %>
        
        <% if (articles != null && !articles.isEmpty()) { %>
            <div class="articles-grid">
                <% for (Article article : articles) { %>
                    <div class="article-card">
                        <div class="article-header">
                            <div class="article-icon">📝</div>
                        </div>
                        <div class="article-content">
                            <h2 class="article-title"><%= article.getTitle() %></h2>
                            <div class="article-meta">
                                <span class="article-author">By <%= article.getAuthor() %></span>
                                <span class="article-date">
                                    <%= article.getDatePosted() != null ? 
                                        article.getDatePosted().toLocalDate().toString() : "Recent" %>
                                </span>
                            </div>
                            <p class="article-excerpt">
                                <%= article.getExcerpt() != null ? article.getExcerpt() : 
                                    (article.getContent().length() > 150 ? 
                                     article.getContent().substring(0, 150) + "..." : 
                                     article.getContent()) %>
                            </p>
                            <a href="articles?action=view&id=<%= article.getId() %>" class="read-more-btn">
                                Read Full Article
                            </a>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="no-articles">
                <h3>No articles available at the moment</h3>
                <p>Check back soon for new mental health articles and resources.</p>
            </div>
        <% } %>
    </div>
</body>
</html>