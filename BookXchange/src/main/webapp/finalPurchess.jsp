<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Finalize Purchase</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <%
            // Fetch the book and buyer details
            String bookId = request.getParameter("bookId");
            String buyerName = request.getParameter("buyerName");
            String buyerPhone = request.getParameter("buyerPhone");
            String buyerAddress = request.getParameter("buyerAddress");

            String dbURL = "jdbc:mysql://localhost:3306/toadd";
            String dbUser = "root";
            String dbPassword = "Karan2864";
            Connection connection = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                stmt = connection.createStatement();
                
                // Fetch book details using the book ID
                String bookQuery = "SELECT * FROM books WHERE id = " + bookId;
                rs = stmt.executeQuery(bookQuery);
                
                String bookName = "";
                String price = "";
                if (rs.next()) {
                    bookName = rs.getString("name");
                    price = rs.getString("price");
                }

                // Insert purchase details into the orders table
                String orderQuery = "INSERT INTO orders (book_id, book_name, price, buyer_name, buyer_phone, buyer_address, order_date) " +
                                     "VALUES (?, ?, ?, ?, ?, ?, NOW())";
                PreparedStatement pstmt = connection.prepareStatement(orderQuery);
                pstmt.setString(1, bookId);
                pstmt.setString(2, bookName);
                pstmt.setString(3, price);
                pstmt.setString(4, buyerName);
                pstmt.setString(5, buyerPhone);
                pstmt.setString(6, buyerAddress);
                
                int result = pstmt.executeUpdate();
                
                if (result > 0) {
        %>
                    <div class="alert alert-success" role="alert">
                        <h4 class="alert-heading">Purchase Confirmed!</h4>
                        <p>Your order has been successfully placed.</p>
                        <p><strong>Book:</strong> <%= bookName %></p>
                        <p><strong>Price:</strong> $<%= price %></p>
                        <p><strong>Buyer Name:</strong> <%= buyerName %></p>
                        <p><strong>Phone:</strong> <%= buyerPhone %></p>
                        <p><strong>Address:</strong> <%= buyerAddress %></p>
                        <hr>
                        <p class="mb-0">Thank you for shopping with us. We will process your order soon.</p>
                    </div>
                    <a href="home.jsp" class="btn btn-primary mt-3">Go to Home</a>
        <%
                } else {
        %>
                    <div class="alert alert-danger" role="alert">
                        <h4 class="alert-heading">Error</h4>
                        <p>There was an issue placing your order. Please try again.</p>
                    </div>
                    <a href="confirmPurchase.jsp?id=<%= bookId %>" class="btn btn-warning mt-3">Try Again</a>
        <%
                }

            } catch (SQLException | ClassNotFoundException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
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
