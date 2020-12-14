<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Representative Train Schedule Error</title>
</head>
<body>
	<div class="form">
		<h3>There was an error with the data you inputed.</h3>
		Here are some things to look out for:
		<ul>
			<li>All datetimes should be inputed as "YYYY-MM-DD HH:MM:SS" (annoying, we know, but bear with us please we're just as underpaid as you)</li>
			<li>Departure datetime should come before arrival datetime (we're undergraduates barely surviving, we don't have the time to invent time travel)</li>
			<li>Your Origin Station ID and Destination Station ID should be integers referencing valid stations (no snarky comment for you here, just do it)</li>
			<li>The fare should be an integer (who in their right mind wants to read the written out version of a number???)</li>
			<li>Train ID should be an integer referencing a valid train (the numbers' meanings are mysterious to both you and us)</li>
			<li>Make sure your transit line and train ID are valid. If adding a new train schedule, this combination should be unique.
			If editing or deleting a train schedule, this combination should already exist in the train schedules table. (quite honestly,
			if it's come to this, I'm upset you didn't read the instructions on the page before)</li>
		</ul>

		If you hit the back button, you can return to the previous page
		pre-populated with your previous data.

	</div>
	<button class="logoutButton" onclick="location.href='customerRep.jsp';">Click
		Here to Return to a Customer Representative Page</button>
</body>
</html>