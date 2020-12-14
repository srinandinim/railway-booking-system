<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
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
<title>Admin Page</title>
</head>
<body>
	<%
		if (session.getAttribute("isEmployee") != null && ((boolean) session.getAttribute("isEmployee"))) {
		System.out.println("hello employee/admin");
	%>
	<!-- PUT EVERYTHING ADMINS/EMPLOYEES SHOULD SEE IN THIS IF STATEMENT -->
	<h1>Hello Admin/Employee</h1>
	<div class="center" id="trainScheduleTable">
		<h4>Train Schedule Table</h4>
		<table>
			<tr>
				<th>Transit Line</th>
				<th>Departure Date and Time</th>
				<th>Arrival Date and Time</th>
				<th>Fare</th>
				<th>Origin Station</th>
				<th>Destination Station</th>
				<th>Train ID</th>
			</tr>
			<%
				try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
				String trainScheduleInfo = "SELECT * FROM train_schedule;";
				ResultSet trainScheduleInfoResult = stmt.executeQuery(trainScheduleInfo);
				while (trainScheduleInfoResult.next()) {
			%>
			<tr>
				<td><%=trainScheduleInfoResult.getString(1)%></td>
				<td><%=trainScheduleInfoResult.getString(2)%></td>
				<td><%=trainScheduleInfoResult.getString(3)%></td>
				<td><%=trainScheduleInfoResult.getString(4)%></td>
				<%
					Statement stmt1 = con.createStatement();
					String getOriginStation = "SELECT name FROM station WHERE BINARY station_id=\'" + trainScheduleInfoResult.getString(5) + "\';";
					ResultSet originStation = stmt1.executeQuery(getOriginStation);
					while(originStation.next()){
						%>
						<td><%=originStation.getString(1)%>, Station ID: <%=trainScheduleInfoResult.getString(5)%></td>
					<%}%>
				<%
					stmt1 = con.createStatement();
					String getDestinationStation = "SELECT name FROM station WHERE BINARY station_id=\'" + trainScheduleInfoResult.getString(6) + "\';";
					ResultSet destinationStation = stmt1.executeQuery(getDestinationStation);
					while(destinationStation.next()){
						%>
						<td><%=destinationStation.getString(1)%>, Station ID: <%=trainScheduleInfoResult.getString(6)%></td>
					<%}%>
				<td><%=trainScheduleInfoResult.getString(7)%></td>
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
	<div class="center" id="addTrainSchedule">
		<h4>Add a new Train Schedule (make sure transit line and train ID combination is unique)</h4>
		<div>Enter departure datetime and arrival datetime as "YYYY-MM-DD HH:MM:SS"</div>
		<form action="CusRepTrainScheduleController" method="POST">
			<input type="text" name="newTransitLine" placeholder="Transit Line" maxlength="50" required>
			<input type="text" name="departureDateTime" placeholder="Departure Date and Time" maxlength="19" required>
			<input type="text" name="arrivalDateTime" placeholder="Arrival Date and Time" maxlength="19"
				required> <input type="text" name="fare" 
				placeholder="Fare" class="editVerifyAdd" required> <input type="text"
				name="originStationID" placeholder="Origin Station ID" required>
				<input type="text"
				name="destinationStationID" placeholder="Destination Station ID" required>
				<input type="text"
				name="trainID" placeholder="Train ID" required>
			<button type="submit" formmethod="POST">Add</button>
		</form>
	</div>
	<br>
	<div class="center" id="editTrainSchedule">
		<h4>Edit an existing Train Schedule (make sure transit line and train ID match)</h4>
		<div>Enter departure datetime and arrival datetime as "YYYY-MM-DD HH:MM:SS"</div>
		<form action="CusRepTrainScheduleController" method="POST">
			<label for="ssn">Enter the transit line and train ID of the train schedule you would like to modify:</label>
			<input type="text" name="editTransitLine" placeholder="Transit Line" maxlength="50" required>
			<input type="text" name="trainID" placeholder="Train ID" required>
			<br><br>
			<input type="text" name="departureDateTime" placeholder="Departure Date and Time" maxlength="19">
			<input type="text" name="arrivalDateTime" placeholder="Arrival Date and Time" maxlength="19"
				> <input type="text" name="fare"
				placeholder="Fare"> <input type="text"
				name="originStationID" placeholder="Origin Station ID">
				<input type="text"
				name="destinationStationID" placeholder="Destination Station ID">
			<button type="submit" formmethod="POST">Edit</button>
		</form>
	</div>
	<br>
	<div class="center" id="deleteRep">
		<h4>Delete an existing Train Schedule (make sure transit line and train ID match)</h4>
		<form action="CusRepTrainScheduleController" method="POST">
			<input type="text" name="deleteTransitLine" placeholder="Transit Line" maxlength="50" required>
			<input type="text" name="trainID" placeholder="Train ID" required>
			<button type="submit" formmethod="POST">Delete</button>
		</form>
	</div>
	<br>
	<div class="center" id="listTrainSchedules">
		<h4>Search Train Schedules</h4>
		<div>Filter train schedules by origin, destination, or
			both (meaning results where the origin AND destination match). Must choose at least one.</div>
		<form action="ListTrainSchedulesController" method="POST">
			<label for="Origin">Origin: </label> <select
				id="Origin" name="Origin">
				<option value="none" selected disabled>Select an Origin Station</option>
				<%
					try {
					ApplicationDB db = new ApplicationDB();
					Connection con = db.getConnection();
					Statement stmt = con.createStatement();
					String originStations = "SELECT station_id, name FROM station;";
					ResultSet result = stmt.executeQuery(originStations);
					while (result.next()) {
				%><option value="<%=result.getString(1)%>">Station Name:
					<%=result.getString(2)%>, Station ID: <%=result.getString(1)%>
				</option>
				<%
					}
				result.close();
				%>
			</select> <label for="Destination">Destination: </label> <select
				id="Destination" name="Destination">
				<option value="none" selected disabled>Select a Destination Station</option>
				<%
					String destinationStations = "SELECT station_id, name FROM station;";
				result = stmt.executeQuery(destinationStations);
				while (result.next()) {
				%><option value="<%=result.getString(1)%>">Station Name:
					<%=result.getString(2)%>, Station ID: <%=result.getString(1)%>
				</option>
				<%
					}
				db.closeConnection(con);
				} catch (Exception e) {
				System.out.print(e);
				}
				%>
			</select>
			<button type="submit" formmethod="POST">Get Train Schedules</button>
		</form>
	</div>
	<div id="selectedScheduleTableList">
		<%
			if (request.getAttribute("valid-schedules") != null) {
			ArrayList<TrainSchedule> std = (ArrayList<TrainSchedule>) request.getAttribute("valid-schedules");
		%>
		<table>
			<tr>
				<th>Transit Line</th>
				<th>Departure Datetime</th>
				<th>Arrival Datetime</th>
				<th>Fare</th>
				<th>Origin Station</th>
				<th>Destination Station</th>
				<th>Train ID</th>
			</tr>
			<%
				for (TrainSchedule s : std) {
			%>
			<tr>
				<td><%=s.getTransitLine()%></td>
				<td><%=s.getDepartureDatetime()%></td>
				<td><%=s.getArrivalDatetime()%></td>
				<td><%=s.getFare()%></td>
				<td><%=s.getOriginStationID()%></td>
				<td><%=s.getDestinationStationID()%></td>
				<td><%=s.getTrainID()%></td>
			</tr>
			<%}%>
		</table>
		<%
			}
		%>
	</div>
	<br>
	<div id="customerSearch" class="center">
		<h4>Search Customers with Reservations</h4>
		<div>Find customers who have reservations on a given transit line and date.</div>
		<form action="CusRepReservationSearchController" method="POST">
			<label for="transitLine">Transit Line: </label> <select
				id="transitLine" name="transitLine" required>
				<option value="" selected disabled>Select a Transit Line</option>
				<%
					try {
					ApplicationDB db = new ApplicationDB();
					Connection con = db.getConnection();
					Statement stmt = con.createStatement();
					String originStations = "SELECT DISTINCT transit_line FROM train_schedule;";
					ResultSet result = stmt.executeQuery(originStations);
					while (result.next()) {
				%><option value="<%=result.getString(1)%>"><%=result.getString(1)%></option>
				<%
					}
				db.closeConnection(con);
				} catch (Exception e) {
				System.out.print(e);
				}
				%>
			</select>
			<input type="date" name="reservationDate" placeholder="Date" required>
			<button type="submit" formmethod="POST">Get Customers</button>
		</form>
	</div>
	<div id="customerList" class="center" style="color: blue">
		<%
			if (request.getAttribute("valid-customers") != null) {
			ArrayList<String> std = (ArrayList<String>) request.getAttribute("valid-customers");
		%>
		<div><u>Customer usernames that match your search</u></div>
		<ul>
			<%
				for (String s : std) {
			%>
				<li><%=s%></li>
			<%}%>
		</ul>
		<%
			}
		%>
	</div>
	<%
		} else {
	System.out.println("Not an employee or admin");
	%>
	<h1>You are not an employee or admin.</h1>
	<%
		}
	%>
</body>
</html>