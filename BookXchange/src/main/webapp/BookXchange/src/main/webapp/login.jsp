<%@ page import="java.sql.*" %>
<%-- <%@ page import="javax.servlet.http.*, javax.servlet.*" %>
 --%>
<%
String mobileNo = request.getParameter("mobileNo");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    boolean isValidUser = false;

    try {
        // Step 1: Database connection
        String dbUrl = "jdbc:mysql://localhost:3306/toadd";
        String dbUser = "root";
        String dbPassword = "Karan2864";
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // Step 2: Query to check login
        String sql = "SELECT * FROM createAccount WHERE mobileNo = ? AND password = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, mobileNo);
        ps.setString(2, password);
        
        rs = ps.executeQuery();

        if (rs.next()) {
            isValidUser = true;
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }

    if (isValidUser) {
%>
        <script>
            alert("Login successful!");
            window.location.href = "home.jsp";  // Redirect to homepage after login
        </script>
<%
    } else {
%>
        <script>
            alert("Invalid Mobile Number or Password.");
            window.history.back();  // Go back to login page
        </script>
<%
    }
%>
