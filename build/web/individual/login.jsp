<!DOCTYPE html>
<%@page import="com.owen.web.Constant"%>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Login</title>
	<link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/login.css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="container">
		<header>
			<div class="wrapper">
				<h1><span>OWEN</span> <span>Individual</span></h1>
			</div>
		</header>
		<div class="main">
			<div class="login-box">
				<img src="<%=Constant.WEB_ASSETS%>images/id_pwd_top_bg.png" alt="Border">
				<div class="login-form">
					<h2>LOGIN</h2>
					<button class="register-symbol"><span>&#x270E;</span></button>
                    <%= request.getParameter("msg") != null ? request.getParameter("msg") : "" %>
					<form method="post" action="login-check.jsp">
						<label for="username">Username</label>
						<input type="email" name="username" id="username" required>
						<label for="password">Password</label>
						<input type="password" name="password" id="password" required>
						<button type="submit">GO</button>
					</form>
                    
                    <div class="caps-warning"> 
                        <span><span>!</span> Caps Lock is on.</span>
                    </div>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
	<script src="<%=Constant.WEB_ASSETS%>js/login.js"></script>
</body>
</html>