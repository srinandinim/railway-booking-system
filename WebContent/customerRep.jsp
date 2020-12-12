<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Admin Page</title>
</head>
<body>
<%
if (session.getAttribute("isEmployee") != null && ((boolean) session.getAttribute("isEmployee"))) {
	System.out.println("hello employee/admin");
%>
<!-- PUT EVERYTHING ADMINS/EMPLOYEES SHOULD SEE IN THIS IF STATEMENT -->
<h1>Hello Admin/Employee</h1>
<% }
else {
	System.out.println("Not an employee or admin"); %>
<h1>You are not an employee or admin.</h1>
<% } %>

</body>
</html>