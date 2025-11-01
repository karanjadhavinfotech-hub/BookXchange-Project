<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sell & Buy Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <style>
        .container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        h2 {
            color: #007bff;
            text-align: center;
        }
        .list-group-item {
            font-size: 16px;
        }
    </style>
</head>
<body class="bg-light">

<%
    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/toadd";
    String dbUser = "root";
    String dbPassword = "Karan2864";
    Connection connection = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // Get logged-in user name from session
    String userName = (String) session.getAttribute("userName");

    if (userName == null) {
        response.sendRedirect("login.html"); // Redirect if session expired
    }

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Fetch user details (name, mobile number)
        String userQuery = "SELECT name, mobileNo FROM users WHERE name = ?";
        stmt = connection.prepareStatement(userQuery);
        stmt.setString(1, userName);
        rs = stmt.executeQuery();
        
        String mobileNumber = "";
        if (rs.next()) {
            mobileNumber = rs.getString("mobileNo");
        }
%>

<div class="container my-5">
    <h2>Sell & Buy Details</h2>
    <hr>
    <p><strong>Name:</strong> <%= userName %></p>
    <p><strong>Mobile Number:</strong> <%= mobileNumber %></p>

    <h4 class="mt-4">Books Sold</h4>
    <ul class="list-group">
        <%
            PreparedStatement soldStmt = connection.prepareStatement("SELECT book_name FROM orders WHERE buyer_name = ?");
            soldStmt.setString(1, userName);
            ResultSet soldRs = soldStmt.executeQuery();
            while (soldRs.next()) {
        %>
        <li class="list-group-item"><%= soldRs.getString("book_name") %></li>
        <%
            }
            soldRs.close();
        %>
    </ul>

    <h4 class="mt-4">Books Bought</h4>
    <ul class="list-group">
        <%
            PreparedStatement boughtStmt = connection.prepareStatement("SELECT book_name FROM orders WHERE buyer_name = ?");
            boughtStmt.setString(1, userName);
            ResultSet boughtRs = boughtStmt.executeQuery();
            while (boughtRs.next()) {
        %>
        <li class="list-group-item"><%= boughtRs.getString("book_name") %></li>
        <%
            }
            boughtRs.close();
        %>
    </ul>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (connection != null) connection.close();
    }
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
