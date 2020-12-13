<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page
	import="java.io.*,java.util.*, java.sql.*, java.text.SimpleDateFormat, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Train Schedules</title>
<style>
th, td {
	padding: 5px;
}
</style>
</head>
<body>
	<div class="form">
		<h1>Train Schedules</h1>
		<form action="ScheduleController" method="POST">
			<label for="origin">Origin</label> <select name="origin" id="origin"
				required>
				<option value="" selected disabled>Select An Origin</option>
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
				<option value="" selected disabled>Select An Destination</option>
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
			ArrayList<Train> std = (ArrayList<Train>) request.getAttribute("valid-trains");
		%>
		<h3 class="form" style="text-align: center">Results</h3>
		<br>
		<p class="form" style="text-align: center">
			Origin:
			<%=request.getAttribute("origin")%>
		</p>
		<p class="form" style="text-align: center">
			Destination:
			<%=request.getAttribute("destination")%></p>
		<p class="form" style="text-align: center">
			Date of Travel:
			<%=request.getAttribute("travelDate")%></p>
		<br>
		<%
			if (std.size() != 0) {
		%>
		<table id="validTrains" border="1" width="900" align="center" border-spacing="40px">
			<tr style="text-align: center">
				<th><b>Train</b></th>
				<th onclick="sortTable(1)"><b>Departure Time</b></th>
				<th onclick="sortTable(2)"><b>Arrival Time</b></th>
				<th><b>Stops</b></th>
				<th onclick="sortTable(4)"><b>Duration</b></th>
				<th onclick="sortTable(5)"><b>Fare</b></th>
			</tr>
			<%
				for (Train s : std) {
			%>
			<tr style="text-align: center">
				<td><%=s.getTransitLine() + " #" + s.getTrainId()%></td>
				<td><%=s.getOrigin().substring(0, s.getOrigin().length() - 3)%></td>
				<td><%=s.getDestination().substring(0, s.getDestination().length() - 3)%></td>
				<td><%=s.getStops()%></td>
				<td><%=s.getDuration() + " min"%></td>
				<td><%="$" + s.getFare()%></td>
			</tr>
			<%}%>
		</table>
		<%
			} else {
		%>
		<p class="form">There are no valid train schedules with the listed
			origin and destination</p>
		<%
			}
		}
		%>
	</div>
	<script>
		function sortTable(n) {
			var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
			table = document.getElementById("validTrains");
			switching = true;
			dir = "asc";
			while (switching) {
				switching = false;
				rows = table.rows;
				for (i = 1; i < (rows.length - 1); i++) {
					shouldSwitch = false;
					x = rows[i].getElementsByTagName("TD")[n];
					y = rows[i + 1].getElementsByTagName("TD")[n];
					if (dir == "asc") {
						if (x.innerHTML.toLowerCase() > y.innerHTML
								.toLowerCase()) {
							shouldSwitch = true;
							break;
						}
					} else if (dir == "desc") {
						if (x.innerHTML.toLowerCase() < y.innerHTML
								.toLowerCase()) {
							shouldSwitch = true;
							break;
						}
					}
				}
				if (shouldSwitch) {
					rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
					switching = true;
					switchcount++;
				} else {
					if (switchcount == 0 && dir == "asc") {
						dir = "desc";
						switching = true;
					}
				}
			}
		}
	</script>
</body>
</html>
