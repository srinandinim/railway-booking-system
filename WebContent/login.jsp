<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
</head>
<body>
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			Statement stmt = con.createStatement();

			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			String correctPassword = "SELECT password FROM customer WHERE username=" + "\'" + username + "\'" + " LIMIT 1";

			ResultSet result = stmt.executeQuery(correctPassword);
			boolean isValid = result.next();
			if(!isValid || !password.equals(result.getString("password"))){
				out.print("Username or password is incorrect.");
			}
			else {
				out.print("You have been logged in!");
				db.closeConnection(con);
				response.sendRedirect("loggedIn.jsp");
			}
			db.closeConnection(con);
		}
			
		catch (Exception e) {
			out.print(e);
		}%>


</body>
</html>