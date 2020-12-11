<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8" />
<title>Train Schedule</title>
<style>
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
	<div class="login-form">
		<h1>Plan Your Trip</h1>
		<form action="RegistrationController" method="POST">
			<label for="origin">Origin</label> <select id="origin" name="origin"
				required>
				<!-- FILL IN LATER -->
			</select> <label for="dest">Destination</label> <select id="dest" name="dest"
				required>
				<!-- FILL IN LATER -->
			</select> <label for="travelDate">Date of Travel</label> <input type="date"
				name="travelDate" placeholder="[YYYY-MM-DD]" required>
			<button type="submit" formmethod="POST">Search</button>
		</form>
	</div>
</body>
</html>