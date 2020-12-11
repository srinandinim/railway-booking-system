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
if (session.getAttribute("isAdmin") != null && ((boolean) session.getAttribute("isAdmin"))) {
	System.out.println("hello admin");
%>
<!-- PUT EVERYTHING ADMINS SHOULD SEE IN THIS IF STATEMENT -->
<h1>Hello Admin</h1>
<% }
else {
	System.out.println("Not an admin");
} %>

</body>
</html>