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
		<h3>There was an error with the data you inputed.</h3>
		Here are some things to look out for:
		<ul>
			<li>Your first name, last name, username, and password (be
				realistic no one's hacking this you don't need a complex password)
				should all be within 50 characters</li>
			<li>Your email should be within 200 characters</li>
			<li>Your birthday should be inputed as YYYY-MM-DD and must be a
				valid birthday (we went through the hassle of checking)</li>
			<li>The YYYY, MM, and DD mentioned above are numbers (Do we
				seriously have to mention this?)</li>
			<li>You must be born after 1890 to ride with us. Train unsafe
				for some 19th century folks.</li>
			<li>If all else fails, your username has already been taken. Be
				more original.</li>
		</ul>

		If you hit the back button, you can return to a registration page
		pre-populated with your previous data.

	</div>
	<button class="logoutButton" onclick="location.href='register.jsp';">Click
		Here to Return to a New Registration Page</button>
</body>
</html>