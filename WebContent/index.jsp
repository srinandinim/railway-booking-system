<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Railway Booking System</title>
<style>
.login-form {
	width: 300px;
	margin: 0 auto;
	font-family: Tahoma, Geneva, sans-serif;
}

.login-form h1 {
	text-align: center;
	color: #4d4d4d;
	font-size: 24px;
	padding: 20px 0 20px 0;
}

.login-form input[type="password"], .login-form input[type="text"] {
	width: 100%;
	padding: 15px;
	border: 1px solid #dddddd;
	margin-bottom: 15px;
	box-sizing: border-box;
}

.login-form button[type="submit"] {
	width: 100%;
	padding: 15px;
	background-color: #535b63;
	border: 0;
	box-sizing: border-box;
	cursor: pointer;
	font-weight: bold;
	font-size: 16px;
	color: #ffffff;
}

.registerButton {
	width: 100%;
	padding: 15px;
	background-color: #535b63;
	border: 0;
	box-sizing: border-box;
	cursor: pointer;
	font-weight: bold;
	font-size: 16px;
	color: #ffffff;
}
</style>
</head>
<body>

	<div class="login-form">
		<h1>Welcome!</h1>
		<p>Please log in if you are a returning user.</p>
		<p>To make a new account, click register.</p>
		<form action="LoginController" method="POST">
			<input type="text" name="username" placeholder="Username" required>
			<input type="password" name="password" placeholder="Password"
				required>
			<button type="submit" formmethod="POST">Log In</button>
		</form>
		<br>
		<button class="registerButton" onclick="location.href='register.jsp';">Register</button>
	</div>

</body>
</html>