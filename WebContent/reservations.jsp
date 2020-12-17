<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page
	import="java.io.*,java.util.*,java.sql.*,java.text.SimpleDateFormat, java.util.Date, java.text.DecimalFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
.table {
	width: 90%;
}
.table th, .table td {
	padding: 5px;
}
table, th, tr, td {
	border: 1px solid black;
	border-right: 1px solid black;
	border-collapse: collapse;
	margin-left: auto;
	margin-right: auto;
}
#myTable tr.header {
	background-color: #38586b !important;
	color: #edf2f4 !important
}
#myTable tr:hover {
	background-color: rgba(0, 162, 255, 0.263);
}
</style>
<title>Reservations</title>
</head>
<body>

	<%
		if (session.getAttribute("isLoggedIn") != null && ((boolean) session.getAttribute("isLoggedIn"))) {
	%>
	<div class="center" id="resTable" style="overflow-x:auto;">
		<br>
		<h4>Future Reservations</h4>
		<br>
		<table class="table table-bordered table-striped" id="myTable">
			<tr class="header">
				<th>Reservation Number</th>
				<th>Fare Type</th>
				<th>Date Reserved</th>
				<th>Total Fare</th>
				<th>Origin</th>
				<th>Origin Departure Date & Time</th>
				<th>Destination</th>
				<th>Destination Arrival Date & Time</th>
				<th>Train</th>
			</tr>
			<%
			
			String username = "";
			
			if (session.getAttribute("username") != null)
				username = (String) session.getAttribute("username");
						
			try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
				
				String reservationQuery = "SELECT res.reservation_number, res.fare_type, res.date_made, res.total_fare, t1.name, res.reservation_origin_datetime, t2.name, res.reservation_destination_datetime, res.transit_line, res.train_id FROM reservation res LEFT JOIN station AS t1 ON res.reservation_origin = t1.station_id LEFT JOIN station AS t2 ON res.reservation_destination = t2.station_id WHERE res.customer_username = \""+username+"\" and res.reservation_origin_datetime >= NOW();";
								
				ResultSet customerInfoResult = stmt.executeQuery(reservationQuery);
				while (customerInfoResult.next()) {
					String fareType = " "; // to change the - to a space
					if (customerInfoResult.getString(2).equals("one-way")){
						fareType = "One Way";
					} else {
						fareType = "Round Trip";
					}
				%>
				<tr>
					<td><%=customerInfoResult.getString(1)%></td>
					<td><%=fareType%></td>
					<%
					String reserveDateStr = customerInfoResult.getString(3);    
					Date reserveDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(reserveDateStr);
					String formatReserveDate = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH).format(reserveDate);
					%>
					<td><%=formatReserveDate%></td>
					<%
					DecimalFormat df = new DecimalFormat("#.00");
					String display = df.format(customerInfoResult.getDouble(4));
					%>
					<td><%="$"+display%></td>
					<td><%=customerInfoResult.getString(5)%></td>
					<%
					String departureStr = customerInfoResult.getString(6).split(" ")[0];    
					Date departureDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(departureStr);
					String formatDeparture = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH).format(departureDate);
					String timeDeparture = customerInfoResult.getString(6).split(" ")[1];
					formatDeparture += " " + timeDeparture.substring(0, timeDeparture.length()-3);
					%>
					<td><%=formatDeparture %></td>
					<td><%=customerInfoResult.getString(7)%></td>
					<%
					String arrivalStr = customerInfoResult.getString(8).split(" ")[0];    
					Date arrivalDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(arrivalStr);
					String formatArrival = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH).format(arrivalDate);
					String timeArrival = customerInfoResult.getString(8).split(" ")[1];
					formatArrival += " " + timeArrival.substring(0, timeArrival.length()-3);
					%>
					<td><%=formatArrival%></td>
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
	
	<div class="center" id="resTable" style="overflow-x:auto;">
		<h4>Past Reservations</h4>
		<br>
		<table class="table table-bordered table-striped" id="myTable">
			<tr class="header">
				<th>Reservation Number</th>
				<th>Fare Type</th>
				<th>Date Reserved</th>
				<th>Total Fare</th>
				<th>Origin</th>
				<th>Origin Departure Date & Time</th>
				<th>Destination</th>
				<th>Destination Arrival Date & Time</th>
				<th>Train</th>
			</tr>
			<%
				
			// username should carry from above
			try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
				
				
				String reservationQuery = "SELECT res.reservation_number, res.fare_type, res.date_made, res.total_fare, t1.name, res.reservation_origin_datetime, t2.name, res.reservation_destination_datetime, res.transit_line, res.train_id FROM reservation res LEFT JOIN station AS t1 ON res.reservation_origin = t1.station_id LEFT JOIN station AS t2 ON res.reservation_destination = t2.station_id WHERE res.customer_username = \""+username+"\" and res.reservation_origin_datetime < NOW();";
								
				ResultSet customerInfoResult = stmt.executeQuery(reservationQuery);
				while (customerInfoResult.next()) {
					String fareType = " "; // to change the - to a space
					if (customerInfoResult.getString(2).equals("one-way")){
						fareType = "One Way";
					} else {
						fareType = "Round Trip";
					}
				%>
				<tr>
					<td><%=customerInfoResult.getString(1)%></td>
					<td><%=fareType%></td>
					<%
					String reserveDateStr = customerInfoResult.getString(3);    
					Date reserveDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(reserveDateStr);
					String formatReserveDate = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH).format(reserveDate);
					%>
					<td><%=formatReserveDate%></td>
					<%
					DecimalFormat df = new DecimalFormat("#.00");
					String display = df.format(customerInfoResult.getDouble(4));
					%>
					<td><%="$"+display%></td>
					<td><%=customerInfoResult.getString(5)%></td>
					<%
					String departureStr = customerInfoResult.getString(6).split(" ")[0];    
					Date departureDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(departureStr);
					String formatDeparture = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH).format(departureDate);
					String timeDeparture = customerInfoResult.getString(6).split(" ")[1];
					formatDeparture += " " + timeDeparture.substring(0, timeDeparture.length()-3);
					%>
					<td><%=formatDeparture %></td>
					<td><%=customerInfoResult.getString(7)%></td>
					<%
					String arrivalStr = customerInfoResult.getString(8).split(" ")[0];    
					Date arrivalDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(arrivalStr);
					String formatArrival = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH).format(arrivalDate);
					String timeArrival = customerInfoResult.getString(8).split(" ")[1];
					formatArrival += " " + timeArrival.substring(0, timeArrival.length()-3);
					%>
					<td><%=formatArrival%></td>
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
		<h4>Delete Existing Reservation</h4>
		<p>Please enter reservation number.</p>
		<form class="form" action="DeleteReservationController" method="POST">
			<input type="number" name="resNum" required>
			<button type="submit" formmethod="POST">Delete</button>
		</form>
	</div>
	<br>


	<% } else{ %>
			<br>
			<h6 class="form" style="text-align: center">Please login to make a reservation or view your reservations.</h6>
			<br>
	<% } %>


</body>
</html>