# Web App Project - Java JSP with SQLite

> A modern Java JSP web application with user registration, authentication, and SQLite database integration.

![Java](https://img.shields.io/badge/Java-21-orange.svg)
![JSP](https://img.shields.io/badge/JSP-4.0-blue.svg)
![SQLite](https://img.shields.io/badge/SQLite-3.42-green.svg)
![Maven](https://img.shields.io/badge/Maven-3.x-red.svg)
![Tomcat](https://img.shields.io/badge/Tomcat-7.0-yellow.svg)

## 📋 Table of Contents
- [Features](#-features)
- [Screenshots](#-screenshots)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Usage](#-usage)
- [Project Structure](#-project-structure)
- [API Endpoints](#-api-endpoints)
- [Technologies Used](#-technologies-used)
- [Development](#-development)
- [Deployment](#-deployment)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

- 🔐 **User Authentication**: Secure login/logout system with session management
- 📝 **User Registration**: Complete signup process with form validation
- 🔒 **Password Security**: SHA-256 password hashing
- 📧 **Email Validation**: Prevents duplicate email registrations
- 🗄️ **SQLite Database**: Lightweight database with automatic table creation
- 📱 **Responsive Design**: Modern, mobile-friendly interface
- 👥 **User Management**: View all registered users
- 🎯 **Dashboard**: Personalized user dashboard
- ⚡ **Live Development**: Hot reload capability for rapid development

## 📸 Screenshots

### Homepage
![Homepage](docs/screenshots/homepage.png)

### Sign Up Page
![Signup](docs/screenshots/signup.png)

### Login Page
![Login](docs/screenshots/login.png)

### Dashboard
![Dashboard](docs/screenshots/dashboard.png)

## 📦 Prerequisites

Before running this application, make sure you have the following installed:

- **Java 21** or higher
- **Maven 3.6+**
- **Git** (for version control)

### Check your installations:
```bash
java -version
mvn -version
git --version
```

## 🚀 Installation

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/web-app-project.git
cd web-app-project
```

### 2. Install dependencies
```bash
mvn clean install
```

### 3. Run the application
```bash
mvn tomcat7:run
```

### 4. Access the application
Open your browser and navigate to: **http://localhost:8081**

## 🎯 Usage

### Starting the Application
```bash
# Start development server
mvn tomcat7:run

# Quick compile after changes
mvn compile

# Build WAR for deployment
mvn package
```

### User Registration
1. Navigate to `/signup`
2. Fill in the registration form
3. Click "Create Account"
4. You'll be redirected to the success page

### User Login
1. Navigate to `/login`
2. Enter your email and password
3. Click "Sign In"
4. Access your personalized dashboard

### View Users
- Navigate to `/users` to see all registered users
- Displays user information in a modern card layout

## 📁 Project Structure

```
web-app-project/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── webapp/
│   │   │           ├── dao/
│   │   │           │   └── UserDAO.java          # Database operations
│   │   │           ├── model/
│   │   │           │   └── User.java             # User entity
│   │   │           ├── servlet/
│   │   │           │   ├── DashboardServlet.java # Dashboard controller
│   │   │           │   ├── LoginServlet.java     # Login controller
│   │   │           │   ├── LogoutServlet.java    # Logout controller
│   │   │           │   ├── SignupServlet.java    # Registration controller
│   │   │           │   └── UserListServlet.java  # User list controller
│   │   │           └── util/
│   │   │               └── DatabaseUtil.java     # Database utilities
│   │   └── webapp/
│   │       ├── dashboard.jsp                     # User dashboard page
│   │       ├── debug.jsp                         # Debug information
│   │       ├── index.jsp                         # Homepage
│   │       ├── login.jsp                         # Login page
│   │       ├── signup.jsp                        # Registration page
│   │       ├── success.jsp                       # Success page
│   │       ├── users.jsp                         # User list page
│   │       └── WEB-INF/
│   │           └── web.xml                       # Web configuration
├── target/                                       # Build directory
├── webapp.db                                     # SQLite database
├── pom.xml                                       # Maven configuration
└── README.md                                     # This file
```

## 🔗 API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/` | GET | Homepage with navigation |
| `/signup` | GET/POST | User registration |
| `/login` | GET/POST | User authentication |
| `/logout` | GET | User logout |
| `/dashboard` | GET | User dashboard (protected) |
| `/users` | GET | View all registered users |
| `/debug` | GET | Debug information |

## 🛠️ Technologies Used

### Backend
- **Java 21**: Core programming language
- **JSP (JavaServer Pages)**: Server-side templating
- **Servlet API 4.0**: Web application framework
- **SQLite JDBC 3.42**: Database connectivity
- **Maven**: Dependency management and build tool

### Frontend
- **HTML5 & CSS3**: Modern web standards
- **JavaScript**: Client-side scripting
- **Responsive Design**: Mobile-first approach

### Database
- **SQLite**: Lightweight, serverless database

### Development Tools
- **Apache Tomcat 7**: Development server
- **Maven Tomcat Plugin**: Local development
- **VS Code**: Recommended IDE

## 💻 Development

### Quick Development Workflow

1. **Make changes** to Java files or JSP pages
2. **Compile quickly**: `mvn compile`
3. **Refresh browser** at http://localhost:8081
4. **For JSP changes**: Just refresh (no compilation needed)
5. **For Java changes**: Compile first, then refresh

### VS Code Tasks Available
- **"Start Local Server"**: Starts Tomcat on port 8081
- **"Quick Compile"**: Fast compilation
- **"Build WAR"**: Creates deployment package

Access via: `Ctrl+Shift+P` → Type "Tasks: Run Task"

### Database Schema

```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    phone TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### Adding New Features

1. Create servlet in `src/main/java/com/webapp/servlet/`
2. Add JSP page in `src/main/webapp/`
3. Update navigation in existing pages
4. Compile and test: `mvn compile`

## 🚀 Deployment

### Local Deployment
```bash
mvn clean package
# WAR file will be created in target/ directory
```

### Azure Deployment
```bash
mvn azure-webapp:deploy
```

### Docker Deployment (Optional)
```dockerfile
FROM tomcat:9.0-jdk21
COPY target/web-app-project-*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines
- Follow Java naming conventions
- Add comments for complex logic
- Test thoroughly before submitting PR
- Update README if adding new features

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Riad** - *Initial work*

## 🙏 Acknowledgments

- Java community for excellent documentation
- Apache Tomcat team for the development server
- SQLite team for the lightweight database
- Maven team for dependency management

## 📞 Support

If you have any questions or issues, please:
1. Check the existing [Issues](https://github.com/yourusername/web-app-project/issues)
2. Create a new issue if needed
3. Provide detailed information about the problem

---

**Happy Coding!** 🎉

Made with ❤️ by [Riad](https://github.com/yourusername)
