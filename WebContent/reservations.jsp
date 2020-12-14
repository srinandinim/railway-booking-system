<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Should move to css file later -->
<style>
table, th, tr, td {
	border: 1px solid black;
	border-right: 1px solid black;
	border-collapse: collapse;
	margin-left: auto;
	margin-right: auto;
}
.center {
	text-align: center;
	list-style-position: inside;
	margin-left: auto;
	margin-right: auto;
}
</style>
<title>Reservations</title>
</head>
<body>

	<%
		if (session.getAttribute("isLoggedIn") != null && ((boolean) session.getAttribute("isLoggedIn"))) {
				System.out.println("hello isLoggedIn");
	%>
	
	
		<div class="center" id="resTable">
		<h4>Your Reservations</h4>
		<table>
			<tr>
				<th>Reservation Number</th>
				<th>Fare Type</th>
				<th>Date made</th>
				<th>Total Fare</th>
				<th>Origin</th> <!-- Station name-->
				<th>Origin Departure Time</th>
				<th>Destination</th> <!-- Station name-->
				<th>Destination Arrival Time</th>
				<th>Train</th> <!-- include train line and id/number -->
			</tr>
			<%
			
			String username = "";
			
			if (session.getAttribute("username") != null)
				username = (String) session.getAttribute("username");
			
			System.out.println(username);
			
			try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
				
				
				String reservationQuery = "SELECT res.reservation_number, res.fare_type, res.date_made, res.total_fare, t1.name, res.reservation_origin_datetime, t2.name, res.reservation_destination_datetime, res.transit_line, res.train_id FROM reservation res LEFT JOIN station AS t1 ON res.reservation_origin = t1.station_id LEFT JOIN station AS t2 ON res.reservation_destination = t2.station_id WHERE res.customer_username = \""+username+"\";";
								
				ResultSet customerInfoResult = stmt.executeQuery(reservationQuery);
				while (customerInfoResult.next()) {
			%>
					<tr>
						<td><%=customerInfoResult.getString(1)%></td>
						<td><%=customerInfoResult.getString(2)%></td>
						<td><%=customerInfoResult.getString(3)%></td>
						<td><%="$"+customerInfoResult.getDouble(4)%></td>
						<td><%=customerInfoResult.getString(5)%></td>
						<td><%=customerInfoResult.getString(6)%></td>
						<td><%=customerInfoResult.getString(7)%></td>
						<td><%=customerInfoResult.getString(8)%></td>
						<td><%=customerInfoResult.getString(9)+" #"+ customerInfoResult.getString(10)%></td>
					</tr>
			<%
				}
			db.closeConnection(con);
			} catch (Exception e) {
			System.out.print(e);
			}
			%>
		</table>
		</div>
		<br>
	
	
		<div class="center" id="deleteRes">
			<h4>Delete an existing Reservation (make sure Reservation Number matches)</h4>
			<form action="DeleteReservationController" method="POST">
				<input type="number" name="resNum" required>
				<button type="submit" formmethod="POST">Delete</button>
			</form>
		</div>
		<br>
	
	
	
	<%
		} else{
			System.out.println("Please Log in to make reservation");
			%> <br> <h6 class="form" style="text-align:center"> Please login to make a reservation. </h6> 
			<br>
	<% } %>
	
	
</body>
</html>