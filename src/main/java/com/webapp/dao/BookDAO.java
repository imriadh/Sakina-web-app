package com.webapp.dao;

import com.webapp.model.Book;
import com.webapp.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Book operations
 */
public class BookDAO {
    
    /**
     * Insert a new book into the database
     */
    public boolean insertBook(Book book) {
        String sql = "INSERT INTO books (title, description, pdf_filename, pdf_path, author, file_size, is_available) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getDescription());
            pstmt.setString(3, book.getPdfFilename());
            pstmt.setString(4, book.getPdfPath());
            pstmt.setString(5, book.getAuthor());
            pstmt.setLong(6, book.getFileSize());
            pstmt.setBoolean(7, book.isAvailable());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error inserting book: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
    }
    
    /**
     * Get all available books
     */
    public List<Book> getAllAvailableBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE is_available = 1 ORDER BY date_uploaded DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = createBookFromResultSet(rs);
                books.add(book);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting available books: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResultSet(rs);
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
        
        return books;
    }
    
    /**
     * Get all books (for admin)
     */
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books ORDER BY date_uploaded DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = createBookFromResultSet(rs);
                books.add(book);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all books: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResultSet(rs);
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
        
        return books;
    }
    
    /**
     * Get book by ID
     */
    public Book getBookById(int id) {
        String sql = "SELECT * FROM books WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return createBookFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting book by ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResultSet(rs);
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
        
        return null;
    }
    
    /**
     * Update an existing book
     */
    public boolean updateBook(Book book) {
        String sql = "UPDATE books SET title = ?, description = ?, author = ?, is_available = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getDescription());
            pstmt.setString(3, book.getAuthor());
            pstmt.setBoolean(4, book.isAvailable());
            pstmt.setInt(5, book.getId());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating book: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
    }
    
    /**
     * Delete a book
     */
    public boolean deleteBook(int id) {
        String sql = "DELETE FROM books WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting book: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DatabaseUtil.closePreparedStatement(pstmt);
            DatabaseUtil.closeConnection(conn);
        }
    }
    
    /**
     * Helper method to create Book object from ResultSet
     */
    private Book createBookFromResultSet(ResultSet rs) throws SQLException {
        Book book = new Book();
        book.setId(rs.getInt("id"));
        book.setTitle(rs.getString("title"));
        book.setDescription(rs.getString("description"));
        book.setPdfFilename(rs.getString("pdf_filename"));
        book.setPdfPath(rs.getString("pdf_path"));
        book.setAuthor(rs.getString("author"));
        book.setFileSize(rs.getLong("file_size"));
        book.setAvailable(rs.getBoolean("is_available"));
        
        // Convert timestamp to LocalDateTime
        String dateUploaded = rs.getString("date_uploaded");
        if (dateUploaded != null) {
            book.setDateUploaded(LocalDateTime.parse(dateUploaded.replace(" ", "T")));
        }
        
        return book;
    }
}