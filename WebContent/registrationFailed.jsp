<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration Error</title>
</head>
<body>
	<div class="form">
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
			<li>If you're an employee, your SSN should be inputed as XXX-XX-XXXX. Don't be afraid, we 
			don't know how to do bad things with an SSN so we won't do anything with yours.</li>
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