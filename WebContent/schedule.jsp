<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Train Schedules</title>
</head>
<body>
	<div class="form">
		<h1>Train Schedules</h1>
		<form action="RegistrationController" method="POST">
			<label for="origin">Origin</label> 
			<select id="origin" name="origin" required>
				<option value="none" selected disabled> Select An Origin </option>
				<%
				try{
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();		

					Statement stmt = con.createStatement();
					
					String stationNames = "SELECT name FROM station;";					
					ResultSet result = stmt.executeQuery(stationNames);
								
					while(result.next()){ 
						%><option value="<%=result.getString(1)%>"><%= result.getString(1) %></option><%
			        }
				%>
			</select> 
			
			<label for="dest">Destination</label> 
			<select id="dest" name="dest" required>
				<option value="none" selected disabled> Select An Destination </option>
				<%
					result = stmt.executeQuery(stationNames);
					
					while(result.next()){ 
						%><option value="<%=result.getString(1)%>"> <%= result.getString(1) %></option><%
			        }
					
					db.closeConnection(con);
				} catch (Exception e){
					System.out.print(e);
				}
				%>
			</select> 
			
			<label for="travelDate">Date of Travel</label> 
			<input type="date" name="travelDate" placeholder="[YYYY-MM-DD]" required>
			<button type="submit" formmethod="POST">Search</button>
		</form>
	</div>
</body>
</html>
