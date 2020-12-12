<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Train Schedule</title>
</head>
<body>
	<div class="form">
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