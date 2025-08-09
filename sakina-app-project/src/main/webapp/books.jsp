<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.webapp.model.Book" %>
<%@ page import="com.webapp.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    List<Book> books = (List<Book>) request.getAttribute("books");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books Library - Sakina</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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
            color: #333;
        }

        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
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

        .nav-links {
            display: flex;
            gap: 30px;
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
            color: white;
        }

        .page-title {
            font-size: 42px;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .page-subtitle {
            font-size: 18px;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Books Grid */
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .book-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .book-cover {
            width: 120px;
            height: 160px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 32px;
        }

        .book-title {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
            text-align: center;
        }

        .book-author {
            font-size: 14px;
            color: #666;
            text-align: center;
            margin-bottom: 15px;
        }

        .book-description {
            font-size: 14px;
            color: #666;
            line-height: 1.5;
            margin-bottom: 20px;
            flex-grow: 1;
        }

        .book-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12px;
            color: #999;
            margin-bottom: 20px;
        }

        .book-actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s ease;
            flex: 1;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.4);
        }

        .btn-outline {
            background: transparent;
            color: #4facfe;
            border: 2px solid #4facfe;
        }

        .btn-outline:hover {
            background: #4facfe;
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 60px;
            color: white;
        }

        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .books-grid {
                grid-template-columns: 1fr;
            }
            
            .page-title {
                font-size: 32px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="dashboard" class="nav-brand">
                <i class="fas fa-heart"></i>
                Sakina
            </a>
            <div class="nav-links">
                <a href="dashboard" class="nav-link">Dashboard</a>
                <a href="articles" class="nav-link">Articles</a>
                <a href="books" class="nav-link active">Books</a>
                
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
            <h1 class="page-title">
                <i class="fas fa-book-open" style="margin-right: 15px;"></i>
                Books Library
            </h1>
            <p class="page-subtitle">
                Discover our curated collection of mental wellness and self-help books. 
                Read online or download for offline access.
            </p>
        </div>

        <% if (error != null) { %>
            <div style="background: #ff6b6b; color: white; padding: 15px; border-radius: 8px; margin-bottom: 30px; text-align: center;">
                <%= error %>
            </div>
        <% } %>

        <% if (books != null && !books.isEmpty()) { %>
            <div class="books-grid">
                <% for (Book book : books) { %>
                    <div class="book-card">
                        <div class="book-cover">
                            <% if ("Weakness of Faith".equals(book.getTitle())) { %>
                                <i class="fas fa-moon"></i>
                            <% } else { %>
                                <i class="fas fa-book"></i>
                            <% } %>
                        </div>
                        
                        <h3 class="book-title"><%= book.getTitle() %></h3>
                        
                        <% if (book.getAuthor() != null && !book.getAuthor().trim().isEmpty()) { %>
                            <p class="book-author">By <%= book.getAuthor() %></p>
                        <% } %>
                        
                        <% if (book.getDescription() != null && !book.getDescription().trim().isEmpty()) { %>
                            <p class="book-description">
                                <%= book.getDescription().length() > 150 ? 
                                    book.getDescription().substring(0, 150) + "..." : 
                                    book.getDescription() %>
                            </p>
                        <% } %>
                        
                        <div class="book-meta">
                            <span><i class="fas fa-file-pdf"></i> PDF</span>
                            <span><i class="fas fa-download"></i> <%= book.getFormattedFileSize() %></span>
                        </div>
                        
                        <div class="book-actions">
                            <a href="books?action=view&id=<%= book.getId() %>" class="btn btn-primary">
                                <i class="fas fa-eye"></i> View Book
                            </a>
                            <a href="books?action=download&id=<%= book.getId() %>" class="btn btn-outline">
                                <i class="fas fa-download"></i> Download
                            </a>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="empty-state">
                <i class="fas fa-book-open"></i>
                <h3>No Books Available</h3>
                <p>Check back soon for new additions to our library.</p>
            </div>
        <% } %>
    </div>
</body>
</html>