package com.webapp.model;

import java.time.LocalDateTime;

/**
 * Article model class representing mental health articles
 */
public class Article {
    private int id;
    private String title;
    private String content;
    private String excerpt;
    private String author;
    private LocalDateTime datePosted;
    private boolean isPublished;
    
    // Default constructor
    public Article() {}
    
    // Constructor with all fields
    public Article(int id, String title, String content, String excerpt, 
                   String author, LocalDateTime datePosted, boolean isPublished) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.excerpt = excerpt;
        this.author = author;
        this.datePosted = datePosted;
        this.isPublished = isPublished;
    }
    
    // Constructor without ID (for new articles)
    public Article(String title, String content, String excerpt, String author) {
        this.title = title;
        this.content = content;
        this.excerpt = excerpt;
        this.author = author;
        this.isPublished = true;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public String getExcerpt() { return excerpt; }
    public void setExcerpt(String excerpt) { this.excerpt = excerpt; }
    
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    
    public LocalDateTime getDatePosted() { return datePosted; }
    public void setDatePosted(LocalDateTime datePosted) { this.datePosted = datePosted; }
    
    public boolean isPublished() { return isPublished; }
    public void setPublished(boolean published) { isPublished = published; }
    
    @Override
    public String toString() {
        return "Article{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", datePosted=" + datePosted +
                ", isPublished=" + isPublished +
                '}';
    }
}