<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CustomerRegister - Shop Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        form {
            margin: 50px auto;
            display: inline-block;
            text-align: left;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"], input[type="password"], input[type="email"], input[type="tel"] {
            width: 100%;
            padding: 8px;
            margin: 5px 0 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        window.onload = function() {
            checkSession();
        }

        function checkSession() {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', 'CheckSession', true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    if (response.loggedIn) {
                        var confirmLogout = confirm("You are already logged in. Do you want to log out and continue registering?");
                        if (confirmLogout) {
                            window.location.href = 'Logout?redirect=register_customer.jsp';
                        } else {
                            // TODO: Prevent form submission (Alternative)
                            window.location.href = 'index.jsp';
                        }
                    }
                }
            };
            xhr.send();
        }
    </script>
</head>
<body>
<h1>Customer Registration</h1>
<form action="CustomerRegister" method="post" onsubmit="checkSession()">
    <label for="customerName">Full Name:</label>
    <input type="text" id="customerName" name="customerName" required>

    <label for="contactInfo">Contact Info:</label>
    <input type="tel" id="contactInfo" name="contactInfo" required>

    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required>

    <label for="vip">
        <input type="checkbox" id="vip" name="vip"> Register as VIP
    </label>

    <input type="submit" value="Register">
</form>
</body>
</html>
