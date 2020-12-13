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
		if (session.getAttribute("isAdmin") != null && ((boolean) session.getAttribute("isAdmin"))) {
		System.out.println("hello admin");
	%>
	<!-- PUT EVERYTHING ADMINS SHOULD SEE IN THIS IF STATEMENT -->
	<div class="center" id="repTable">
		<h4>Customer Representative Table</h4>
		<table>
			<tr>
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
				String customerInfo = "SELECT * FROM employee;";
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
	<div class="center" id="addRep">
		<h4>Add a new Representative (make sure username is unique)</h4>
		<form action="AddCustomerController" method="POST">
			<input type="text" name="firstName" placeholder="First Name" required>
			<input type="text" name="lastName" placeholder="Last Name" required>
			<input type="text" name="ssn" placeholder="SSN (XXX-XX-XXXX)"
				required> <input type="text" name="username"
				placeholder="Username" required> <input type="password"
				name="password" placeholder="Password" required>
			<button type="submit" formmethod="POST">Add</button>
		</form>
	</div>
	<br>
	<div class="center" id="editRep">
		<h4>Edit an existing Representative (make sure Representative's
			SSN matches and username is unique)</h4>
		<form action="EditCustomerController" method="POST">
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
		</form>
	</div>
	<br>
	<div class="center" id="deleteRep">
		<h4>Delete an existing Customer Representative (make sure
			Representative's SSN matches)</h4>
		<form action="DeleteCustomerController" method="POST">
			<input type="text" name="ssn" placeholder="SSN (XXX-XX-XXXX)"
				required>
			<button type="submit" formmethod="POST">Delete</button>
		</form>
	</div>
	<br>
	<div class="center" id="salesPerMonth">
		<h4>Obtain Sales Report per Month</h4>
		<div class="center">
			<form action="SalesReportsController" method="POST">
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
				</select> <select name="Year" required>
					<option value="">- Year -</option>
					<option value="2020">2020</option>
					<option value="2019">2019</option>
					<option value="2018">2018</option>
					<option value="2017">2017</option>
					<option value="2016">2016</option>
					<option value="2015">2015</option>
					<option value="2014">2014</option>
					<option value="2013">2013</option>
					<option value="2012">2012</option>
					<option value="2011">2011</option>
					<option value="2010">2010</option>
					<option value="2009">2009</option>
					<option value="2008">2008</option>
					<option value="2007">2007</option>
					<option value="2006">2006</option>
					<option value="2005">2005</option>
					<option value="2004">2004</option>
					<option value="2003">2003</option>
					<option value="2002">2002</option>
					<option value="2001">2001</option>
					<option value="2000">2000</option>
					<option value="1999">1999</option>
					<option value="1998">1998</option>
					<option value="1997">1997</option>
					<option value="1996">1996</option>
					<option value="1995">1995</option>
					<option value="1994">1994</option>
					<option value="1993">1993</option>
					<option value="1992">1992</option>
					<option value="1991">1991</option>
					<option value="1990">1990</option>
					<option value="1989">1989</option>
					<option value="1988">1988</option>
					<option value="1987">1987</option>
					<option value="1986">1986</option>
					<option value="1985">1985</option>
					<option value="1984">1984</option>
					<option value="1983">1983</option>
					<option value="1982">1982</option>
					<option value="1981">1981</option>
					<option value="1980">1980</option>
					<option value="1979">1979</option>
					<option value="1978">1978</option>
					<option value="1977">1977</option>
					<option value="1976">1976</option>
					<option value="1975">1975</option>
					<option value="1974">1974</option>
					<option value="1973">1973</option>
					<option value="1972">1972</option>
					<option value="1971">1971</option>
					<option value="1970">1970</option>
					<option value="1969">1969</option>
					<option value="1968">1968</option>
					<option value="1967">1967</option>
					<option value="1966">1966</option>
					<option value="1965">1965</option>
					<option value="1964">1964</option>
					<option value="1963">1963</option>
					<option value="1962">1962</option>
					<option value="1961">1961</option>
					<option value="1960">1960</option>
					<option value="1959">1959</option>
					<option value="1958">1958</option>
					<option value="1957">1957</option>
					<option value="1956">1956</option>
					<option value="1955">1955</option>
					<option value="1954">1954</option>
					<option value="1953">1953</option>
					<option value="1952">1952</option>
					<option value="1951">1951</option>
					<option value="1950">1950</option>
					<option value="1949">1949</option>
					<option value="1948">1948</option>
					<option value="1947">1947</option>
					<option value="1946">1946</option>
					<option value="1945">1945</option>
					<option value="1944">1944</option>
					<option value="1943">1943</option>
					<option value="1942">1942</option>
					<option value="1941">1941</option>
					<option value="1940">1940</option>
					<option value="1939">1939</option>
					<option value="1938">1938</option>
					<option value="1937">1937</option>
					<option value="1936">1936</option>
					<option value="1935">1935</option>
					<option value="1934">1934</option>
					<option value="1933">1933</option>
					<option value="1932">1932</option>
					<option value="1931">1931</option>
					<option value="1930">1930</option>
				</select>
				<button type="submit" formmethod="POST">Get Sales Report</button>
			</form>
		</div>
	</div>
	<div class="center" style="color: blue">
		<%
			if (request.getAttribute("salesData") != null) {
		%>
		Revenue in
		<%=request.getAttribute("salesDataMonth")%>
		<%=request.getAttribute("salesDataYear")%>: $<%=request.getAttribute("salesData")%>
		<%
			}
		%>
	</div>
	<br>
	<div class="center" id="listReservations">
		<h4>Reservations List</h4>
		<div>Filter reservations by transit line, by customer name, or
			both. Must choose at least one.</div>
		<form action="ListReservationsController" method="POST">
			<label for="TransitLine">Transit Line: </label> <select
				id="TransitLine" name="TransitLine">
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
				%><option value="<%=result.getString(1)%>">Transit Line:
					<%=result.getString(1)%>
				</option>
				<%
					}
				result.close();
				%>
			</select> <label for="customerUserName">Select Customer Name: </label> <select
				id="customerUserName" name="customerUserName">
				<option value="none" selected disabled>Select A Username</option>
				<%
					trainLineInformation = "SELECT username, first_name, last_name FROM customer;";
				result = stmt.executeQuery(trainLineInformation);
				while (result.next()) {
				%><option value="<%=result.getString(1)%>">Username:
					<%=result.getString(1)%>, Name:
					<%=result.getString(2)%>
					<%=result.getString(3)%>
				</option>
				<%
					}
				db.closeConnection(con);
				} catch (Exception e) {
				System.out.print(e);
				}
				%>
			</select>
			<button type="submit" formmethod="POST">Get Reservations</button>
		</form>
	</div>
	<div id="reservationTableList">
		<%
			if (request.getAttribute("valid-reservations") != null) {
			ArrayList<Reservation> std = (ArrayList<Reservation>) request.getAttribute("valid-reservations");
		%>
		<table>
			<tr>
				<th>Reservation Number</th>
				<th>Fare Type</th>
				<th>Date Made</th>
				<th>Total Fare</th>
				<th>Reservation Origin</th>
				<th>Reservation Destination</th>
				<th>Reservation Destination Datetime</th>
				<th>Customer Username</th>
				<th>Transit Line</th>
				<th>Train ID</th>
			</tr>
			<%
				for (Reservation s : std) {
			%>
			<tr>
				<td><%=s.getReservationNumber()%></td>
				<td><%=s.getFareType()%></td>
				<td><%=s.getDateMade()%></td>
				<td><%=s.getTotalFare()%></td>
				<td><%=s.getReservationOrigin()%></td>
				<td><%=s.getReservationDestination()%></td>
				<td><%=s.getReservationDestinationDatetime()%></td>
				<td><%=s.getCustomerUsername()%></td>
				<td><%=s.getTransitLine()%></td>
				<td><%=s.getTrainId()%></td>
			</tr>
			<%}%>
		</table>
		<%
			}
		%>
	</div>
	<br>
	<div id="revenueList" class="center">
		<h4>Listing of Revenue</h4>
		<div>Please choose at least one option to sort by</div>
		<form action="AdminRevenueListingController" method="POST">
			<input type="checkbox" name="transitLine" value="transitLine">
			<label for="transitLine">Sort by transit line</label> <input
				type="checkbox" name="customerName" value="customerName"> <label
				for="customerName">Sort by customer username</label>
			<button type="submit" formmethod="POST">Get Revenues</button>
		</form>
	</div>
	<div id="revenueListTable" class="center">
		<%
			if (request.getAttribute("valid-customerUsernames") != null) {
			ArrayList<Integer> revenues = (ArrayList<Integer>) request.getAttribute("valid-revenues");
			ArrayList<String> customerUsernames = (ArrayList<String>) request.getAttribute("valid-customerUsernames");
		%>
		<table>
			<tr>
				<th>Customer Username</th>
				<th>Revenue</th>
			</tr>
			<%
				for (int i = 0; i < revenues.size(); i++) {
			%>
			<tr>
				<td><%=customerUsernames.get(i)%></td>
				<td><%=revenues.get(i)%></td>
			</tr>
			<%}%>
		</table>
		<%
			}
		if (request.getAttribute("valid-transitLines") != null) {
			ArrayList<Integer> revenues = (ArrayList<Integer>) request.getAttribute("valid-revenues");
			ArrayList<String> transitLines = (ArrayList<String>) request.getAttribute("valid-transitLines");
		%>
		<table>
			<tr>
				<th>Transit Line</th>
				<th>Revenue</th>
			</tr>
			<%
				for (int i = 0; i < revenues.size(); i++) {
			%>
			<tr>
				<td><%=transitLines.get(i)%></td>
				<td><%=revenues.get(i)%></td>
			</tr>
			<%}%>
		</table>
		<%
			}
		else if (request.getAttribute("valid-customerUsernamesBoth") != null) {
		ArrayList<Integer> revenues = (ArrayList<Integer>) request.getAttribute("valid-revenues");
		ArrayList<String> customerUsernames = (ArrayList<String>) request.getAttribute("valid-customerUsernamesBoth");
		ArrayList<String> transitLines = (ArrayList<String>) request.getAttribute("valid-transitLinesBoth");
		%>
		<table>
			<tr>
				<th>Customer Username</th>
				<th>Transit Line</th>
				<th>Revenue</th>
			</tr>
			<%
				for (int i = 0; i < revenues.size(); i++) {
			%>
			<tr>
				<td><%=customerUsernames.get(i)%></td>
				<td><%=transitLines.get(i)%></td>
				<td><%=revenues.get(i)%></td>
			</tr>
			<%}%>
		</table>
		<%
			}
		%>
	</div>
	<br>
	<div id="bestCustomer" class="center">
	<h4>Best Customer(s)</h4>
	<div>The following customer(s) generated the most revenue:</div>
		<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String bestCustomers = "SELECT customer_username FROM (SELECT customer_username, sum(total_fare)total_fare FROM reservation GROUP BY" +
			" customer_username)r1 WHERE r1.total_fare >= all (SELECT sum(total_fare)total_fare FROM reservation GROUP BY customer_username)";
			ResultSet result = stmt.executeQuery(bestCustomers);
			while(result.next()){
				%>
				<div style="color: blue"><%=result.getString(1)%></div>
				<br>
				<% 
			}
		} catch (Exception e){
			System.out.println(e);
		}
		%>
	</div>
	<div id="mostActiveTransitLines" class="center">
		<h4 align="center">5 Most Active Transit Lines</h4>
		<div>Customers reserve these transit lines the most:</div>
		<ol style="color: blue">
		<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String bestCustomers = "SELECT transit_line, count(*) appearances FROM reservation GROUP BY transit_line ORDER BY appearances DESC LIMIT 5";
			ResultSet result = stmt.executeQuery(bestCustomers);
			for(int i = 0; i<5; i++){
				%>
				<li><% while(result.next()){ %>
				<%=result.getString(1)%>
				<%} %>
				</li>
				<%
			}
			while(result.next()){
				%>
				<li><%=result.getString(1)%></li>
				<% 
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
				if (x[i].text > 50) {
					alert("Please make all string inputs' lengths less than or equal to 50 characters");
				}
			}
		}
	</script>
</body>
</html>