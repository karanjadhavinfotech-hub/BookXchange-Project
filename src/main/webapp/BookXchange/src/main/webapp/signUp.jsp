<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String countryCode = request.getParameter("countryCode");
    String mobileNo = request.getParameter("mobileNo");
    String otp = request.getParameter("otp");
    String password = request.getParameter("password");

    boolean isValidUser = false;
    boolean isDuplicateMobile = false;  // Flag to track if the mobile number is duplicate

    // Database credentials
    String dbUrl = "jdbc:mysql://localhost:3306/toadd";
    String dbUser = "root";
    String dbPassword = "Karan2864";

    try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {

        // Step 1: Check if the mobile number already exists
        String checkSql = "SELECT COUNT(*) FROM createAccount WHERE mobileNo = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, mobileNo);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                isDuplicateMobile = true;  // Mobile number already exists
            }
        }

        // Step 2: If mobile number is not duplicate, insert the data
        if (!isDuplicateMobile) {
            String sql = "INSERT INTO createAccount (name, countryCode, mobileNo, otp, password) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setString(2, countryCode);
                ps.setString(3, mobileNo);
                ps.setString(4, otp);
                ps.setString(5, password);

                int rowsInserted = ps.executeUpdate();
                isValidUser = rowsInserted > 0;  // Successfully inserted
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    // Handling response based on validation
    if (isDuplicateMobile) {
%>
        <script>
            alert("This mobile number is already registered. Please use a different mobile number.");
            window.history.back();  // Go back to the previous page
        </script>
<%
    } else if (isValidUser) {
%>
        <script>
            alert("Account created successfully!");
            window.location.href = "login.html";  // Redirect to login page
        </script>
<%
    } else {
%>
        <script>
            alert("Error creating account. Please try again.");
            window.history.back();  // Go back to the previous page
        </script>
<%
    }
%>
