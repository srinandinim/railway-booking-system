<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat, java.util.Date, java.text.DecimalFormat"%>
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

button {
	width: 88%;
	padding: 2px;
	background-color: #38586b;
	border: 0;
	box-sizing: border-box;
	cursor: pointer;
	font-weight: bold;
	font-size: 16px;
	color: #ffffff;
}
</style>
<title>Admin</title>
</head>
<body>
	<%
		if (session.getAttribute("isAdmin") != null && ((boolean) session.getAttribute("isAdmin"))) {
	%>
	<!-- PUT EVERYTHING ADMINS SHOULD SEE IN THIS IF STATEMENT -->
	<div class="center padding" id="repTable">
		<br>
		<h4 style="font-weight: bold">Customer Representatives</h4>
		<table>
			<tr class="tableHeader">
				<th>Employee SSN</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Username</th>
			</tr>
			<%
				try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
				String customerInfo = "SELECT * FROM employee WHERE NOT username='admin';";
				ResultSet customerInfoResult = stmt.executeQuery(customerInfo);
				while (customerInfoResult.next()) {
			%>
			<tr>
				<td><%=customerInfoResult.getString(1)%></td>
				<td><%=customerInfoResult.getString(2)%></td>
				<td><%=customerInfoResult.getString(3)%></td>
				<td><%=customerInfoResult.getString(4)%></td>
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
	<div class="padding" id="addRep">
		<h4 class="subheading">Add a New Representative</h4>
		<p> Please make sure that the username is unique </p>
		<form action="AddCustomerController" method="POST">
		  <div class="row justify-content-start">
		    <div class="col-sm-2">
		    	<input type="text" name="firstName" placeholder="First Name" required>
			  	<p></p>
			  	<input type="text" name="username"
				placeholder="Username" required>
				<p></p>
			  	<input type="text" name="ssn" placeholder="SSN (XXX-XX-XXXX)"
				required> 
				<p></p>
		    </div>
		    <div class="col-sm-2">
		    	<input type="text" name="lastName" placeholder="Last Name" required>
			  <p></p>
			  <input type="password"
				name="password" placeholder="Password" required>
				<p></p>
				<button type="submit" formmethod="POST">Add</button>
			</div>
		  </div>
		</form>
	</div>
	<br>
	<div class="padding" id="editRep">
		<h4 class="subheading">Edit Customer Representative</h4>
		<p style="margin: 0; padding: 0"> Make sure the representative's SSN matches. </p>
		<p> If username is changed, please make sure it is unique. </p>
		<!-- <h4>Edit an existing Representative (make sure Representative's
			SSN matches and username is unique)</h4> -->
		<!-- <form action="EditCustomerController" method="POST">
			<label for="ssn">Enter the SSN of the Customer Representative you would like to modify.</label>
			<input
				type="text" name="ssn" placeholder="SSN (XXX-XX-XXXX)" required>
			<br><br>
			<input type="text" name="firstName" placeholder="First Name"
				class="editVerify"> <input type="text" name="lastName"
				placeholder="Last Name" class="editVerify"> 
			<input type="text" name="username" placeholder="Username"
				class="editVerify"> <input type="password" name="password"
				placeholder="Password" class="editVerify">
			<button type="submit" onclick="verifyEdits()" formmethod="POST">Edit</button>
		</form> -->
		<form action="EditCustomerController" method="POST">
			<label for="ssn">Customer Representative SSN: </label>
			<input
				type="text" name="ssn" placeholder="SSN (XXX-XX-XXXX)" required>
			<br><br>
		  <div class="row justify-content-start">
		    <div class="col-sm-2">
		    	<input type="text" name="firstName" placeholder="First Name"
				class="editVerify"> 
			  	<p></p>
			  	<input type="text" name="username" placeholder="Username"
				class="editVerify">
				<p></p>
		    </div>
		    <div class="col-sm-2">
		    	 <input type="text" name="lastName"
				placeholder="Last Name" class="editVerify"> 
			  <p></p>
			  <input type="password" name="password"
				placeholder="Password" class="editVerify">
				<p></p>
			</div>
		  </div>
		  <button style="width:400px" type="submit" onclick="verifyEdits()" formmethod="POST">Edit</button>
		</form>
	</div>
	<br>
	<div class="padding" id="deleteRep">
		<h4 class="subheading">Delete Current Representative</h4>
		<p> Make sure the representative's SSN matches. </p>
		<form action="DeleteCustomerController" method="POST">
		  <div class="row justify-content-start" >
		    <div class="col-sm-2">
		    	<input type="text" name="ssn" placeholder="SSN (XXX-XX-XXXX)"
				required>
			  	<p></p>
		    </div>
		    <div class="col-sm-2">
		    	<button type="submit" formmethod="POST">Delete</button>
			  	<p></p>
		    </div>
		  </div>
		</form>
	</div>
	<br>
	<div class="padding" id="salesPerMonth">
		<h4 class="subheading">Monthly Sales Report</h4>
		<form action="SalesReportsController" method="POST">
		  <div class="row justify-content-start" >
		    <div class="col-sm-1">
		    	<select name="Month" required>
					<option value="">- Month -</option>
					<option value="January">January</option>
					<option value="February">February</option>
					<option value="March">March</option>
					<option value="April">April</option>
					<option value="May">May</option>
					<option value="June">June</option>
					<option value="July">July</option>
					<option value="August">August</option>
					<option value="September">September</option>
					<option value="October">October</option>
					<option value="November">November</option>
					<option value="December">December</option>
				</select> 
			  	<p></p>
		    </div>
		    <div class="col-sm-1">
		    	<select name="Year" required>
					<option value="">- Year -</option>
					<%
						for (int i = 1930; i <= 2020; i++){ %>
							<option value='<%=i%>'><%=i%></option>
					<%	}
					%>
				</select>
			  	<p></p>
		    </div>
		    <div class="col-sm-2">
		    	<button type="submit" formmethod="POST">Get Sales Report</button>
			  	<p></p>
		    </div>
		  </div>
		</form>
	</div>
	<div class="padding">
		<%
			if (request.getAttribute("salesData") != null) {
				DecimalFormat df = new DecimalFormat("#.00");
				String value = request.getAttribute("salesData").toString();
				String salesData = df.format(Double.parseDouble(value));
		%>
		Revenue in
		<%=request.getAttribute("salesDataMonth")%>
		<%=request.getAttribute("salesDataYear")%>: $<%=salesData%>
		<%
			}
		%>
	</div>
	<br>
	<div class="padding" id="listReservations">
		<h4 class="subheading">Reservations List</h4>
		<p>Filter reservations by transit line, customer name, or
			both.</p>
		<form action="ListReservationsController" method="POST">
		  <div class="row justify-content-start" >
		    <div class="col-sm-3">
		    	<select
				id="TransitLine" name="TransitLine" style="width:250px">
				<option value="none" selected disabled>Select A Transit
					Line</option>
				<%
					try {
					ApplicationDB db = new ApplicationDB();
					Connection con = db.getConnection();
					Statement stmt = con.createStatement();
					String trainLineInformation = "SELECT distinct transit_line FROM train_schedule;";
					ResultSet result = stmt.executeQuery(trainLineInformation);
					while (result.next()) {
				%><option value="<%=result.getString(1)%>"><!-- Transit Line: -->
					<%=result.getString(1)%>
				</option>
				<%
					}
				result.close();
				%>
			</select> 
			  	<p></p>
			  	<select
				id="customerUserName" name="customerUserName" style="width:250px">
				<option value="none" selected disabled>Select A Customer</option>
				<%
					trainLineInformation = "SELECT username, first_name, last_name FROM customer;";
				result = stmt.executeQuery(trainLineInformation);
				while (result.next()) {
				%><option value="<%=result.getString(1)%>"><!-- Username: -->
					<!-- , Name: -->
					<%=result.getString(2)%>
					<%=result.getString(3)%> (<%=result.getString(1)%>)
				</option>
				<%
					}
				db.closeConnection(con);
				} catch (Exception e) {
				System.out.print(e);
				}
				%>
			</select>
			<p></p>
			<button style="width:250px" type="submit" formmethod="POST">Get Reservations</button>
			  	<p></p>
		    </div>
		  </div>
		</form>
	</div>
	<div class="center padding" id="reservationTableList">
		<%
			if (request.getAttribute("valid-reservations") != null) {
			ArrayList<Reservation> std = (ArrayList<Reservation>) request.getAttribute("valid-reservations");
			if (std.size() > 0){
		%>
		<table>
			<tr class="tableHeader">
				<th>Reservation #</th>
				<th>Customer</th>
				<th>Fare Type</th>
				<th>Date Reserved</th>
				<th>Total Fare</th>
				<th>Origin</th>
				<th>Departure Date &amp; Time</th>
				<th>Destination</th>
				<th>Arrival Date &amp; Time</th>
				<th>Train</th>
			</tr>
			<%
				for (Reservation s : std) {
					String fareType = " "; // to change the - to a space
					if (s.getFareType().equals("one-way")){
						fareType = "One Way";
					} else {
						fareType = "Round Trip";
					}
					DecimalFormat df = new DecimalFormat("#.00");
					String totalFare = df.format(Double.parseDouble(s.getTotalFare()));
					String origin = (s.getReservationOrigin().split(", Station ID:")[0]).split("Station Name:")[1];
					String destination = (s.getReservationDestination().split(", Station ID:")[0]).split("Station Name:")[1];
			%>
			<tr>
				<td><%=s.getReservationNumber()%></td>
				<td><%=s.getCustomerUsername()%></td>
				<td><%=fareType%></td>
				<td><%=s.getDateMade()%></td>
				<td>$<%=totalFare%></td>
				<td><%=origin%></td>
				<td><%=s.getReservationOriginDatetime().substring(0, s.getReservationOriginDatetime().length()-3)%></td>
				<td><%=destination%></td>
				<td><%=s.getReservationDestinationDatetime().substring(0, s.getReservationDestinationDatetime().length()-3)%></td>
				<td><%=s.getTransitLine() + " #" + s.getTrainId()%></td>
			</tr>
			<%}%>
		</table>
		<%
			} else { 
				if (request.getAttribute("user") != null && request.getAttribute("transit-line") != null){ %>
					<p>The customer <%=request.getAttribute("user")%> does not have any reservations on the <%=request.getAttribute("transit-line")%> Line<p>	
				<% } else if (request.getAttribute("user") != null){ %>
					<p>The customer <%=request.getAttribute("user")%> does not have any reservations.<p>
				<% } else { %>
					<p>There are no reservations on the <%=request.getAttribute("transit-line")%> Line<p>
			<%	}
			}
			}
		%>
	</div>
	<br>
	<div id="revenueList" class="padding">
		<h4 class="subheading">Listing of Revenue</h4>
		<p>Please choose at least one option to sort by.</p>
		<form action="AdminRevenueListingController" method="POST">
			<input type="checkbox" name="transitLine" value="transitLine">
			<label for="transitLine">Transit Line</label> 
			<br>
			<input
				type="checkbox" name="customerName" value="customerName"> <label
				for="customerName">Customer Name</label>
			<br><br>
			<button style="width:200px" type="submit" formmethod="POST">Get Revenues</button>
		</form>
	</div>
	<div class="padding" id="revenueListTable">
		<%
			if (request.getAttribute("valid-customerUsernames") != null) {
			ArrayList<Double> revenues = (ArrayList<Double>) request.getAttribute("valid-revenues");
			ArrayList<String> customerUsernames = (ArrayList<String>) request.getAttribute("valid-customerUsernames");
		%>
		<table>
			<tr class="tableHeader">
				<th>Customer</th>
				<th>Revenue</th>
			</tr>
			<%
				for (int i = 0; i < revenues.size(); i++) {
					DecimalFormat df = new DecimalFormat("#.00");
					String revenueDouble = df.format(revenues.get(i));
			%>
			<tr>
				<td><%=customerUsernames.get(i)%></td>
				<td>$<%=revenueDouble%></td>
			</tr>
			<%}%>
		</table>
		<%
			}
		if (request.getAttribute("valid-transitLines") != null) {
			ArrayList<Double> revenues = (ArrayList<Double>) request.getAttribute("valid-revenues");
			ArrayList<String> transitLines = (ArrayList<String>) request.getAttribute("valid-transitLines");
		%>
		<table>
			<tr class="tableHeader">
				<th>Transit Line</th>
				<th>Revenue</th>
			</tr>
			<%
				for (int i = 0; i < revenues.size(); i++) {
					DecimalFormat df = new DecimalFormat("#.00");
					String revenueDouble = df.format(revenues.get(i));
			%>
			<tr>
				<td><%=transitLines.get(i)%></td>
				<td>$<%=revenueDouble%></td>
			</tr>
			<%}%>
		</table>
		<%
			}
		else if (request.getAttribute("valid-customerUsernamesBoth") != null) {
		ArrayList<Double> revenues = (ArrayList<Double>) request.getAttribute("valid-revenues");
		ArrayList<String> customerUsernames = (ArrayList<String>) request.getAttribute("valid-customerUsernamesBoth");
		ArrayList<String> transitLines = (ArrayList<String>) request.getAttribute("valid-transitLinesBoth");
		%>
		<table>
			<tr class="tableHeader">
				<th>Customer</th>
				<th>Transit Line</th>
				<th>Revenue</th>
			</tr>
			<%
				for (int i = 0; i < revenues.size(); i++) {
					DecimalFormat df = new DecimalFormat("#.00");
					String revenueDouble = df.format(revenues.get(i));
			%>
			<tr>
				<td><%=customerUsernames.get(i)%></td>
				<td><%=transitLines.get(i)%></td>
				<td>$<%=revenueDouble%></td>
			</tr>
			<%}%>
		</table>
		<%
			}
		%>
	</div>
	<br>
	<div id="bestCustomer" class="padding">
	<h4 class="subheading">Best Customer</h4>
		<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String bestCustomers = "SELECT username, first_name, last_name FROM customer, (SELECT customer_username FROM (SELECT customer_username, sum(total_fare)total_fare FROM reservation GROUP BY customer_username)r1 WHERE r1.total_fare >= all (SELECT sum(total_fare)total_fare FROM reservation GROUP BY customer_username)) db WHERE username = customer_username;";
			ResultSet result = stmt.executeQuery(bestCustomers);
			String usernames = "";
			while(result.next()){
				/* usernames+=result.getString(1) + ", "; */
				usernames+=result.getString(2) + " " + result.getString(3) + " (" + result.getString(1) + ")"+ ", ";
			}
			%>
			<p> The most revenue was generated by <%=usernames.substring(0, usernames.length()-2)%> </p>
		<%
		} catch (Exception e){
			System.out.println(e);
		}
		%>
	</div>
	<div id="mostActiveTransitLines" class="padding">
		<h4 class="subheading">5 Most Active Transit Lines</h4>
		<div>Customers reserve these transit lines the most:</div>
		<ol>
		<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String bestCustomers = "SELECT transit_line, count(*) appearances FROM reservation GROUP BY transit_line ORDER BY appearances DESC LIMIT 5";
			ResultSet result = stmt.executeQuery(bestCustomers);
			
			int count = 0;
			while(result.next()){
				%>
				<li><%=result.getString(1)%></li>
				<% 
				count++;
			}
			while(count<5){
				%>
				<li>N/A</li>
				<% 
				count++;
			}
		} catch (Exception e){
			System.out.println(e);
		}
		%>
		</ol>
	</div>
	<%
		} else {
	System.out.println("Not an admin");
	%>
	<h1>You are not an admin!</h1>
	<%
		}
	%>
	<script>
		function verifyEdits() {
			var editVerify = document.getElementByClassName('editVerify');
			var i;
			for (i = 0; i < editVerify.length; i++) {
				if (editVerify[i].text > 50) {
					alert("Please make all string inputs' lengths less than or equal to 50 characters");
				}
			}
		}
	</script>
</body>
</html>