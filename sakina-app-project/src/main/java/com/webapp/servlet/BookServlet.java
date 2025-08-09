package com.webapp.servlet;

import com.webapp.dao.BookDAO;
import com.webapp.model.Book;
import com.webapp.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

/**
 * Servlet for handling book library browsing and viewing
 */
@WebServlet("/books")
public class BookServlet extends HttpServlet {
    
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?redirect=books");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        
        try {
            if ("view".equals(action) && idParam != null) {
                // View single book details
                int bookId = Integer.parseInt(idParam);
                Book book = bookDAO.getBookById(bookId);
                
                if (book != null && book.isAvailable()) {
                    request.setAttribute("book", book);
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/book-view.jsp").forward(request, response);
                } else {
                    response.sendRedirect("books?error=Book not found");
                }
            } else if ("download".equals(action) && idParam != null) {
                // Handle PDF download
                int bookId = Integer.parseInt(idParam);
                downloadPDF(bookId, request, response);
            } else {
                // List all available books
                List<Book> books = bookDAO.getAllAvailableBooks();
                request.setAttribute("books", books);
                request.setAttribute("user", user);
                request.getRequestDispatcher("/books.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("books?error=Invalid book ID");
        } catch (Exception e) {
            System.err.println("Error in BookServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("books?error=An error occurred");
        }
    }
    
    /**
     * Handle PDF file download
     */
    private void downloadPDF(int bookId, HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            Book book = bookDAO.getBookById(bookId);
            if (book == null || !book.isAvailable()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book not found");
                return;
            }
            
            // Get the real path to the PDF file
            String webAppPath = getServletContext().getRealPath("/");
            String filePath = webAppPath + book.getPdfPath();
            File pdfFile = new File(filePath);
            
            if (!pdfFile.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "PDF file not found");
                return;
            }
            
            // Set response headers for PDF download
            response.setContentType("application/pdf");
            response.setContentLength((int) pdfFile.length());
            response.setHeader("Content-Disposition", 
                "attachment; filename=\"" + book.getPdfFilename() + "\"");
            
            // Stream the file to the response
            try (FileInputStream fileInputStream = new FileInputStream(pdfFile);
                 OutputStream outputStream = response.getOutputStream()) {
                
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                outputStream.flush();
            }
            
        } catch (Exception e) {
            System.err.println("Error downloading PDF: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error downloading file");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}