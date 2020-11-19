<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
     // for checking the session is available or not, if not available it will throw exception, "Session already invalidated."
	if (session != null) {
		session.invalidate();
	 	response.sendRedirect("index.jsp");
	}
    %>
</body>
</html>