package com.webapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class DatabaseUtil {
    private static final String DB_URL = "jdbc:sqlite:sakina.db";
    
    static {
        try {
            Class.forName("org.sqlite.JDBC");
            initializeDatabase();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL);
    }
    
    /**
     * Close PreparedStatement safely
     */
    public static void closePreparedStatement(PreparedStatement pstmt) {
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                System.err.println("Error closing PreparedStatement: " + e.getMessage());
            }
        }
    }
    
    /**
     * Close Connection safely
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing Connection: " + e.getMessage());
            }
        }
    }
    
    /**
     * Close ResultSet safely
     */
    public static void closeResultSet(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                System.err.println("Error closing ResultSet: " + e.getMessage());
            }
        }
    }
    
    private static void initializeDatabase() {
        // Create users table
        String createUserTable = 
            "CREATE TABLE IF NOT EXISTS users (" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "first_name TEXT NOT NULL," +
            "last_name TEXT NOT NULL," +
            "email TEXT UNIQUE NOT NULL," +
            "password TEXT NOT NULL," +
            "phone TEXT," +
            "created_at DATETIME DEFAULT CURRENT_TIMESTAMP" +
            ")";
        
        // Create articles table
        String createArticleTable = 
            "CREATE TABLE IF NOT EXISTS articles (" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "title TEXT NOT NULL," +
            "content TEXT NOT NULL," +
            "excerpt TEXT," +
            "author TEXT NOT NULL," +
            "date_posted DATETIME DEFAULT CURRENT_TIMESTAMP," +
            "is_published INTEGER DEFAULT 1" +
            ")";
        
        // Create books table
        String createBookTable = 
            "CREATE TABLE IF NOT EXISTS books (" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT," +
            "title TEXT NOT NULL," +
            "description TEXT," +
            "pdf_filename TEXT NOT NULL," +
            "pdf_path TEXT NOT NULL," +
            "author TEXT," +
            "date_uploaded DATETIME DEFAULT CURRENT_TIMESTAMP," +
            "file_size INTEGER," +
            "is_available INTEGER DEFAULT 1" +
            ")";
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            
            // Create all tables
            stmt.execute(createUserTable);
            stmt.execute(createArticleTable);
            stmt.execute(createBookTable);
            
            // Insert sample data
            insertSampleData(conn);
            
            System.out.println("Sakina database initialized successfully!");
            
        } catch (SQLException e) {
            System.err.println("Error initializing database: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Insert sample data for demonstration
     */
    private static void insertSampleData(Connection conn) {
        try {
            // Insert sample articles
            insertSampleArticles(conn);
            
            // Insert sample books
            insertSampleBooks(conn);
            
        } catch (SQLException e) {
            System.err.println("Error inserting sample data: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Insert sample articles
     */
    private static void insertSampleArticles(Connection conn) throws SQLException {
        String checkArticles = "SELECT COUNT(*) FROM articles";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(checkArticles)) {
            if (rs.next() && rs.getInt(1) == 0) {
                String insertArticle = "INSERT INTO articles (title, content, excerpt, author) VALUES (?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(insertArticle)) {
                    
                    // Article 1: Mindfulness
                    pstmt.setString(1, "5 Simple Mindfulness Techniques for Daily Life");
                    pstmt.setString(2, 
                        "<h2>Introduction to Mindfulness</h2>" +
                        "<p>Mindfulness is the practice of being present and fully engaged with whatever we're doing at the moment. It's about being aware of our thoughts, feelings, and surroundings without getting overwhelmed by them.</p>" +
                        
                        "<h3>Why Practice Mindfulness?</h3>" +
                        "<p>Research shows that regular mindfulness practice can:</p>" +
                        "<ul>" +
                        "<li>Reduce stress and anxiety</li>" +
                        "<li>Improve focus and concentration</li>" +
                        "<li>Enhance emotional regulation</li>" +
                        "<li>Boost overall well-being</li>" +
                        "<li>Improve sleep quality</li>" +
                        "</ul>" +
                        
                        "<h3>5 Simple Mindfulness Techniques</h3>" +
                        
                        "<h4>1. Deep Breathing Exercise</h4>" +
                        "<p>This is the foundation of mindfulness practice:</p>" +
                        "<ul>" +
                        "<li>Sit comfortably with your back straight</li>" +
                        "<li>Close your eyes or soften your gaze</li>" +
                        "<li>Take 5 deep breaths, focusing on the sensation of air entering and leaving your body</li>" +
                        "<li>Notice how your chest and belly rise and fall</li>" +
                        "<li>If your mind wanders, gently bring attention back to your breath</li>" +
                        "</ul>" +
                        
                        "<h4>2. Body Scan Meditation</h4>" +
                        "<p>This technique helps you connect with your physical sensations:</p>" +
                        "<ul>" +
                        "<li>Lie down or sit comfortably</li>" +
                        "<li>Starting from your toes, mentally scan your body</li>" +
                        "<li>Notice any sensations without trying to change them</li>" +
                        "<li>Move slowly up through your legs, torso, arms, and head</li>" +
                        "<li>Spend 1-2 minutes on each body part</li>" +
                        "</ul>" +
                        
                        "<h4>3. Mindful Walking</h4>" +
                        "<p>Turn a simple walk into a meditation:</p>" +
                        "<ul>" +
                        "<li>Walk at a slower pace than usual</li>" +
                        "<li>Pay attention to each step</li>" +
                        "<li>Feel your feet touching the ground</li>" +
                        "<li>Notice the movement of your legs and arms</li>" +
                        "<li>Be aware of your surroundings without judgment</li>" +
                        "</ul>" +
                        
                        "<h3>Getting Started</h3>" +
                        "<p>Start with just 5 minutes a day. Choose one technique that resonates with you and practice it consistently.</p>"
                    );
                    pstmt.setString(3, "Discover five simple mindfulness techniques that you can easily incorporate into your daily routine for better mental well-being and reduced stress.");
                    pstmt.setString(4, "Dr. Sarah Johnson, Mindfulness Coach");
                    pstmt.executeUpdate();
                    
                    // Article 2: Anxiety
                    pstmt.setString(1, "Understanding Anxiety: Causes and Coping Strategies");
                    pstmt.setString(2, 
                        "<h2>What is Anxiety?</h2>" +
                        "<p>Anxiety is a natural response to stress that everyone experiences from time to time. However, when anxiety becomes overwhelming or persistent, it can significantly impact your daily life.</p>" +
                        
                        "<h3>Common Causes of Anxiety</h3>" +
                        "<ul>" +
                        "<li>Work or school pressure</li>" +
                        "<li>Relationship issues</li>" +
                        "<li>Financial worries</li>" +
                        "<li>Health concerns</li>" +
                        "<li>Major life changes</li>" +
                        "</ul>" +
                        
                        "<h3>Effective Coping Strategies</h3>" +
                        "<h4>1. Progressive Muscle Relaxation</h4>" +
                        "<p>This technique helps release physical tension by systematically tensing and relaxing muscle groups.</p>" +
                        
                        "<h4>2. Grounding Techniques (5-4-3-2-1)</h4>" +
                        "<p>Use your senses to stay present:</p>" +
                        "<ul>" +
                        "<li>5 things you can see</li>" +
                        "<li>4 things you can touch</li>" +
                        "<li>3 things you can hear</li>" +
                        "<li>2 things you can smell</li>" +
                        "<li>1 thing you can taste</li>" +
                        "</ul>" +
                        
                        "<h3>When to Seek Help</h3>" +
                        "<p>Consider professional help if anxiety interferes with daily activities or causes significant distress.</p>"
                    );
                    pstmt.setString(3, "Learn about the common causes of anxiety and discover practical, evidence-based coping strategies to manage anxious thoughts and feelings effectively.");
                    pstmt.setString(4, "Dr. Michael Chen, Clinical Psychologist");
                    pstmt.executeUpdate();
                    
                    // Article 3: Positive Thinking
                    pstmt.setString(1, "The Power of Positive Thinking in Mental Health");
                    pstmt.setString(2, 
                        "<h2>Understanding Positive Thinking</h2>" +
                        "<p>Positive thinking doesn't mean ignoring life's problems. It's about approaching challenges with a more optimistic and productive mindset.</p>" +
                        
                        "<h3>Benefits of Positive Thinking</h3>" +
                        "<ul>" +
                        "<li>Reduced stress levels</li>" +
                        "<li>Better physical health</li>" +
                        "<li>Improved relationships</li>" +
                        "<li>Enhanced problem-solving abilities</li>" +
                        "<li>Increased resilience</li>" +
                        "</ul>" +
                        
                        "<h3>How to Cultivate Positive Thinking</h3>" +
                        "<h4>1. Challenge Negative Thoughts</h4>" +
                        "<p>When you notice negative thinking patterns, stop and question their validity.</p>" +
                        
                        "<h4>2. Practice Gratitude</h4>" +
                        "<p>Write down three things you're grateful for each day.</p>" +
                        
                        "<h4>3. Surround Yourself with Positivity</h4>" +
                        "<p>Spend time with optimistic people and consume uplifting content.</p>" +
                        
                        "<h3>Making It a Habit</h3>" +
                        "<p>Positive thinking is a skill that improves with practice. Be patient with yourself as you develop this life-changing skill.</p>"
                    );
                    pstmt.setString(3, "Explore how positive thinking can transform your mental health and learn practical, science-based strategies to develop a more optimistic and resilient mindset.");
                    pstmt.setString(4, "Dr. Emily Rodriguez, Positive Psychology Researcher");
                    pstmt.executeUpdate();
                    
                    System.out.println("Sample articles inserted successfully!");
                }
            }
        }
    }
    
    /**
     * Insert sample books
     */
    private static void insertSampleBooks(Connection conn) throws SQLException {
        String checkBooks = "SELECT COUNT(*) FROM books";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(checkBooks)) {
            if (rs.next() && rs.getInt(1) == 0) {
                String insertBook = "INSERT INTO books (title, description, pdf_filename, pdf_path, author, file_size, is_available) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(insertBook)) {
                    
                    // Book 1: Weakness of Faith
                    pstmt.setString(1, "Weakness of Faith");
                    pstmt.setString(2, "A comprehensive Islamic guide addressing the spiritual condition of weakness in faith (Iman). This book explores the causes, symptoms, and practical solutions for strengthening one's relationship with Allah (SWT) and overcoming spiritual difficulties. Essential reading for anyone seeking to revitalize their spiritual connection and overcome faith-related challenges.");
                    pstmt.setString(3, "weakness-of-faith.pdf");
                    pstmt.setString(4, "uploads/pdfs/weakness-of-faith.pdf");
                    pstmt.setString(5, "Islamic Scholar");
                    pstmt.setLong(6, 2400000); // ~2.4 MB
                    pstmt.setBoolean(7, true);
                    pstmt.executeUpdate();
                    
                    // Book 2: Mindfulness Guide
                    pstmt.setString(1, "The Complete Guide to Mindfulness");
                    pstmt.setString(2, "A comprehensive guide to mindfulness practices, meditation techniques, and stress reduction strategies. Perfect for beginners and experienced practitioners alike. Learn how to incorporate mindfulness into your daily routine for better mental health and emotional well-being.");
                    pstmt.setString(3, "mindfulness-guide.pdf");
                    pstmt.setString(4, "uploads/pdfs/mindfulness-guide.pdf");
                    pstmt.setString(5, "Dr. Sarah Wellness");
                    pstmt.setLong(6, 2500000); // 2.5 MB
                    pstmt.setBoolean(7, true);
                    pstmt.executeUpdate();
                    
                    // Book 3: Anxiety Workbook
                    pstmt.setString(1, "Overcoming Anxiety: A Practical Workbook");
                    pstmt.setString(2, "A step-by-step workbook for understanding and managing anxiety. Includes practical exercises, breathing techniques, and cognitive behavioral therapy strategies to help you regain control over anxious thoughts and feelings.");
                    pstmt.setString(3, "anxiety-workbook.pdf");
                    pstmt.setString(4, "uploads/pdfs/anxiety-workbook.pdf");
                    pstmt.setString(5, "Dr. Michael Chen");
                    pstmt.setLong(6, 3200000); // 3.2 MB
                    pstmt.setBoolean(7, true);
                    pstmt.executeUpdate();
                    
                    System.out.println("Sample books inserted successfully!");
                }
            }
        }
    }
}
