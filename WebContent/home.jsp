<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
.body {
	background-color: #7397AD;
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
.jumbotron {
    background-image: url("resources/home-train.jpg");
    background-size: cover;
    width: 100%;
    height: 500px;
    margin-top:-100px;
    background-position: center center;
}
</style>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
	<div class="nav-bar">
		<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #507E99;">
			<a class="navbar-brand" href="home.jsp">Railway Booking System</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
	        <div class="collapse navbar-collapse" id="navbarNav">
	            <div class="container d-flex flex-column flex-md-row justify-content-between">
	                <ul class="navbar-nav">
	                    <li class="nav-item">
	                        <a class="nav-link text-right" href="home.jsp">Home</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link text-right" href="index.jsp">Train Schedules</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link text-right" href="">Reservations</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link text-right" href="">Contact Us</a>
	                    </li>
	                </ul>
	                <div class="start-button">
	                    <a href="" class="btn btn-outline-light">Login</a>
	                </div>
	            </div>
	        </div>
		</nav>
	</div>
	
	<!-- JUMBOTRON -->
    <div class="jumbotron text-center"></div>
</body>
</html>