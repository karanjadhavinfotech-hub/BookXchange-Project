<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookstore Admin Dashboard</title>
    <!-- <link rel="stylesheet"> -->
    <style>
        /* Basic Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f9;
    color: #333;
    display: flex;
    min-height: 100vh;
}

/* Sidebar Styling */
.sidebar {
    width: 250px;
    background-color: #34495e; /* Darker background */
    color: white;
    padding: 20px;
    position: fixed;
    height: 100%;
    top: 0;
    left: 0;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.sidebar .logo h2 {
    font-size: 24px;
    margin-bottom: 30px;
    text-align: center;
    font-weight: bold;
}

.sidebar ul {
    list-style: none;
  
}

.sidebar ul li {
    margin: 15px 0;
}

.sidebar ul li a {
    color:black;
    text-decoration: none;
    font-size: 18px;
    display: block;
    padding: 10px;
    transition: background-color 0.3s ease, transform 0.3s ease;
    border-radius: 5px; 
}

/* .sidebar ul li a:hover {
    background-color: #1abc9c; 
    transform: scale(1.05); 
} */

/* Main Content Styling */
.container {
    margin-left: 250px;
    padding: 20px;
    flex-grow: 1;
}

.main-content h1 {
    font-size: 28px;
    margin-bottom: 20px;
    color: #2c3e50;
}

.main-content p {
    font-size: 16px;
    color: #7f8c8d;
}

/* Dashboard Stats */
.stats {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
}

.stat-card {
    background-color: #ecf0f1;
    padding: 20px;
    border-radius: 8px;
    width: 30%;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.stat-card h3 {
    font-size: 18px;
    color: #2c3e50;
}

.stat-card .stat-number {
    font-size: 32px;
    font-weight: bold;
    color: #2980b9;
}

/* Section Styling */
.section {
    margin-top: 30px;
}

.hidden {
    display: none;
}

.add-btn {
    background-color: #3498db; /* Blue color for Add buttons */
    color: #fff; /* White text color */
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
    margin-bottom: 20px; /* Add space between button and content */
}

.add-btn:hover {
    background-color: #2980b9; /* Darker shade of blue for hover */
}

/* Change for Logout Button - Darker Color */
#logout {
    background-color: #e74c3c; /* Red color for Logout button */
    color: #fff; /* White text */
    padding: 15px;
    font-size: 16px;
    width: 100%;
    cursor: pointer;
    border: none;
    border-radius: 5px;
    margin-top: 30px;
    transition: background-color 0.3s ease;
}

#logout:hover {
    background-color: #c0392b; /* Darker red for hover */
}

/* Form Styling */
.form-container {
    margin-top: 20px;
}

.form-container input {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}

