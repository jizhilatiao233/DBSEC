<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Shop Management System</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: url('./img/index.jpg') no-repeat center center fixed;
            background-size: cover;
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

        /* 表单布局 */
        form {
            display: flex;
            flex-direction: column;
            gap: 20px; /* 控制每个表单项之间的间距 */
        }

        label {
            margin-bottom: 5px; /* 标签底部的间距 */
            font-weight: bold;
        }

        input[type="text"], input[type="password"], input[type="email"], input[type="tel"] {
            width: 100%; /* 让输入框占满宽度 */
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
            outline: none;
            transition: all 0.3s;
        }

        input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus, input[type="tel"]:focus {
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
            width: 100%;
        }

        input[type="submit"]:hover {
            background: #00c6fb;
            transform: translateY(-3px); /* 按钮浮动效果 */
        }

        input[type="submit"]:active {
            transform: translateY(1px); /* 按钮点击下沉效果 */
        }

        .register-link {
            margin-top: 20px;
            text-align: center;
        }

        .register-link a {
            color: #4facfe;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
            color: #00c6fb;
        }

    </style>
</head>
<body>

<div class="container">
    <h1>Customer Registration</h1>

    <!-- 注册表单 -->
    <form action="register" method="post">
        <label for="customerName">Full Name:</label>
        <input type="text" id="customerName" name="customerName" required placeholder="Enter your full name">

        <label for="contactInfo">Contact Info:</label>
        <input type="tel" id="contactInfo" name="contactInfo" required placeholder="Enter your contact number">

        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required placeholder="Choose a username">

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required placeholder="Create a password">

        <label for="vip">
            <input type="checkbox" id="vip" name="vip"> Register as VIP
        </label>

        <input type="submit" value="Register">
    </form>

    <!-- 返回登录页的链接 -->
    <div class="register-link">
        <p>Already have an account? <a href="login_customer.jsp">Login here</a></p>
    </div>
</div>

</body>
</html>
