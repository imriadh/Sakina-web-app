package com.webapp.model;

import java.time.LocalDateTime;

/**
 * Book model class representing PDF books in the library
 */
public class Book {
    private int id;
    private String title;
    private String description;
    private String pdfFilename;
    private String pdfPath;
    private String author;
    private LocalDateTime dateUploaded;
    private long fileSize;
    private boolean isAvailable;
    
    // Default constructor
    public Book() {}
    
    // Constructor with all fields
    public Book(int id, String title, String description, String pdfFilename, 
                String pdfPath, String author, LocalDateTime dateUploaded, 
                long fileSize, boolean isAvailable) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.pdfFilename = pdfFilename;
        this.pdfPath = pdfPath;
        this.author = author;
        this.dateUploaded = dateUploaded;
        this.fileSize = fileSize;
        this.isAvailable = isAvailable;
    }
    
    // Constructor without ID (for new books)
    public Book(String title, String description, String pdfFilename, 
                String pdfPath, String author, long fileSize) {
        this.title = title;
        this.description = description;
        this.pdfFilename = pdfFilename;
        this.pdfPath = pdfPath;
        this.author = author;
        this.fileSize = fileSize;
        this.isAvailable = true;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getPdfFilename() { return pdfFilename; }
    public void setPdfFilename(String pdfFilename) { this.pdfFilename = pdfFilename; }
    
    public String getPdfPath() { return pdfPath; }
    public void setPdfPath(String pdfPath) { this.pdfPath = pdfPath; }
    
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    
    public LocalDateTime getDateUploaded() { return dateUploaded; }
    public void setDateUploaded(LocalDateTime dateUploaded) { this.dateUploaded = dateUploaded; }
    
    public long getFileSize() { return fileSize; }
    public void setFileSize(long fileSize) { this.fileSize = fileSize; }
    
    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }
    
    /**
     * Get file size in human readable format
     */
    public String getFormattedFileSize() {
        if (fileSize < 1024) return fileSize + " B";
        if (fileSize < 1024 * 1024) return String.format("%.1f KB", fileSize / 1024.0);
        return String.format("%.1f MB", fileSize / (1024.0 * 1024.0));
    }
    
    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", pdfFilename='" + pdfFilename + '\'' +
                ", fileSize=" + fileSize +
                ", isAvailable=" + isAvailable +
                '}';
    }
}