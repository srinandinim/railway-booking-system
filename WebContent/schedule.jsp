<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page
	import="java.io.*,java.util.*, java.sql.*, java.text.SimpleDateFormat, java.util.Date, java.text.DecimalFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Train Schedules</title>
<style>
table {
	width: 70%
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
				%><option value="<%=result.getString(1)%>"><!-- Station Name: -->
					<%=result.getString(2)%><%-- , Station ID: <%=result.getString(1)%> --%></option>
				<%
					}
				%>
			</select> <label for="dest">Destination</label> <select id="dest" name="dest"
				required>
				<option value="" selected disabled>Select An Destination</option>
				<%
					result = stmt.executeQuery(stationNames);

				while (result.next()) {
				%><option value="<%=result.getString(1)%>"><!-- Station Name: -->
					<%=result.getString(2)%><%-- , Station ID: <%=result.getString(1)%> --%></option>
				<%
					}

				db.closeConnection(con);
				} catch (Exception e) {
				System.out.print(e);
				}
				%>
			</select> <label for="trip-type">Trip Type</label> <select id="trip-type"
				name="trip-type" required>
				<option value="" selected disabled>Select Trip Type</option>
				<option value="one-way">One Way</option>
				<option value="round-trip">Round Trip</option>
			</select> <label for="travelDate">Date of Departure</label> <input type="date"
				name="travelDate" placeholder="[YYYY-MM-DD]" required> <label
				for="arrivalDate">Date of Return</label> <label for="arrivalDate">
				Note: You may leave this value blank if it is a one-way trip or if
				the date of departure is the same as the date of return. </label> <input
				type="date" name="arrivalDate" placeholder="[YYYY-MM-DD]">
			<button type="submit">Search</button>
			<br> <br>
		</form>
	</div>

	<div>
		<%
			ArrayList<Train> orgDestStd = new ArrayList<Train>();
		if (request.getAttribute("org-dest-trains") != null) {
			orgDestStd = (ArrayList<Train>) request.getAttribute("org-dest-trains");
		%>
		<h3 class="form" style="text-align: center">Results</h3>
		<br>
		<p class="form" style="text-align: center; font-weight:650;">
			Trip 1 </p>
		<p class="form" style="text-align: center">
			Origin:
			<%=request.getAttribute("origin")%>
		</p>
		<p class="form" style="text-align: center">
			Destination:
			<%=request.getAttribute("destination")%></p>
		<p class="form" id="firstDate" style="text-align: center">
			Date of Travel:
			<%
			String travelDate = request.getAttribute("travelDate").toString();
		Date date = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(travelDate);
		String formatDate = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH).format(date);
		%>
			<%=formatDate%></p>
		<br>
		<%
			if (orgDestStd.size() != 0) {
		%>
		<table id="validTrainsOD" border="1" width="900" align="center"
			border-spacing="40px">
			<tr class="tableHeader" style="text-align: center">
				<th><b>Option</b></th>
				<th><b>Train</b></th>
				<th onclick="sortTable(2, 'validTrainsOD')"><b>Departure
						Time</b></th>
				<th onclick="sortTable(3, 'validTrainsOD')"><b>Arrival Time</b></th>
				<th><b>Stops</b></th>
				<th onclick="sortTable(5, 'validTrainsOD')"><b>Duration</b></th>
				<th onclick="sortTable(6, 'validTrainsOD')"><b>Fare</b></th>
			</tr>
			<%
				for (int i = 0; i < orgDestStd.size(); i++) {
				Train s = orgDestStd.get(i);
			%>
			<tr style="text-align: center">
				<td><%=(i + 1)%></td>
				<td><%=s.getTransitLine() + " #" + s.getTrainId()%></td>
				<td><%=s.getOriginDT().substring(0, s.getOriginDT().length() - 3).split(" ")[1]%></td>
				<td><%=s.getDestinationDT().substring(0, s.getDestinationDT().length() - 3).split(" ")[1]%></td>
				<%
					String stops = "N/A";
				if (s.getStops() != null && !s.getStops().equals("")) {
					stops = s.getStops();
				}
				%>
				<td><%=stops%></td>
				<td><%=s.getDuration() + " min"%></td>
				<%
					DecimalFormat df = new DecimalFormat("#.00");
				String display = df.format(s.getFare());
				%>
				<td><%="$" + display%></td>
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

	<div>
		<%
			ArrayList<Train> destOrgStd = new ArrayList<Train>();
		if (request.getAttribute("dest-org-trains") != null) {
			destOrgStd = (ArrayList<Train>) request.getAttribute("dest-org-trains");
		%>
		<br>
		<p class="form" style="text-align: center; font-weight:650;">
			Trip 2 </p>
		<p class="form" style="text-align: center">
			Origin:
			<%=request.getAttribute("destination")%>
		</p>
		<p class="form" style="text-align: center">
			Destination:
			<%=request.getAttribute("origin")%></p>
		<p class="form" id="secondDate" style="text-align: center">
			Date of Travel:
			<%
			String arrivalDate = request.getAttribute("arrivalDate").toString();
		Date arrDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(arrivalDate);
		String arrFormatDate = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH).format(arrDate);
		%>
			<%=arrFormatDate%></p>
		<br>
		<%
			if (destOrgStd.size() != 0) {
		%>
		<table id="validTrainsDO" border="1" width="900" align="center"
			border-spacing="40px">
			<tr class="tableHeader" style="text-align: center">
				<th><b>Option</b></th>
				<th><b>Train</b></th>
				<th onclick="sortTable(2, 'validTrainsDO')"><b>Departure
						Time</b></th>
				<th onclick="sortTable(3, 'validTrainsDO')"><b>Arrival Time</b></th>
				<th><b>Stops</b></th>
				<th onclick="sortTable(5, 'validTrainsDO')"><b>Duration</b></th>
				<th onclick="sortTable(6, 'validTrainsDO')"><b>Fare</b></th>
			</tr>
			<%
				for (int i = 0; i < destOrgStd.size(); i++) {
				Train s = destOrgStd.get(i);
			%>
			<tr style="text-align: center">
				<td><%=(i + 1)%></td>
				<td><%=s.getTransitLine() + " #" + s.getTrainId()%></td>
				<td><%=s.getOriginDT().substring(0, s.getOriginDT().length() - 3).split(" ")[1]%></td>
				<td><%=s.getDestinationDT().substring(0, s.getDestinationDT().length() - 3).split(" ")[1]%></td>
				<%
					String stops = "N/A";
				if (s.getStops() != null && !s.getStops().equals("")) {
					stops = s.getStops();
				}
				%>
				<td><%=stops%></td>
				<td><%=s.getDuration() + " min"%></td>
				<%
					DecimalFormat df = new DecimalFormat("#.00");
				String display = df.format(s.getFare());
				%>
				<td><%="$" + display%></td>
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

	<div class="form">
		<form action="ReservationsController" method="POST">
			<%
				if ((request.getAttribute("org-dest-trains") != null && orgDestStd.size() != 0)
					|| (request.getAttribute("dest-org-trains") != null && destOrgStd.size() != 0)) {
			%>
			<br>
			<h3 class="form" style="text-align: center">Reserve</h3>
			<br>
			<%
				if (orgDestStd.size() > 0) {
			%><label for="origin-option">Trip
				1 Option</label> <select id="origin-option" name="origin-option" required>
				<option value="" selected disabled>Select Trip 1 Option</option>
				<%
					for (int i = 0; i < orgDestStd.size(); i++) {
				%>
				<option value="<%=orgDestStd.get(i).toString()%>"><%=i + 1%></option>
				<%}%>
			</select>
			<%}%>
			<br>
			<%
				if (destOrgStd.size() > 0) {
			%><label for="dest-option">Trip
				2 Option</label> <select id="dest-option" name="dest-option" required>
				<option value="" selected disabled>Select Trip 2 Option</option>
				<%
					for (int i = 0; i < destOrgStd.size(); i++) {
				%>
				<option value="<%=destOrgStd.get(i).toString()%>"><%=i + 1%></option>
				<%}%>
			</select>

			<%}%>
			<button id="reserve" type="submit">Reserve</button>
			<br>
			<%
				}
			%>
		</form>
	</div>
	<br>
	<br>
	<script>
	
		var destinationID = document.getElementById('dest-option');
		if (destinationID != null)
			destinationID.addEventListener('change', verifySelections, false);
				
		function verifySelections(){
			
			console.log("HI");
			
			var trip1option = document.getElementById("origin-option");
			trip1option = trip1option.options[trip1option.selectedIndex].text; // gets the number selected
			console.log(trip1option);
			var trip2option = document.getElementById('dest-option');
			trip2option = trip2option.options[trip2option.selectedIndex].text
			
			if (trip1option === "Select Trip 1 Option"){
				alert("ERROR: Please select a Trip 1 option first");
				document.getElementById('dest-option').value = "";
				return;
			}
			
			var table1 = document.getElementById('validTrainsOD');
			var table2 = document.getElementById('validTrainsDO');
			
			var trip1ArrTime = table1.getElementsByTagName('tr')[trip1option].getElementsByTagName('td')[3].innerText;
			var trip2DeptTime = table2.getElementsByTagName('tr')[trip2option].getElementsByTagName('td')[2].innerText;
			
			var date1 = (document.getElementById("firstDate").innerText).split(" ")[3];
			var date2 = (document.getElementById("secondDate").innerText).split(" ")[3];
			
			var fullDate1 = new Date(date1+" "+trip1ArrTime);
			var fullDate2 = new Date(date2+" "+trip2DeptTime);
			
			if (fullDate1 > fullDate2){
				document.getElementById('dest-option').value = "";
				alert("ERROR: Please make sure the return trip is after the first trip");
			}
			
		}
		
		highlight_rowOD();
		function highlight_rowOD() {
			var table = document.getElementById('validTrainsOD');
			var cells = table.getElementsByTagName('td');

			for (var i = 0; i < cells.length; i++) {
				var cell = cells[i];
				cell.onclick = function() {
					var rowId = this.parentNode.rowIndex;

					var rowsNotSelected = table.getElementsByTagName('tr');
					for (var row = 0; row < rowsNotSelected.length; row++) {
						rowsNotSelected[row].style.backgroundColor = "";
					}
					var rowSelected = table.getElementsByTagName('tr')[rowId];
					rowSelected.style.backgroundColor = "#e6e9ed";
				}
			}
		}

		highlight_rowDO();
		function highlight_rowDO() {
			var table = document.getElementById('validTrainsDO');
			var cells = table.getElementsByTagName('td');

			for (var i = 0; i < cells.length; i++) {
				var cell = cells[i];
				cell.onclick = function() {
					var rowId = this.parentNode.rowIndex;

					var rowsNotSelected = table.getElementsByTagName('tr');
					for (var row = 0; row < rowsNotSelected.length; row++) {
						rowsNotSelected[row].style.backgroundColor = "";
					}
					var rowSelected = table.getElementsByTagName('tr')[rowId];
					rowSelected.style.backgroundColor = "#e6e9ed";
				}
			}
		}
	</script>

	<script>
		function sortTable(n, tblename) {
			var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
			table = document.getElementById(tblename);
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
