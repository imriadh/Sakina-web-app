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
    <title>Support & Help - Sakina</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            min-height: 100vh;
            color: #333;
        }
        
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
        
        .support-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }
        
        .support-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
            transition: all 0.3s ease;
        }
        
        .support-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }
        
        .support-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 32px;
        }
        
        .support-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #333;
        }
        
        .support-desc {
            font-size: 16px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 25px;
        }
        
        .support-btn {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
        }
        
        .support-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.4);
        }
        
        .contact-form {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        
        .form-title {
            font-size: 28px;
            font-weight: 700;
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        
        .form-input, .form-textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        .form-input:focus, .form-textarea:focus {
            outline: none;
            border-color: #4facfe;
        }
        
        .form-textarea {
            resize: vertical;
            min-height: 120px;
        }
        
        .form-submit {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: all 0.3s ease;
        }
        
        .form-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.4);
        }
        
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .support-grid {
                grid-template-columns: 1fr;
            }
            
            .page-title {
                font-size: 32px;
            }
            
            .contact-form {
                padding: 25px;
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
                <a href="books" class="nav-link">Books</a>
               
                <a href="support" class="nav-link active">Support</a>
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
                <i class="fas fa-life-ring" style="margin-right: 15px;"></i>
                Support & Help
            </h1>
            <p class="page-subtitle">
                Get the help you need. We're here to support your mental wellness journey.
            </p>
        </div>

        <!-- Support Options -->
        <div class="support-grid">
            <div class="support-card">
                <div class="support-icon">
                    <i class="fas fa-phone"></i>
                </div>
                <h3 class="support-title">Crisis Support</h3>
                <p class="support-desc">
                    If you're experiencing a mental health crisis, please reach out immediately. 
                    Professional help is available 24/7.
                </p>
                <a href="tel:988" class="support-btn">Call 988 (Crisis Lifeline)</a>
            </div>
            
            <div class="support-card">
                <div class="support-icon">
                    <i class="fas fa-user-md"></i>
                </div>
                <h3 class="support-title">Find a Therapist</h3>
                <p class="support-desc">
                    Connect with licensed mental health professionals in your area. 
                    Get personalized care and treatment.
                </p>
                <a href="https://www.psychologytoday.com/" target="_blank" class="support-btn">Find Therapist</a>
            </div>
            
            <div class="support-card">
                <div class="support-icon">
                    <i class="fas fa-comments"></i>
                </div>
                <h3 class="support-title">Online Counseling</h3>
                <p class="support-desc">
                    Access professional counseling from the comfort of your home. 
                    Convenient and confidential support.
                </p>
                <a href="https://www.betterhelp.com/" target="_blank" class="support-btn">Start Online Therapy</a>
            </div>
            
            <div class="support-card">
                <div class="support-icon">
                    <i class="fas fa-users"></i>
                </div>
                <h3 class="support-title">Support Groups</h3>
                <p class="support-desc">
                    Join communities of people who understand what you're going through. 
                    Share experiences and find support.
                </p>
                <a href="https://www.nami.org/Support-Education/Support-Groups" target="_blank" class="support-btn">Find Groups</a>
            </div>
        </div>

        <!-- Contact Form -->
        <div class="contact-form">
            <h2 class="form-title">Contact Our Support Team</h2>
            <form action="support" method="post">
                <div class="form-group">
                    <label for="subject" class="form-label">Subject</label>
                    <input type="text" id="subject" name="subject" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label for="category" class="form-label">Category</label>
                    <select id="category" name="category" class="form-input" required>
                        <option value="">Select a category</option>
                        <option value="technical">Technical Support</option>
                        <option value="account">Account Issues</option>
                        <option value="feedback">Feedback</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="message" class="form-label">Message</label>
                    <textarea id="message" name="message" class="form-textarea" 
                              placeholder="Please describe your issue or question..." required></textarea>
                </div>
                
                <button type="submit" class="form-submit">Send Message</button>
            </form>
        </div>
    </div>
</body>
</html>