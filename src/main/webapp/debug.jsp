<%@ page import="java.util.List" %>
<%@ page import="com.webapp.model.User" %>
<%@ page import="com.webapp.dao.UserDAO" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<!DOCTYPE html>
<html>
<head>
    <title>Debug Login</title>
</head>
<body>
    <h2>Debug Information</h2>
    
    <%
        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.getAllUsers();
    %>
    
    <h3>Total Users in Database: <%= users.size() %></h3>
    
    <% if (!users.isEmpty()) { %>
        <h3>First User Details:</h3>
        <ul>
            <% for (User user : users) { %>
                <li>
                    <strong>Email:</strong> <%= user.getEmail() %><br>
                    <strong>Name:</strong> <%= user.getFirstName() %> <%= user.getLastName() %><br>
                    <strong>ID:</strong> <%= user.getId() %><br>
                    <hr>
                </li>
            <% } %>
        </ul>
    <% } else { %>
        <p><strong>No users found!</strong> Please sign up first.</p>
    <% } %>
    
    <h3>Test Password Hashing:</h3>
    <%
        try {
            String testPassword = "test123";
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(testPassword.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            String hashedPassword = sb.toString();
    %>
        <p><strong>Test password "test123" hashes to:</strong><br>
        <%= hashedPassword %></p>
    <%
        } catch (NoSuchAlgorithmException e) {
            out.println("Error hashing password: " + e.getMessage());
        }
    %>
    
    <br><br>
    <a href="index.jsp">← Back to Home</a> |
    <a href="signup">Sign Up</a> |
    <a href="login">Login</a>
</body>
</html>
