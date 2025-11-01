<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // Retrieve form data
    String UserId = request.getParameter("UserId");
    String Password = request.getParameter("Password");

    // Hardcoded credentials
    String correctUserId = "Karan";
    String correctPassword = "Karan121";

    if (UserId != null && Password != null && UserId.equals(correctUserId) && Password.equals(correctPassword)) {
%>
        <script>
            alert("Login successful!");
            window.location.href = "admin.jsp"; // Redirect to admin dashboard
        </script>
<%
    } else {
%>
        <script>
            alert("Invalid UserId or Password.");
            window.history.back();  // Redirect back to login page
        </script>
<%
    }
%>
