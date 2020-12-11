<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Reservations</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
	crossorigin="anonymous" />
<style>
body {
	background-color: #edf2f4 !important;
}

.navbar-brand {
	padding-left: 10px;
}

.nav-item:hover {
	font-weight: bold;
}

.navbar-brand, .nav-item a {
	color: white !important;
}
</style>
</head>
<body>
	<div class="nav-bar">
		<nav class="navbar navbar-expand-lg sticky-top navbar-light"
			style="background-color: #507e99">
			<a class="navbar-brand" href="home.jsp">Railway Booking System</a>
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
							href="home.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link text-right"
							href="schedule.jsp">Train Schedules</a></li>
						<li class="nav-item"><a class="nav-link text-right"
							href="reservations.jsp">Reservations</a></li>
						<li class="nav-item"><a class="nav-link text-right"
							href="contact.jsp">Contact Us</a></li>
					</ul>
					<div class="login-button">
						<a href="index.jsp" class="btn btn-outline-light">Login</a>
					</div>
				</div>
			</div>
		</nav>
	</div>
</body>
</html>