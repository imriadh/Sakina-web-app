<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sakina - Mental Well-being Platform</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .welcome-container {
            background: white;
            padding: 60px 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 700px;
            width: 100%;
        }
        
        .logo {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            color: white;
            position: relative;
            box-shadow: 0 10px 30px rgba(79, 172, 254, 0.3);
        }
        
        .logo i {
            font-size: 50px;
        }
        
        .logo::after {
            content: '';
            position: absolute;
            width: 140px;
            height: 140px;
            border: 2px solid rgba(79, 172, 254, 0.2);
            border-radius: 50%;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            100% {
                transform: scale(1.1);
                opacity: 0;
            }
        }
        
        h1 {
            color: #333;
            font-size: 42px;
            margin-bottom: 15px;
            font-weight: 700;
        }
        
        .subtitle {
            color: #666;
            font-size: 20px;
            margin-bottom: 40px;
            line-height: 1.6;
        }
        
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .feature-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 30px 20px;
            border-radius: 15px;
            transition: all 0.3s ease;
            border: 1px solid transparent;
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            border-color: #4facfe;
            box-shadow: 0 10px 30px rgba(79, 172, 254, 0.2);
        }
        
        .feature-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: white;
            font-size: 24px;
        }
        
        .feature-title {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        
        .feature-desc {
            color: #666;
            font-size: 15px;
            line-height: 1.5;
        }
        
        .btn-group {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 15px 35px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-block;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(79, 172, 254, 0.4);
        }
        
        .btn-outline {
            background: transparent;
            color: #4facfe;
            border: 2px solid #4facfe;
        }
        
        .btn-outline:hover {
            background: #4facfe;
            color: white;
            transform: translateY(-3px);
        }
        
        .tagline {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 15px 25px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 30px;
            display: inline-block;
        }
        
        @media (max-width: 768px) {
            .welcome-container {
                padding: 40px 20px;
            }
            
            h1 {
                font-size: 32px;
            }
            
            .btn-group {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 300px;
            }
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <div class="logo">
            <i class="fas fa-heart"></i>
        </div>
        
        <h1>Welcome to Sakina</h1>
        <div class="tagline">Your Mental Well-being Companion</div>
        <p class="subtitle">
            Discover peace, mindfulness, and mental wellness through our comprehensive platform. 
            Access articles, books, breathing exercises, and more to support your mental health journey.
        </p>
        
        <div class="features">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-newspaper"></i>
                </div>
                <div class="feature-title">Health Articles</div>
                <div class="feature-desc">Expert-written articles on mental health, mindfulness, and wellness strategies</div>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-book-open"></i>
                </div>
                <div class="feature-title">PDF Library</div>
                <div class="feature-desc">Curated collection of mental wellness books and resources in PDF format</div>
            </div>
            
           
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-brain"></i>
                </div>
                <div class="feature-title">Mindfulness Tools</div>
                <div class="feature-desc">Personalized dashboard with tools and resources for your mental health journey</div>
            </div>
        </div>
        
        <div class="btn-group">
            <a href="signup" class="btn btn-primary">Start Your Journey - Sign Up</a>
            <a href="login" class="btn btn-outline">Sign In</a>
        </div>
    </div>
</body>
</html>
