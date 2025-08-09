package com.webapp.servlet;

import com.webapp.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/support")
public class SupportServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?redirect=support");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/support.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Get form data
        String subject = request.getParameter("subject");
        String category = request.getParameter("category");
        String message = request.getParameter("message");
        
        // Here you would typically save to database or send email
        // For now, just redirect with success message
        System.out.println("Support request received:");
        System.out.println("Subject: " + subject);
        System.out.println("Category: " + category);
        System.out.println("Message: " + message);
        
        response.sendRedirect("support?success=Message sent successfully");
    }
}