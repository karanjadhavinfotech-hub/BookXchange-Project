<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <style>
        .profile-container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
        }
        .profile-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #007bff;
        }
        .btn-container {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body class="bg-light">

<%
    // Database credentials
    String dbURL = "jdbc:mysql://localhost:3306/toadd";
    String dbUser = "root";
    String dbPassword = "Karan2864";
    Connection connection = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // Get user name from session
    String userName = (String) session.getAttribute("userName");

    if (userName == null) {
        response.sendRedirect("login.html"); // Redirect if session expired
    }

    try {
        // Load JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to fetch user details
        String query = "SELECT * FROM createaccount WHERE name = ?";
        stmt = connection.prepareStatement(query);
        stmt.setString(1, userName);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            int id = rs.getInt("id");
            String countryCode = rs.getString("countryCode");
            String mobileNo = rs.getString("mobileNo");
            String profilePic = rs.getString("profile_pic");
            Timestamp createdAt = rs.getTimestamp("created_at");
%>

<div class="container my-5">
    <div class="profile-container">
        <img src="<%= request.getContextPath() %>/<%= profilePic %>" alt="Profile Picture" class="profile-img mb-3">
        <h2><%= userName %></h2>
        <p><strong>Country Code:</strong> <%= countryCode %></p>
        <p><strong>Mobile:</strong> <%= mobileNo %></p>
        <p><strong>Joined:</strong> <%= createdAt %></p>

        <h4 class="mt-4">Books Sold</h4>
        <ul>
            <%
                PreparedStatement soldStmt = connection.prepareStatement("SELECT book_name FROM orders WHERE buyer_name = ?");
                soldStmt.setString(1, userName);
                ResultSet soldRs = soldStmt.executeQuery();
                while (soldRs.next()) {
            %>
            <li><%= soldRs.getString("book_name") %></li>
            <%
                }
                soldRs.close();
            %>
        </ul>

        <h4 class="mt-4">Books Bought</h4>
        <ul>
            <%
                PreparedStatement boughtStmt = connection.prepareStatement("SELECT book_name FROM orders WHERE buyer_name = ?");
                boughtStmt.setString(1, userName);
                ResultSet boughtRs = boughtStmt.executeQuery();
                while (boughtRs.next()) {
            %>
            <li><%= boughtRs.getString("book_name") %></li>
            <%
                }
                boughtRs.close();
            %>
        </ul>

        <div class="btn-container mt-4">
            <a href="edit_profile.jsp" class="btn btn-primary">Edit Profile</a>
            <a href="logout.jsp" class="btn btn-danger">Logout</a>
        </div>
    </div>
</div>

<%
        }
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
