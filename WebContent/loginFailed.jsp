<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Failed</title>
</head>
<body>

	<div class="form">
		<h1>You entered an incorrect username and password combination.</h1>
		<button class="logoutButton" onclick="location.href='login.jsp';">Back</button>
	</div>

</body>
</html>