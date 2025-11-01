package Add;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@WebServlet("/fetchBooks")
public class FetchBooksServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/toadd";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Karan2864";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<HashMap<String, String>> books = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT name, conditionn, isbn, price, image_path FROM books";
            try (PreparedStatement statement = connection.prepareStatement(sql);
                 ResultSet resultSet = statement.executeQuery()) {
                 
                while (resultSet.next()) {
                    HashMap<String, String> book = new HashMap<>();
                    book.put("name", resultSet.getString("name"));
                    book.put("condition", resultSet.getString("conditionn"));
                    book.put("isbn", resultSet.getString("isbn"));
                    book.put("price", resultSet.getString("price"));
                    book.put("image_path", resultSet.getString("image_path"));

                    books.add(book);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("books", books);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
