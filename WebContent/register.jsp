<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Registration</title>
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

.login-form input[type="password"], .login-form input[type="text"],
	.login-form input[type="email"], .login-form input[type="date"] {
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
		<h1>Create New Account</h1>
		<form action="RegistrationController" method="POST">
			<input type="text" name="firstName" placeholder="First Name" required>
			<input type="text" name="lastName" placeholder="Last Name" required>
			<input type="email" name="email" placeholder="Email" required>
			<input type="date" name="dob"
				placeholder="Date of Birth [YYYY-MM-DD]" required> <input
				type="text" name="username" placeholder="Username" required>
			<input type="password" name="password" placeholder="Password"
				required> <input type="checkbox" id="disabled"
				name="disabled" value="Yes"> <label for="disabled">Check
				this box if you would like to self-identify as having a history of a
				disability.</label>
			<button type="submit" formmethod="POST">Register</button>
		</form>
	</div>

</body>
</html>