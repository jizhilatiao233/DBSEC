<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StaffLogin - Shop Management System</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('./img/index.jpg') no-repeat center center fixed; /* 使用背景图片 */
            background-size: cover; /* 背景图片覆盖整个页面 */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        .container {
            background: rgba(255, 255, 255, 0.85); /* 半透明的背景，使内容可读 */
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1); /* 深阴影效果 */
            width: 100%;
            max-width: 400px;
            transition: all 0.3s ease;
        }

        h1 {
            margin-bottom: 20px;
            font-size: 26px;
            color: #333;
            text-align: center;
            font-weight: bold;
        }

        .error {
            color: red;
            background: #ffecec;
            padding: 12px;
            border: 1px solid #ffcccc;
            border-radius: 6px;
            text-align: center;
            margin-bottom: 20px;
            font-weight: 500;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="text"], input[type="password"], select {
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 16px;
            outline: none;
            transition: all 0.3s;
        }

        input[type="text"]:focus, input[type="password"]:focus, select:focus {
            border-color: #4facfe;
            box-shadow: 0 0 8px rgba(79, 172, 254, 0.3);
        }

        input[type="submit"] {
            background: #4facfe;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }

        input[type="submit"]:hover {
            background: #00c6fb;
            transform: translateY(-3px); /* 按钮浮动效果 */
        }

        input[type="submit"]:active {
            transform: translateY(1px); /* 按钮点击下沉效果 */
        }

        /* 响应式设计 */
        @media (max-width: 500px) {
            .container {
                padding: 20px;
                max-width: 100%;
            }

            h1 {
                font-size: 22px;
            }

            input[type="text"], input[type="password"], select {
                font-size: 14px;
            }

            input[type="submit"] {
                font-size: 14px;
            }
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
                            window.location.href = 'Logout?redirect=login_staff.jsp';
                        } else {
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

<div class="container">
    <h1>Staff Login</h1>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="StaffLogin" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username"
               value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
               placeholder="Enter your username" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Enter your password" required>

        <input type="submit" value="Login">
    </form>
</div>

</body>
</html>
