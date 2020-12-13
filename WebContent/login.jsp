<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
</head>
<body>

	<div class="form">
		<br>
		<h4 class="center">Customer Login</h4>
		<p class="center">To make a new account, click register.</p>
		<form action="LoginController" method="POST">
			<input type="text" name="username" placeholder="Username" required>
			<input type="password" name="password" placeholder="Password"
				required>
			<button type="submit" formmethod="POST">Log In</button>
		</form>
		<br>
		<button onclick="location.href='register.jsp';">Register</button>
		<br> <br>
		<button onclick="location.href='employeelogin.jsp';">Employee
			Log-In</button>
	</div>

</body>
</html>