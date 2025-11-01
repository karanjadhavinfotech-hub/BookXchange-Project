<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Information</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container my-5">
    <h2 class="text-center mb-4">User Information</h2>
    
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Country Code</th>
                <th>Mobile No</th>
                <th>Password</th>
                <th>Created At</th>
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
                    
                    // Query to get user details
                    String query = "SELECT * FROM createaccount";
                    stmt = connection.createStatement();
                    rs = stmt.executeQuery(query);

                    // Display results in the table
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("countryCode") %></td>
                <td><%= rs.getString("mobileNo") %></td>
<%--                 <td><%= rs.getString("otp") %></td>
 --%>                <td><%= rs.getString("password") %></td>
                <td><%= rs.getTimestamp("created_at") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='7' class='text-center text-danger'>Error: " + e.getMessage() + "</td></tr>");
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
