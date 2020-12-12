<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reservations</title>
</head>
<body>

	<form class = "form" action="ReservationsController" method="POST">
		<label for="origin">Origin</label> <select id="origin" name="origin"
			required>
			<option value="none" selected disabled>Select An Origin</option>
			<%
				try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();

				String stopInformation = "SELECT station_id, departure_time, transit_line, train_id FROM stops order by departure_time;";
				ResultSet result = stmt.executeQuery(stopInformation);

				while (result.next()) {
					Statement stmt1 = con.createStatement();
					String stationName = "SELECT name FROM station WHERE station_id=" + result.getString(1) + ";";
					ResultSet stationNameResult = stmt1.executeQuery(stationName);
					while (stationNameResult.next()) {
			%><option value="<%=result.getString(1)%>">Station Name:
				<%=stationNameResult.getString(1)%>, Departure Time:
				<%=result.getString(2)%>, Transit Line:
				<%=result.getString(3)%>, Train ID:
				<%=result.getString(4)%></option>
			<%
				}
			}
			result.close();
			%>
		</select> <label for="dest">Destination</label> <select id="dest" name="dest"
			required>
			<option value="none" selected disabled>Select A Destination</option>
			<%
				stopInformation = "SELECT station_id, arrival_time, transit_line, train_id FROM stops order by arrival_time;";
			result = stmt.executeQuery(stopInformation);

			while (result.next()) {
				Statement stmt1 = con.createStatement();
				String stationName = "SELECT name FROM station WHERE station_id=" + result.getString(1) + ";";
				ResultSet stationNameResult = stmt1.executeQuery(stationName);
				while (stationNameResult.next()) {
			%><option value="<%=result.getString(1)%>">Station Name:
				<%=stationNameResult.getString(1)%>, Arrival Time:
				<%=result.getString(2)%>, Transit Line:
				<%=result.getString(3)%>, Train ID:
				<%=result.getString(4)%></option>
			<%
				}
			}

			db.closeConnection(con);
			} catch (Exception e) {
			System.out.print(e);
			}
			%>
		</select> 
		<button type="submit" onclick="verifySelections()" formmethod="POST">Reserve</button>
	</form>
	<div id="penis1">
		
	</div>
	<script>
				function verifySelections(){
					var thePenis = document.getElementById("penis1");
					var originSelected = document.getElementById('origin');
					originSelected = originSelected.options[originSelected.selectedIndex].text;
					var destinationSelected = document.getElementById('dest');
					destinationSelected = destinationSelected.options[destinationSelected.selectedIndex].text
					var startOrigin = originSelected.indexOf("Departure Time:");
					startOrigin += "Departure Time: ".length;
					var startDestination = destinationSelected.indexOf('Arrival Time:');
					startDestination += "Arrival Time: ".length;
					var originDate = new Date(originSelected.substring(startOrigin, startOrigin+19).replace(/-/g,"/"));
					var destDate = new Date(destinationSelected.substring(startDestination, startDestination+19).replace(/-/g,"/"));
					if(originDate.getMonth()!=destDate.getMonth() || originDate.getDate()!=destDate.getDate() ||
							originDate.getYear()!=originDate.getYear()){
						alert("Please choose an origin and destination on the same day");
					}
					if(originDate>=destDate){
						alert("Please choose an origin time that comes before the destination time.");
					}
					
					/* if (originSelected.substring(startOrigin, startOrigin+11).localeCompare(
									destinationSelected.substring(startDestination,
											startDestination+11))!=0) {
						alert("Please choose an origin and destination on the same day");
					}
					if (originSelected
							.substring(startOrigin, originSelected.length)
							.localeCompare(
									destinationSelected.substring(startDestination,
											destinationSelected.length))>=0) {
						alert("Please choose an origin time that comes before the destination time.");
					} */
					startOrigin = originSelected.indexOf('Transit Line:');
					startDestination = destinationSelected.indexOf('Transit Line:');
					
					if(originSelected
							.substring(startOrigin, originSelected.length)
							.localeCompare(
									destinationSelected.substring(startDestination,
											destinationSelected.length))!=0){
						alert("Please choose an origin and destination that have the same transit line and train ID.");
					}
				}
				
				var destinationID = document.getElementById('dest');
				destinationID.addEventListener('change', verifySelections, false);
			</script>
</body>
</html>