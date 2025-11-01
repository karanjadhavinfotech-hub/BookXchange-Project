<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Now - BookXchange</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="buyNow.css">
</head>
<body>
    <div class="container mt-5">
        <%
            // Retrieve book ID from URL parameters
            String id = request.getParameter("id");
            String dbURL = "jdbc:mysql://localhost:3306/toadd";
            String dbUser = "root";
            String dbPassword = "Karan2864";
            Connection connection = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Connect to the database
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // Fetch book details by ID
                String query = "SELECT * FROM books WHERE id = ?";
                stmt = connection.prepareStatement(query);
                stmt.setInt(1, Integer.parseInt(id));  // Use prepared statement to prevent SQL injection
                rs = stmt.executeQuery();

                if (rs.next()) {
                    String bookName = rs.getString("name");
                    String condition = rs.getString("conditionn");
                    String isbn = rs.getString("isbn");
                    String price = rs.getString("price");
                    String imagePath = rs.getString("image_path");
        %>

        <!-- Book Details -->
        <div class="row">
            <div class="col-md-6">
                <img src="<%= request.getContextPath() %>/<%= imagePath %>" class="img-fluid" alt="Book Image">
            </div>
            <div class="col-md-6">
                <h2><%= bookName %></h2>
                <p><strong>Condition:</strong> <%= condition %></p>
                <p><strong>ISBN:</strong> <%= isbn %></p>
                <p><strong>Price:</strong> $<%= price %></p>
                <form action="confirmPurchase.jsp" method="post">
                    <input type="hidden" name="bookId" value="<%= id %>">
                    <input type="hidden" name="bookName" value="<%= bookName %>">
                    <input type="hidden" name="price" value="<%= price %>">
                    <div class="mb-3">
                        <label for="quantity" class="form-label">Quantity</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" min="1" value="1" required>
                    </div>
                    <div class="mb-3">
                        <label for="paymentMethod" class="form-label">Payment Method</label>
                        <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                            <option value="creditCard">Credit Card</option>
                            <option value="paypal">PayPal</option>
                            <option value="bankTransfer">Bank Transfer</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Buy Now</button>
                </form>
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
