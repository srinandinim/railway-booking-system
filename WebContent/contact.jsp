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

.search {
	text-align: center;
	list-style-position: inside;
	margin-left: auto;
	margin-right: auto;
}
</style>
<title>Contact Us</title>
</head>
<body>
	<%
		if (session.getAttribute("isEmployee") != null && ((boolean) session.getAttribute("isEmployee"))) {
	%>
		<!-- This only appears if employee is logged in -->
		<div id="replyQuestion" class="center"> 
		<h4>Reply to a Question</h4>
		Copy paste the question you'd like to respond to in the "Question" box. Then, insert the answer to the question in the "Answer" box.
		Make sure the question you're replying to already exists. You can also use this form to update a previous answer.
		<form action="ReplyQuestionController" method="POST">
			<textarea class="longInput" maxlength="255" id="question"
			name="question" rows="5" cols="25" placeholder="Question" required></textarea>
			<textarea class="longInput" maxlength="255" id="answer"
			name="answer" rows="5" cols="25" placeholder="Answer" required placeholder="Answer" required></textarea> 
			<br>
			<button type="submit" formmethod="POST">Answer</button>
		</form>
	</div>
	<%}%>
	<div id="askQuestion" class="center">
	<h4>Ask Question</h4>
	<form class="center" action="ForumController" method="POST">
		<textarea class="longInput" maxlength="255" id="question"
			name="question" rows="5" cols="50"></textarea>
		<br> <br> <input type="submit" value="Submit">
	</form>
	<br>
	<br>
	</div>

	<div class="search">
		<h4>Search for Questions</h4>
		<form class="search-form" action="ForumSearchBarController"
			method="POST">
			<input id="searchBar" name="searchBar" type="text" size="80"
				placeholder="Search by keyword or phrase"> <input
				type="submit" value="Submit">
		</form>
	</div>
	<div id="searchResults">
		<%
			if (request.getAttribute("valid-questions") != null) {
			ArrayList<String> std = (ArrayList<String>) request.getAttribute("valid-questions");
			ArrayList<String> std1 = (ArrayList<String>) request.getAttribute("valid-answers");
		%>
		<table>
			<tr>
				<th>Questions that match your query</th>
				<th>Answers (if answered)</th>
			</tr>
			<%
				for (int i = 0; i<std.size(); i++) {
			%>
			<tr>
				<td><%=std.get(i)%></td>
				<td><%=std1.get(i)%></td>
			</tr>
			<%}%>
			</table>
			<%
				}
			%>
		
	</div>
	<br>
	<div class="center" id="questionTable">
		<h4>FAQ</h4>
		<table>
			<tr>
				<th>Question</th>
				<th>Answer</th>

			</tr>
			<%
				try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
				String customerInfo = "SELECT * FROM forum;";
				ResultSet customerInfoResult = stmt.executeQuery(customerInfo);
				while (customerInfoResult.next()) {
			%>
			<tr>
				<td><%=customerInfoResult.getString(1)%></td>
				<% if(customerInfoResult.getString(2)==null){ %>
					<td></td>
				<%} else{%>
				<td><%=customerInfoResult.getString(2)%></td>
				<%}%>
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

</body>
</html>