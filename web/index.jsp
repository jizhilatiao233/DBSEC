<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Shop Management System</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('./img/index.jpg') no-repeat center center fixed;
            background-size: cover; /* 保证背景图覆盖整个页面 */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #fff;
            position: relative;
            overflow: hidden;
        }

        .login-container {
            position: relative;
            z-index: 2;
            background: rgba(255, 255, 255, 0.85); /* 半透明背景使文字清晰可见 */
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2); /* 使容器更立体 */
            text-align: center;
            width: 100%;
            max-width: 500px;
            backdrop-filter: blur(15px); /* 背景模糊效果 */
            box-sizing: border-box;
        }

        h1 {
            margin-bottom: 20px;
            font-size: 3.2em;
            color: #f1c343;
            text-transform: uppercase;
            letter-spacing: 5px;
            font-weight: bold;
            text-shadow: 3px 3px 8px rgba(0, 0, 0, 0.3), 0 0 25px rgba(255, 255, 255, 0.7); / 文本阴影 /
            opacity: 0; / 初始时文字透明 /
            transform: translateY(30px); / 初始时下移 /
            animation: fadeInUp 2s ease-out forwards; / 应用动画 */
        }

        /* 文字动画效果：淡入 + 从下往上 */
        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        p {
            margin-bottom: 20px;
            font-size: 26px;
            color: #333;
            text-align: center;
            font-weight: bold;
        }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .button-group a {
            padding: 15px;
            border-radius: 12px;
            background-color: #4facfe; /* 按钮颜色 */
            color: white;
            text-decoration: none;
            font-weight: bold;
            text-align: center;
            font-size: 1.1em;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
        }

        .button-group a:hover {
            background-color: #265fdc;
            transform: translateY(-5px); /* 上升效果 */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .button-group a:active {
            transform: translateY(2px); /* 按钮点击时的下沉效果 */
        }

        /* 响应式设计 */
        @media (max-width: 600px) {
            .login-container {
                padding: 30px;
            }

            h1 {
                font-size: 2.2em;
            }

            .button-group a {
                font-size: 1em;
                padding: 12px;
            }
        }
    </style>
</head>
<body>

<div class="login-container">
    <h1>Welcome to the supermarket management system</h1>
    <div class="button-group">
        <a href="login_staff.jsp">staff</a>
    </div>
</div>

</body>
</html>
