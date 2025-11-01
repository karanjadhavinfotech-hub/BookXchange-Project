package Add;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/addBook")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Limit file size to 5MB
public class Add1 extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/toadd";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Karan2864";
    private static final String UPLOAD_DIR = "C:/Users/kj501/eclipse-workspace/BookXchange/src/main/webapp/resources/uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Extract form data
        String bookName = request.getParameter("bookName");
        String condition = request.getParameter("condition");
        String isbn = request.getParameter("isbn");
        String price = request.getParameter("price");
//        String description = request.getParameter("description");
        String sellerName = request.getParameter("sellerName");
        String phoneNumber = request.getParameter("phoneNumber");

        // Handle file upload
        Part filePart = request.getPart("images");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Ensure upload directory exists
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Creates directory if it doesn't exist
        }

        // Save file to the server
        String filePath = UPLOAD_DIR + File.separator + fileName;
        filePart.write(filePath);

        // Store relative path (to be used in JSP)
        String dbImagePath = "resources/uploads/" + fileName;

        // Insert data into the database
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO books (name, conditionn, isbn, price, seller_name, phone, image_path) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, bookName);
                statement.setString(2, condition);
                statement.setString(3, isbn);
                statement.setString(4, price);
//                statement.setString(5, description);
                statement.setString(5, sellerName);
                statement.setString(6, phoneNumber);
                statement.setString(7, dbImagePath);

                int rowsInserted = statement.executeUpdate();
                response.getWriter().write(rowsInserted > 0 ? "<h2>Book added successfully!</h2>" : "<h2>Failed to add the book. Try again.</h2>");
            }
        } catch (SQLException e) {
            response.getWriter().write("<h2>Error: " + e.getMessage() + "</h2>");
        }
    }
}
