<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="home.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script> <!-- Font Awesome for Search Icon -->
</head>
<body>
    <div class="wrapper">
        <header>
            <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
                <div class="container-fluid">
                    <a class="navbar-brand" href="home.jsp">BookXchange</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item"><a class="nav-link active" href="home.jsp">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="addbook.jsp">Add Book</a></li>
                            <li class="nav-item"><a class="nav-link" href="login.html">Login</a></li>
                            <li class="nav-item"><a class="nav-link" href="contact.html">Contact</a></li>
                            <li class="nav-item">
                                <div class="nav-search d-flex align-items-center">
                                    <form action="search.jsp" method="get">
                                        <input class="form-control" type="search" name="search" placeholder="Search for books by ISBN or Name" aria-label="Search">
                                        <button class="btn btn-outline-secondary" type="submit">
                                            <i class="fa-solid fa-magnifying-glass"></i>
                                        </button>
                                    </form>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <main class="mt-5 pt-5">
            <div class="container mt-5">
                <h2 class="text-center mb-4">Search Results</h2>

                <%
                    String searchTerm = request.getParameter("search");
                    if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                        String dbURL = "jdbc:mysql://localhost:3306/toadd";
                        String dbUser = "root";
                        String dbPassword = "Karan2864";
                        Connection connection = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                            // Query to fetch books where name or isbn contains the search term
                            String query = "SELECT * FROM books WHERE name LIKE ? OR isbn LIKE ?";
                            stmt = connection.prepareStatement(query);
                            stmt.setString(1, "%" + searchTerm + "%");
                            stmt.setString(2, "%" + searchTerm + "%");

                            rs = stmt.executeQuery();

                            // Check if there are results
                            if (!rs.next()) {
                                out.println("<p>No books found matching your search.</p>");
                            } else {
                                // Directly iterate through the result set
                                do {
                                    String id = rs.getString("id");
                                    String bookName = rs.getString("name");
                                    String condition = rs.getString("conditionn");
                                    String isbn = rs.getString("isbn");
                                    String price = rs.getString("price");
                                    String sellerName = rs.getString("seller_name");
                                    String phone = rs.getString("phone");
                                    String imagePath = rs.getString("image_path");
                                %>
                                <div class="col-md-4 mb-4">
                                    <div class="card">
                                        <img src="<%= request.getContextPath() + "/" + imagePath %>" class="card-img-top" alt="<%= bookName %>">
                                        <div class="card-body">
                                            <h5 class="card-title"><%= bookName %></h5>
                                            <p class="card-text">Condition: <%= condition %></p>
                                            <p class="card-text">Price: $<%= price %></p>
                                            <p class="card-text">Seller: <%= sellerName %></p>
                                            <p class="card-text">Phone: <%= phone %></p>
                                            <a href="bookDetails.jsp?id=<%= id %>" class="btn btn-primary">View Details</a>
                                        </div>
                                    </div>
                                </div>
                                <%
                                } while (rs.next()); // Loop through all rows
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
                    } else {
                        out.println("<p>Please enter a search term.</p>");
                    }
                %>
            </div>
        </main>

        <footer>
            <div class="footer">
                <hr>
                <p>© 2025 BookXchange. All rights reserved.</p>
            </div>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
