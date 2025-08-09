package com.webapp.servlet;

import com.webapp.dao.ArticleDAO;
import com.webapp.model.Article;
import com.webapp.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for handling article browsing and viewing
 */
@WebServlet("/articles")
public class ArticleServlet extends HttpServlet {
    
    private ArticleDAO articleDAO;
    
    @Override
    public void init() throws ServletException {
        articleDAO = new ArticleDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?redirect=articles");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        
        try {
            if ("view".equals(action) && idParam != null) {
                // View single article
                int articleId = Integer.parseInt(idParam);
                Article article = articleDAO.getArticleById(articleId);
                
                if (article != null && article.isPublished()) {
                    request.setAttribute("article", article);
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/article-view.jsp").forward(request, response);
                } else {
                    response.sendRedirect("articles?error=Article not found");
                }
            } else {
                // List all published articles
                List<Article> articles = articleDAO.getAllPublishedArticles();
                request.setAttribute("articles", articles);
                request.setAttribute("user", user);
                request.getRequestDispatcher("/articles.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("articles?error=Invalid article ID");
        } catch (Exception e) {
            System.err.println("Error in ArticleServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("articles?error=An error occurred");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}