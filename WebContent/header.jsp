<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
	crossorigin="anonymous" />
<link rel="stylesheet" href="stylesheet.css">
<style>
</style>
</head>
<body>
	<div class="nav-bar">
		<nav class="navbar navbar-expand-lg sticky-top navbar-light"
			style="background-color: #507e99">
			<a class="navbar-brand" href="index.jsp">Railway Booking System</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<div
					class="container d-flex flex-column flex-md-row justify-content-between">
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link text-right"
							href="index.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link text-right"
							href="schedule.jsp">Train Schedules</a></li>
						<li class="nav-item"><a class="nav-link text-right"
							href="reservations.jsp">Reservations</a></li>
						<li class="nav-item"><a class="nav-link text-right"
							href="contact.jsp">Contact Us</a></li>
						<% 
						String username = (String)session.getAttribute("username");
						if (username != null && username.equals("admin")) {
						%>
						<li class="nav-item"><a class="nav-link text-right"
							href="admin.jsp">Admin Page</a></li>
						<% } %>
					</ul>
					<% if ((String)session.getAttribute("name") == null) { %>
					<div class="login-button">
						<a href="login.jsp" class="btn btn-outline-light">Login</a>
					</div>
					<% } else { %>
					<div class="login-button">
						<a href="logout.jsp" class="btn btn-outline-light">Log Out</a>
					</div>
					<%
					} %>
				</div>
			</div>
		</nav>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- <script src="https://unpkg.com/@popperjs/core@2"></script> -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
		crossorigin="anonymous"></script>
</body>
</html>