<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bookDetails.css">
</head>
<body>
    <div class="container mt-5">
        <%
            String id = request.getParameter("id");  // Get book ID from URL
            String dbURL = "jdbc:mysql://localhost:3306/toadd";
            String dbUser = "root";
            String dbPassword = "Karan2864";
            Connection connection = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // Fetch the book details
                String query = "SELECT * FROM books WHERE id = ?";
                stmt = connection.prepareStatement(query);
                stmt.setInt(1, Integer.parseInt(id));  // Use prepared statements to prevent SQL injection
                rs = stmt.executeQuery();

                if (rs.next()) {
                    String bookName = rs.getString("name");
                    String condition = rs.getString("conditionn");
                    String isbn = rs.getString("isbn");
                    String price = rs.getString("price");
                    String imagePath = rs.getString("image_path");
        %>
        
        <div class="row book-info">
            <div class="col-md-6">
                <img src="<%= request.getContextPath() %>/<%= imagePath %>" class="img-fluid" alt="Book Image">
            </div>
            <div class="col-md-6">
                <h2><%= bookName %></h2>
                <p><strong>Condition:</strong> <%= condition %></p>
                <p><strong>ISBN:</strong> <%= isbn %></p>
                <p><strong>Price:</strong> $<%= price %></p>
                <a href="buyNow.jsp?id=<%= id %>" class="btn btn-primary">Buy Now</a>
            </div>
        </div>

        <!-- Related Books Section -->
        <div class="related-books-section">
            <h3>Related Books</h3>
            <div class="row">
                <%
                    // Fetch related books based on the same condition
                    String relatedQuery = "SELECT * FROM books WHERE conditionn = ? LIMIT 3";
                    PreparedStatement relatedStmt = connection.prepareStatement(relatedQuery);
                    relatedStmt.setString(1, condition);
                    ResultSet relatedRs = relatedStmt.executeQuery();
                    
                    while (relatedRs.next()) {
                        String relatedBookName = relatedRs.getString("name");
                        String relatedBookImagePath = relatedRs.getString("image_path");
                        String relatedBookId = relatedRs.getString("id");
                %>
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <img src="<%= request.getContextPath() %>/<%= relatedBookImagePath %>" class="related-book-img" alt="Related Book">
                        <div class="card-body">
                            <h5 class="card-title"><%= relatedBookName %></h5>
                            <a href="bookDetails.jsp?id=<%= relatedBookId %>" class="btn btn-secondary">View Details</a>
                        </div>
                    </div>
                </div>
                <% 
                    } 
                    relatedRs.close();
                    relatedStmt.close();
                %>
            </div>
        </div>
        
        <%
                }
                rs.close();
                stmt.close();
            } catch (SQLException | ClassNotFoundException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
