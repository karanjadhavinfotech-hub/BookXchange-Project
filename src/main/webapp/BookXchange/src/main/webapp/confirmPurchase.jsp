<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Purchase - BookXchange</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="confirmPurchase.css">
</head>
<body>
    <div class="container mt-5">
        <%
            // Get parameters from the previous page (buyNow.jsp)
            String bookId = request.getParameter("bookId");
            String bookName = request.getParameter("bookName");
            String price = request.getParameter("price");
            String quantity = request.getParameter("quantity");
            String paymentMethod = request.getParameter("paymentMethod");

            // Calculate total price
            double totalPrice = Double.parseDouble(price) * Integer.parseInt(quantity);
        %>

        <div class="row">
            <div class="col-md-12">
                <h2>Confirm Your Purchase</h2>
                <div class="mb-4">
                    <h4><%= bookName %></h4>
                    <p><strong>Price:</strong> $<%= price %></p>
                    <p><strong>Quantity:</strong> <%= quantity %></p>
                    <p><strong>Total Price:</strong> $<%= totalPrice %></p>
                    <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
                </div>

                <!-- Confirmation Form -->
                <form action="finalPurchess.jsp" method="post">
                    <input type="hidden" name="bookId" value="<%= bookId %>">
                    <input type="hidden" name="bookName" value="<%= bookName %>">
                    <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
                    <input type="hidden" name="paymentMethod" value="<%= paymentMethod %>">

                    <div class="mb-3">
                        <label for="customerName" class="form-label">Customer Name</label>
                        <input type="text" class="form-control" id="customerName" name="customerName" required>
                    </div>
                    <div class="mb-3">
                        <label for="shippingAddress" class="form-label">Shipping Address</label>
                        <textarea class="form-control" id="shippingAddress" name="shippingAddress" rows="4" required></textarea>
                    </div>

                    <button type="submit" class="btn btn-success">Confirm Purchase</button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
