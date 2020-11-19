<%@ page session="true"%>
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

.logoutButton {
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
		<h1>You entered an incorrect username and password combination.</h1>
		<button class="logoutButton" onclick="location.href='index.jsp';">Click
			here to go back</button>
	</div>

</body>
</html>