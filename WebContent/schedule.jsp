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
		<form action="ScheduleController" method="POST">
			<label for="origin">Origin</label> <select id="origin" name="origin"
				required>
				<option value="none" selected disabled>Select An Origin</option>
				<%
					try {
					ApplicationDB db = new ApplicationDB();
					Connection con = db.getConnection();

					Statement stmt = con.createStatement();

					String stationNames = "SELECT station_id, name FROM station ORDER BY name;";
					ResultSet result = stmt.executeQuery(stationNames);

					while (result.next()) {
				%><option value="<%=result.getString(1)%>"><%=result.getString(2)%></option>
				<%
					}
				%>
			</select> <label for="dest">Destination</label> <select id="dest" name="dest"
				required>
				<option value="none" selected disabled>Select An
					Destination</option>
				<%
					result = stmt.executeQuery(stationNames);

				while (result.next()) {
				%><option value="<%=result.getString(1)%>">
					<%=result.getString(2)%></option>
				<%
					}

				db.closeConnection(con);
				} catch (Exception e) {
				System.out.print(e);
				}
				%>
			</select> <label for="travelDate">Date of Travel</label> <input type="date"
				name="travelDate" placeholder="[YYYY-MM-DD]" required>
			<button type="submit">Search</button>
			<br> <br>
		</form>
	</div>
	<div>
		<%
			if (request.getAttribute("valid-trains") != null) {
			ArrayList<Train> std = (ArrayList<Train>) request.getAttribute("valid-trains"); %>
			<h3 class="form" style="text-align: center">Results</h3>
			<br>
			<p class="form" style="text-align: center">Origin: <%=request.getAttribute("origin")%> </p>
			<p class="form" style="text-align: center">Destination: <%=request.getAttribute("destination")%></p>
			<br>
			<% if (std.size() != 0) {
		%>
		<table border="1" width="800" align="center">
			<tr style="text-align: center">
				<th><b>Train</b></th>
				<th><b>Departure Time</b></th>
				<th><b>Arrival Time</b></th>
				<th><b>Stops</b></th>
				<th><b>Fare</b></th>
			</tr>
			<%
				for (Train s : std) {
			%>
			<tr style="text-align: center">
				<td><%=s.getTransitLine() + " #" + s.getTrainId()%></td>
				<td><%=s.getOrigin().substring(0, s.getOrigin().length() - 3) %></td>
				<td><%=s.getDestination().substring(0, s.getDestination().length() - 3) %></td>
				<td><%=s.getStops() %></td>
				<td><%="$" + s.getFare() %></td>
			</tr>
			<%}%>
		</table>
		<%
			} else { %>
				<p class="form">There are no valid train schedules with the listed origin and destination </p>
			<% }
		}
		%>
	</div>
</body>
</html>
