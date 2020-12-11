<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Train Schedule</title>
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

.login-form {
	width: 300px;
	margin: 0 auto;
	font-family: Tahoma, Geneva, sans-serif;
	color: #38586b;
}

.login-form h1 {
	text-align: center;
	color: #38586b;
	font-size: 30px;
	font-weight: 500;
	padding: 20px 0 20px 0;
}

.login-form select[id="origin"], .login-form select[id="dest"],
	.login-form input[type="date"] {
	width: 100%;
	padding: 15px;
	border: 1px solid #dddddd;
	margin-bottom: 15px;
	box-sizing: border-box;
}

.login-form button[type="submit"] {
	width: 100%;
	padding: 15px;
	background-color: #38586b;
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
	
	<div class="login-form">
		<h1>Plan Your Trip</h1>
		<form action="RegistrationController" method="POST">
			<label for="origin">Origin</label>
			<select id="origin" name="origin" required>
			  <!-- FILL IN LATER -->
			</select>
			<label for="dest">Destination</label>
			<select id="dest" name="dest" required>
			  <!-- FILL IN LATER -->
			</select>
			<label for="travelDate">Date of Travel</label>
			<input type="date" name="travelDate" placeholder="[YYYY-MM-DD]" required>
			<button type="submit" formmethod="POST">Search</button>
		</form>
	</div>
</body>
</html>