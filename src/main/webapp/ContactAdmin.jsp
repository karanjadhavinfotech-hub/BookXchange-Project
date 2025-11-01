<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact List</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container my-5">
    <h2 class="text-center mb-4">Contact Details</h2>
    
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Comment</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Database credentials
                String dbURL = "jdbc:mysql://localhost:3306/toadd";
                String dbUser = "root";
                String dbPassword = "Karan2864";

                Connection connection = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Load JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    // Establish Connection
                    connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                    
                    // Query to get order details
                    String query = "SELECT * FROM contactus";
                    stmt = connection.createStatement();
                    rs = stmt.executeQuery(query);

                    // Display results in the table
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("fname") %></td>
                <td><%= rs.getString("lname") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("comment") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='8' class='text-center text-danger'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    // Close resources
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (connection != null) connection.close();
                }
            %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
