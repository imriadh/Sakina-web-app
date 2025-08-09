package com.webapp.dao;

import com.webapp.model.Article;
import com.webapp.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Article operations
 */
public class ArticleDAO {
    
    /**
     * Insert a new article into the database
     */
    public boolean insertArticle(Article article) {
        String sql = "INSERT INTO articles (title, content, excerpt, author, is_published) VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, article.getTitle());
            pstmt.setString(2, article.getContent());
            pstmt.setString(3, article.getExcerpt());
            pstmt.setString(4, article.getAuthor());
            pstmt.setBoolean(5, article.isPublished());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error inserting article: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
    }
    
    /**
     * Get all published articles
     */
    public List<Article> getAllPublishedArticles() {
        List<Article> articles = new ArrayList<>();
        String sql = "SELECT * FROM articles WHERE is_published = 1 ORDER BY date_posted DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Article article = createArticleFromResultSet(rs);
                articles.add(article);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting published articles: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResultSet(rs);
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
        
        return articles;
    }
    
    /**
     * Get all articles (for admin)
     */
    public List<Article> getAllArticles() {
        List<Article> articles = new ArrayList<>();
        String sql = "SELECT * FROM articles ORDER BY date_posted DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Article article = createArticleFromResultSet(rs);
                articles.add(article);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all articles: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResultSet(rs);
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
        
        return articles;
    }
    
    /**
     * Get article by ID
     */
    public Article getArticleById(int id) {
        String sql = "SELECT * FROM articles WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return createArticleFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting article by ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResultSet(rs);
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
        
        return null;
    }
    
    /**
     * Update an existing article
     */
    public boolean updateArticle(Article article) {
        String sql = "UPDATE articles SET title = ?, content = ?, excerpt = ?, author = ?, is_published = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, article.getTitle());
            pstmt.setString(2, article.getContent());
            pstmt.setString(3, article.getExcerpt());
            pstmt.setString(4, article.getAuthor());
            pstmt.setBoolean(5, article.isPublished());
            pstmt.setInt(6, article.getId());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating article: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
    }
    
    /**
     * Delete an article
     */
    public boolean deleteArticle(int id) {
        String sql = "DELETE FROM articles WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting article: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
    }
    
    /**
     * Helper method to create Article object from ResultSet
     */
    private Article createArticleFromResultSet(ResultSet rs) throws SQLException {
        Article article = new Article();
        article.setId(rs.getInt("id"));
        article.setTitle(rs.getString("title"));
        article.setContent(rs.getString("content"));
        article.setExcerpt(rs.getString("excerpt"));
        article.setAuthor(rs.getString("author"));
        
        // Convert timestamp to LocalDateTime
        String datePosted = rs.getString("date_posted");
        if (datePosted != null) {
            article.setDatePosted(LocalDateTime.parse(datePosted.replace(" ", "T")));
        }
        
        article.setPublished(rs.getBoolean("is_published"));
        return article;
    }
}