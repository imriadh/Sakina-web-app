<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.webapp.model.Book" %>
<%@ page import="com.webapp.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    Book book = (Book) request.getAttribute("book");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= book != null ? book.getTitle() : "Book" %> - Sakina</title>
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
            line-height: 1.6;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: white;
            color: #667eea;
            padding: 12px 20px;
            border: 2px solid #667eea;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }
        
        .back-btn:hover {
            background: #667eea;
            color: white;
        }
        
        .book-header {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            display: grid;
            grid-template-columns: auto 1fr auto;
            gap: 30px;
            align-items: center;
        }
        
        .book-cover {
            width: 200px;
            height: 280px;
            background: linear-gradient(135deg, #2c3e50, #34495e);
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        
        .book-cover i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #f39c12;
        }
        
        .book-cover h3 {
            font-size: 18px;
            font-weight: 600;
            line-height: 1.3;
        }
        
        .book-info h1 {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .book-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin: 15px 0;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
        }
        
        .meta-item i {
            color: #3498db;
        }
        
        .book-description {
            color: #555;
            font-size: 1.1rem;
            line-height: 1.7;
            margin-top: 15px;
        }
        
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #27ae60, #229954);
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .content-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .tabs {
            display: flex;
            border-bottom: 2px solid #ecf0f1;
            margin-bottom: 30px;
        }
        
        .tab {
            padding: 15px 25px;
            cursor: pointer;
            border: none;
            background: none;
            font-size: 1rem;
            font-weight: 600;
            color: #666;
            border-bottom: 3px solid transparent;
            transition: all 0.3s ease;
        }
        
        .tab.active {
            color: #3498db;
            border-bottom-color: #3498db;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
        
        .pdf-viewer {
            width: 100%;
            height: 800px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background: #f8f9fa;
        }
        
        .loading {
            text-align: center;
            padding: 50px;
            color: #666;
        }
        
        @media (max-width: 768px) {
            .book-header {
                grid-template-columns: 1fr;
                text-align: center;
            }
            
            .book-cover {
                width: 150px;
                height: 210px;
                margin: 0 auto;
            }
            
            .book-info h1 {
                font-size: 2rem;
            }
        }
    </style>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <a href="books" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Library
        </a>
        
        <% if (book != null) { %>
            <div class="book-header">
                <div class="book-cover">
                    <% if ("Weakness of Faith".equals(book.getTitle())) { %>
                        <i class="fas fa-mosque"></i>
                    <% } else { %>
                        <i class="fas fa-book"></i>
                    <% } %>
                    <h3><%= book.getTitle() %></h3>
                </div>
                
                <div class="book-info">
                    <h1><%= book.getTitle() %></h1>
                    <div class="book-meta">
                        <% if (book.getAuthor() != null && !book.getAuthor().trim().isEmpty()) { %>
                            <div class="meta-item">
                                <i class="fas fa-user"></i>
                                <span><%= book.getAuthor() %></span>
                            </div>
                        <% } %>
                        <div class="meta-item">
                            <i class="fas fa-file-pdf"></i>
                            <span>PDF Format</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-download"></i>
                            <span><%= book.getFormattedFileSize() %></span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-calendar"></i>
                            <span><%= book.getDateUploaded() != null ? 
                                book.getDateUploaded().toLocalDate().toString() : "Recent" %></span>
                        </div>
                    </div>
                    <% if (book.getDescription() != null && !book.getDescription().trim().isEmpty()) { %>
                        <div class="book-description">
                            <%= book.getDescription() %>
                        </div>
                    <% } %>
                </div>
                
                <div class="action-buttons">
                    <button class="btn btn-primary" onclick="openReader()">
                        <i class="fas fa-book-open"></i>
                        Read Online
                    </button>
                    <a href="books?action=download&id=<%= book.getId() %>" class="btn btn-secondary">
                        <i class="fas fa-download"></i>
                        Download PDF
                    </a>
                </div>
            </div>
            
            <div class="content-section">
                <div class="tabs">
                    <button class="tab active" onclick="showTab('reader')">
                        <i class="fas fa-book-open"></i> Reader
                    </button>
                    <button class="tab" onclick="showTab('details')">
                        <i class="fas fa-info-circle"></i> Details
                    </button>
                </div>

                <!-- PDF Reader Tab -->
                <div id="reader" class="tab-content active">
                    <div class="loading" id="loadingDiv">
                        <i class="fas fa-spinner fa-spin fa-2x"></i>
                        <p>Loading PDF viewer...</p>
                    </div>
                    <iframe id="pdfViewer" class="pdf-viewer" style="display:none;" 
                            src="<%= request.getContextPath() %>/<%= book.getPdfPath() %>#toolbar=1" 
                            frameborder="0">
                        <p>Your browser doesn't support PDF viewing. 
                           <a href="books?action=download&id=<%= book.getId() %>">Download the PDF</a> instead.</p>
                    </iframe>
                </div>

                <!-- Details Tab -->
                <div id="details" class="tab-content">
                    <h3 style="margin-bottom: 20px; color: #2c3e50;">Book Information</h3>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px;">
                        <div style="background: #f8f9fa; padding: 20px; border-radius: 10px; text-align: center;">
                            <div style="font-size: 1.5rem; font-weight: 700; color: #3498db; margin-bottom: 5px;">
                                <%= book.getFormattedFileSize() %>
                            </div>
                            <div style="color: #666;">File Size</div>
                        </div>
                        <div style="background: #f8f9fa; padding: 20px; border-radius: 10px; text-align: center;">
                            <div style="font-size: 1.5rem; font-weight: 700; color: #27ae60; margin-bottom: 5px;">
                                PDF
                            </div>
                            <div style="color: #666;">Format</div>
                        </div>
                        <div style="background: #f8f9fa; padding: 20px; border-radius: 10px; text-align: center;">
                            <div style="font-size: 1.5rem; font-weight: 700; color: #e74c3c; margin-bottom: 5px;">
                                Available
                            </div>
                            <div style="color: #666;">Status</div>
                        </div>
                    </div>
                    
                    <div style="margin-top: 30px;">
                        <h4 style="color: #2c3e50; margin-bottom: 15px;">About This Book</h4>
                        <p style="color: #666; line-height: 1.7;">
                            <%= book.getDescription() != null ? book.getDescription() : 
                                "This book is available for reading online or download. Click the 'Read Online' button to view it in your browser or 'Download PDF' to save it to your device." %>
                        </p>
                    </div>
                </div>
            </div>
            
        <% } else { %>
            <div class="content-section">
                <div style="text-align: center; padding: 60px;">
                    <h2>Book Not Found</h2>
                    <p style="margin: 20px 0;">The book you're looking for doesn't exist or has been removed.</p>
                    <a href="books" class="btn btn-primary">Back to Library</a>
                </div>
            </div>
        <% } %>
    </div>

    <script>
        function showTab(tabName) {
            // Hide all tab contents
            document.querySelectorAll('.tab-content').forEach(content => {
                content.classList.remove('active');
            });
            
            // Remove active class from all tabs
            document.querySelectorAll('.tab').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Show selected tab content
            document.getElementById(tabName).classList.add('active');
            
            // Add active class to clicked tab
            event.target.classList.add('active');
        }

        function openReader() {
            showTab('reader');
            loadPDF();
        }

        function loadPDF() {
            const viewer = document.getElementById('pdfViewer');
            const loading = document.getElementById('loadingDiv');
            
            // Show PDF viewer after a short delay
            setTimeout(() => {
                loading.style.display = 'none';
                viewer.style.display = 'block';
            }, 1000);
        }

        // Load PDF when