.form-container button {
    width: 100%;
    padding: 10px;
    background-color: #27ae60;
    color: #fff; 
    border: none;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.form-container button:hover {
    background-color: #2ecc71;
}

/* List Styling */
ul {
    margin-top: 20px;
}

ul li {
    background-color: #ecf0f1;
    padding: 10px;
    margin-bottom: 10px;
    border-radius: 5px;
    font-size: 16px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* Responsive Design */
@media screen and (max-width: 768px) {
    .container {
        margin-left: 0;
        padding: 10px;
    }

    .sidebar {
        width: 100%;
        position: relative;
        height: auto;
        padding: 10px;
    }

    .sidebar ul li {
        font-size: 16px;
    }

    .stats {
        flex-direction: column;
        align-items: center;
    }

    .stat-card {
        width: 100%;
        margin-bottom: 10px;
    }
}

    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo">
                <h2>Bookstore Admin</h2>
            </div>
            <ul style="margin-top:-100px;">
                <li><a href="home.jsp" id="homeLink">Home</a></li>
                <li><a href="userAdminBoard.jsp" id="usersLink">Users</a></li>
                <li><a href="orders.jsp" id="ordersLink">Orders</a></li>
                <li><a href="ContactAdmin.jsp" id="contactUsLink">Contact Us</a></li>
                <li><a href="home.jsp" id="logout">Logout</a></li>
            </ul>
        </div>

        <!-- Main content area -->
        <div class="main-content">
            <h1>Welcome to the Bookstore Admin Dashboard</h1>
            <p>Choose a section from the sidebar to manage your content.</p>

            <!-- Home Section with Stats -->
            <div id="homeSection" class="section">
                <h2>Dashboard</h2>
                <div class="stats">
                    <div class="stat-card">
                        <h3>Users</h3>
<!--                         <p class="stat-number">150</p>
 -->                    </div>
                    <div class="stat-card">
                        <h3>Orders</h3>
<!--                         <p class="stat-number">320</p>
 -->                    </div>
                    <div class="stat-card">
                        <h3>Contact Inquiries</h3>
<!--                         <p class="stat-number">45</p>
 -->                    </div>
                </div>
            </div>

            <!-- Users Section -->
           <!--  <div id="usersSection" class="section hidden">
                <h2>Manage Users</h2>
                <button class="add-btn" onclick="toggleForm('userForm')">Add User</button>
                <div id="userForm" class="form-container hidden">
                    <input type="text" id="userName" placeholder="Enter User Name" />
                    <button onclick="addUser()">Add</button>
                </div>
                <h3>User List</h3>
                <ul id="userList">
                    List of Users will be added here
                </ul>
            </div> -->

            <!-- Orders Section -->
          <!--   <div id="ordersSection" class="section hidden">
                <h2>Manage Orders</h2>
                <button class="add-btn" onclick="toggleForm('orderForm')">Add Order</button>
                <div id="orderForm" class="form-container hidden">
                    <input type="text" id="orderDetails" placeholder="Enter Order Details" />
                    <button onclick="addOrder()">Add</button>
                </div>
                <h3>Order List</h3>
                <ul id="orderList">
                    List of Orders will be added here
                </ul>
            </div> -->

            <!-- Contact Us Section -->


        </div>
    </div>

    <script>
        // Toggle visibility of forms
        function toggleForm(formId) {
            const form = document.getElementById(formId);
            form.classList.toggle('hidden');
        }

        // Function to add a user
     /*    function addUser() {
            const userName = document.getElementById('userName').value;
            if (userName) {
                const userList = document.getElementById('userList');
                const listItem = document.createElement('li');
                listItem.textContent = userName;
                userList.appendChild(listItem);
                document.getElementById('userName').value = ''; // Clear input field
                toggleForm('userForm'); // Hide form after adding
            } else {
                alert('Please enter a user name.');
            }
        } */

        // Function to add an order
     /*    function addOrder() {
            const orderDetails = document.getElementById('orderDetails').value;
            if (orderDetails) {
                const orderList = document.getElementById('orderList');
                const listItem = document.createElement('li');
                listItem.textContent = orderDetails;
                orderList.appendChild(listItem);
                document.getElementById('orderDetails').value = ''; // Clear input field
                toggleForm('orderForm'); // Hide form after adding
            } else {
                alert('Please enter order details.');
            }
        } */

        // Function to add a contact inquiry
        function addContact() {
            const contactName = document.getElementById('contactName').value;
            if (contactName) {
                const contactList = document.getElementById('contactList');
                const listItem = document.createElement('li');
                listItem.textContent = contactName;
                contactList.appendChild(listItem);
                document.getElementById('contactName').value = ''; // Clear input field
                toggleForm('contactForm'); // Hide form after adding
            } else {
                alert('Please enter contact inquiry details.');
            }
        }

        // Show the respective section based on sidebar navigation
        document.getElementById('homeLink').addEventListener('click', function() {
            document.getElementById('homeSection').classList.remove('hidden');
            document.getElementById('usersSection').classList.add('hidden');
            document.getElementById('ordersSection').classList.add('hidden');
            document.getElementById('contactUsSection').classList.add('hidden');
        });

        document.getElementById('usersLink').addEventListener('click', function() {
            document.getElementById('homeSection').classList.add('hidden');
            document.getElementById('usersSection').classList.remove('hidden');
            document.getElementById('ordersSection').classList.add('hidden');
            document.getElementById('contactUsSection').classList.add('hidden');
        });

        document.getElementById('ordersLink').addEventListener('click', function() {
            document.getElementById('homeSection').classList.add('hidden');
            document.getElementById('usersSection').classList.add('hidden');
            document.getElementById('ordersSection').classList.remove('hidden');
            document.getElementById('contactUsSection').classList.add('hidden');
        });

        document.getElementById('contactUsLink').addEventListener('click', function() {
            document.getElementById('homeSection').classList.add('hidden');
            document.getElementById('usersSection').classList.add('hidden');
            document.getElementById('ordersSection').classList.add('hidden');
            document.getElementById('contactUsSection').classList.remove('hidden');
        });

        // Logout functionality
        document.getElementById('logout').addEventListener('click', function() {
            alert('Logging out...');
            // Add actual logout functionality here (e.g., redirect to login page)
        });
    </script>
</body>
</html>
