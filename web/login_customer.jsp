<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Customer Login - Shop Management System</title>
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
    input[type="text"], input[type="password"] {
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
    .error {
      color: red;
      margin-bottom: 15px;
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
            var confirmLogout = confirm("You are already logged in. Do you want to log in as a different user?");
            if (confirmLogout) {
              window.location.href = 'Logout?redirect=login_customer.jsp';
            } else {
              window.location.href = 'product?action=list';
            }
          }
        }
      };
      xhr.send();
    }
  </script>
</head>
<body>
<h1>Customer Login</h1>
<% if (request.getAttribute("error") != null) { %>
<div class="error"><%= request.getAttribute("error") %></div>
<% } %>
<form action="CustomerLogin" method="post">
  <label for="username">Username:</label>
  <input type="text" id="username" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" required>

  <label for="password">Password:</label>
  <input type="password" id="password" name="password" required>

  <input type="submit" value="Login">
</form>
</body>
</html>