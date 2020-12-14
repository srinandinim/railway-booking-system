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
			if (orgDestStd.size() != 0) {
		%>
		<table id="validTrainsOD" border="1" width="900" align="center"
			border-spacing="40px">
			<tr style="text-align: center">
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
				<td><%=(i+1)%></td>
				<td><%=s.getTransitLine() + " #" + s.getTrainId()%></td>
				<td><%=s.getOriginDT().substring(0, s.getOriginDT().length() - 3).split(" ")[1]%></td>
				<td><%=s.getDestinationDT().substring(0, s.getDestinationDT().length() - 3).split(" ")[1]%></td>
				<td><%=s.getStops()%></td>
				<td><%=s.getDuration() + " min"%></td>
				<td><%="$" + s.getFare()%></td>
				<%-- <td><input type="radio" name="originReservation" value='<%=i%>' /></td> --%>
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
		<p class="form" style="text-align: center">
			Origin:
			<%=request.getAttribute("destination")%>
		</p>
		<p class="form" style="text-align: center">
			Destination:
			<%=request.getAttribute("origin")%></p>
		<p class="form" style="text-align: center">
			Date of Travel:
			<%=request.getAttribute("arrivalDate")%></p>
		<br>
		<%
			if (destOrgStd.size() != 0) {
		%>
		<table id="validTrainsDO" border="1" width="900" align="center"
			border-spacing="40px">
			<tr style="text-align: center">
				<th><b>Option</b></th>
				<th><b>Train</b></th>
				<th onclick="sortTable(2, 'validTrainsDO')"><b>Departure
						Time</b></th>
				<th onclick="sortTable(3, 'validTrainsDO')"><b>Arrival Time</b></th>
				<th><b>Stops</b></th>
				<th onclick="sortTable(5, 'validTrainsDO')"><b>Duration</b></th>
				<th onclick="sortTable(6, 'validTrainsDO')"><b>Fare</b></th>
				<!-- <th><b>Reserve</b></th> -->
			</tr>
			<%
				for (int i = 0; i < destOrgStd.size(); i++) {
					Train s = destOrgStd.get(i);
			%>
			<tr style="text-align: center">
				<td><%=(i+1)%></td>
				<td><%=s.getTransitLine() + " #" + s.getTrainId()%></td>
				<td><%=s.getOriginDT().substring(0, s.getOriginDT().length() - 3).split(" ")[1]%></td>
				<td><%=s.getDestinationDT().substring(0, s.getDestinationDT().length() - 3).split(" ")[1]%></td>
				<td><%=s.getStops()%></td>
				<td><%=s.getDuration() + " min"%></td>
				<td><%="$" + s.getFare()%></td>
				<!-- <td><input type="radio" name="destReservation" /></td> -->
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
				if ((request.getAttribute("org-dest-trains") != null
					&& orgDestStd.size() != 0)
					|| (request.getAttribute("dest-org-trains") != null
					&& destOrgStd.size() != 0)) {
			%>
			<br>
			<h3 class="form" style="text-align: center">Reserve</h3>
			<br>
			<% if (orgDestStd.size() > 0){ %><label for="origin-option">Origin
				Option</label> <select id="origin-option" name="origin-option" required>
				<option value="" selected disabled>Select Origin Option</option>
				<% 
					for (int i = 0; i < orgDestStd.size(); i++){ %>
				<option value="<%=orgDestStd.get(i).toString()%>"><%=i+1%></option>
				<%}%>
			</select>
			<%}%>
			<br>
			<% if (destOrgStd.size() > 0){ %><label for="dest-option">Destination
				Option</label> <select id="dest-option" name="dest-option" required>
				<option value="" selected disabled>Select Destination
					Option</option>
				<%
					for (int i = 0; i < destOrgStd.size(); i++){ %>
				<option value="<%=destOrgStd.get(i).toString()%>"><%=i+1%></option>
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

	<!-- <script src= 
	"https://code.jquery.com/jquery-2.2.4.min.js"> 
  </script> 
    
    <script type="text/javascript"> 
        
      // Check the radio button value. 
        $('#reserve').on('click', function() { 
            output =  
              $('input[name=originReservation]:checked', 
                '#validTrainsOD').val(); 
            
            document.querySelector( 
              '.output').textContent = output; 
            console.log(output, "Hello, world!");
            
            document.querySelector( 
            '.output').text(output) 
        }); 
    </script> -->
	<script>
		highlight_rowOD();
		function highlight_rowOD() {
		    var table = document.getElementById('validTrainsOD');
		    var cells = table.getElementsByTagName('td');
	
		    for (var i = 0; i < cells.length; i++) {
		        var cell = cells[i];
		        cell.onclick = function () {
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
		        cell.onclick = function () {
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
