<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Login</title>
</head>
<body>
	<div class="form">
		<br>
		<h4 class="center"> Employee Login </h4>
		<br>
		<form action="ELoginController" method="POST">
			<input type="text" name="username" placeholder="Username" required>
			<input type="password" name="password" placeholder="Password"
				required>
			<button type="submit" formmethod="POST">Log In</button>
		</form>
	</div>
</body>
</html>