package Add;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/ContactUs")
public class ContactUs extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ContactUs() {
        super();
    }
    
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieving form data
        String firstName = request.getParameter("fname");
        String lastName = request.getParameter("lname");
        String email = request.getParameter("email");
        String comment = request.getParameter("comment");

        // Database connection variables
        String jdbcURL = "jdbc:mysql://localhost:3306/toadd";
        String dbUser = "root"; // Change if needed
        String dbPassword = "Karan2864"; // Replace with your MySQL password

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL Insert Query
            String sql = "INSERT INTO ContactUs (fname, lname, email, comment) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setString(4, comment);

            // Execute Query
            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                out.println("<h2>Thank you! Your message has been received.</h2>");
                response.sendRedirect("home.jsp"); 

            } else {
                out.println("<h2>Error! Please try again.</h2>");
            }

        } catch (ClassNotFoundException e) {
            out.println("<h2>Error: MySQL JDBC Driver not found.</h2>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("<h2>Database connection error: " + e.getMessage() + "</h2>");
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}