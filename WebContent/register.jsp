<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Registration</title>
</head>
<body>
	<div class="form">
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
				name="disabled" value="Yes"> <label
				class="indented-checkbox-text" for="disabled">I would like
				to self-identify as having a disability or history/record of having
				a disability.</label>
			<h5> </h2>
			<button type="submit" formmethod="POST">Register</button>
		</form>
	</div>

</body>
</html>