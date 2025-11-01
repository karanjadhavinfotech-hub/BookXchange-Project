<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Books</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <!-- External CSS File -->
    <link rel="stylesheet" href="home.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script> <!-- Font Awesome for Search Icon -->
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="home.jsp">BookXchange</a>
            <div class="nav-search d-flex align-items-center">
                <form action="search.jsp" method="get" class="d-flex">
                    <input class="form-control searchPannel" type="search" name="search" placeholder="Search for books by ISBN or Name" aria-label="Search">
                    <button class="btn btn-success" type="submit">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form>
            </div>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="addbook.jsp">Add Book</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.html">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ContactUs.html">Contact</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container my-5">
        <h2 class="text-center mb-4">Explore Our Best Books</h2>

        <!-- Best Books Grid -->
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <%
                // JDBC code to fetch books from the database
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
                    String query = "SELECT * FROM books";
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        String id = rs.getString("id");
                        String bookName = rs.getString("name");
                        String condition = rs.getString("conditionn");
                        String isbn = rs.getString("isbn");
                        String price = rs.getString("price");
                        String imagePath = rs.getString("image_path");
            %>
            <div class="col">
                <div class="card border-light shadow-sm rounded">
                    <a href="bookDetails.jsp?id=<%= id %>">
                        <img src="<%= request.getContextPath() %>/<%= imagePath %>" class="card-img-top book-image" alt="<%= bookName %>">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title"><%= bookName %></h5>
                    </div>
                </div>
            </div>
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

        <!-- Scrollable Grids -->
        <div class="scrollable-grid my-5">
            <h3>New Arrivals</h3>
            <div class="d-flex overflow-auto">
                <%
                    // Fetch books for New Arrivals
                    try (Connection newConn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                        Statement newStmt = newConn.createStatement();
                        ResultSet newRs = newStmt.executeQuery("SELECT * FROM books ORDER BY id DESC LIMIT 5");

                        // Check if the result set contains data
                        if (!newRs.next()) {
                            out.println("<p>No new arrivals found.</p>");
                        } else {
                            do {
                                String id = newRs.getString("id");
                                String bookName = newRs.getString("name");
                                String imagePath = newRs.getString("image_path");
                %>
                <div class="card mx-3" style="width: 15rem;">
                    <a href="bookDetails.jsp?id=<%= id %>">
                        <img src="<%= request.getContextPath() %>/<%= imagePath %>" class="card-img-top" alt="<%= bookName %>">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title"><%= bookName %></h5>
                    </div>
                </div>
                <%
                            } while (newRs.next());
                        }
                        newRs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p>Error fetching new arrivals: " + e.getMessage() + "</p>");
                    }
                %>
            </div>
        </div>

        <div class="scrollable-grid my-5">
            <h3>Best Sellers</h3>
            <div class="d-flex overflow-auto">
                <%
                    // Fetch books for Best Sellers
                    try (Connection bestSellerConn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                        Statement bestSellerStmt = bestSellerConn.createStatement();
                        ResultSet bestSellerRs = bestSellerStmt.executeQuery("SELECT * FROM books ORDER BY price DESC LIMIT 5");

                        // Check if the result set contains data
                        if (!bestSellerRs.next()) {
                            out.println("<p>No best sellers found.</p>");
                        } else {
                            do {
                                String id = bestSellerRs.getString("id");
                                String bookName = bestSellerRs.getString("name");
                                String imagePath = bestSellerRs.getString("image_path");
                %>
                <div class="card mx-3" style="width: 15rem;">
                    <a href="bookDetails.jsp?id=<%= id %>">
                        <img src="<%= request.getContextPath() %>/<%= imagePath %>" class="card-img-top" alt="<%= bookName %>">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title"><%= bookName %></h5>
                    </div>
                </div>
                <%
                            } while (bestSellerRs.next());
                        }
                        bestSellerRs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p>Error fetching best sellers: " + e.getMessage() + "</p>");
                    }
                %>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h5>About Us</h5>
                <p>We provide a marketplace for used books. Buy or sell books at affordable prices.</p>
            </div>
            <div class="footer-section">
                <h5>Contact Us</h5>
                <p>Email: BookXchange@gmail.com</p>
                <p>Phone: 7058039478</p>
            </div>
            <div class="footer-section">
                <h5>Follow Us</h5>
                <a href="#">Facebook</a>
                <br>
                <a href="#">Twitter</a>
                <br>
                <a href="https://www.instagram.com/_devil_karana04?igsh=MXcwNWpqYmM2MDQxNQ==">Instagram</a>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
<!-- netlifHII
 --></html>
