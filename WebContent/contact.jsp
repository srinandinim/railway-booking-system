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
.search {
	text-align: center;
	list-style-position: inside;
	margin-left: auto;
	margin-right: auto;
}
.button {
	width: 10%;
	padding: 15px;
	background-color: #38586b;
	border: 0;
	box-sizing: border-box;
	cursor: pointer;
	font-weight: bold;
	font-size: 14px;
	color: #ffffff;
}
#myInput {
	background-image: url('images/search.svg') !important;
	background-position: 10px 12px;
	background-repeat: no-repeat;
	width: 50%;
	font-size: 16px;
	padding: 12px 20px 12px 40px;
	border: 1px solid #ddd;
	margin-bottom: 12px;
}
#myContent {
	padding-left: 20px;
	padding-right: 20px;
}
#questionTable thead.header {
	background-color: #38586b !important;
	color: #edf2f4 !important
}
#questionTable tr:hover {
	background-color: rgba(0, 162, 255, 0.263);
}
</style>
<title>Contact Us</title>
</head>
<body>
	<br>
	<div id="myContent">
		<h4 class="center" style="font-weight:bold">Frequently Asked Questions</h4>
		<br>
		<input class="form-control" type="text" id="myInput"
			placeholder="Search for a question...">

		<div id="questionTable">
			
			<table class="table table-bordered table-striped">
				<thead class="header">
					<th>Question</th>
					<th>Answer</th>
				</thead>
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
		
		<%
			if (session.getAttribute("isEmployee") != null && ((boolean) session.getAttribute("isEmployee"))) {
		%>
		<br>
		<!-- This only appears if employee is logged in -->
		<div id="replyQuestion">
			<h4 class="subheading">Reply to a Question</h4>
			<p>Copy paste the question you'd like to respond to in the "Question"
			box. Then, insert the answer to the question in the "Answer" box. Make
			sure the question you're replying to already exists. You can also use
			this form to update a previous answer.</p>
			<form action="ReplyQuestionController" method="POST">
				<textarea class="longInput" maxlength="255" id="question"
					name="question" rows="5" cols="24" placeholder="Question" required></textarea>
				<textarea class="longInput" maxlength="255" id="answer" name="answer"
					rows="5" cols="24" placeholder="Answer" required
					placeholder="Answer" required></textarea>
				<br>
				<button class="button" type="submit" formmethod="POST">Answer</button>
			</form>
		</div>
		<br>
		<%}%>

		<br>
		<div id="askQuestion">
			<h4 class="subheading">New Question</h4>
			<p> If you are question is not found above, please enter it here. A member of our staff will answer it shortly. </p>
			<form action="ForumController" method="POST">
				<textarea class="longInput" maxlength="255" id="question"
					name="question" rows="5" cols="50" required></textarea>
				<br>
				<input class="button" type="submit" value="Submit">
			</form>
			<br> <br>
		</div>
	</div>
	<br>

	<script>
        $(document).ready(function(){
            $("#myInput").on("keyup", function() {
                var value = $(this).val().toLowerCase();
                $("#questionTable tr").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
    </script>
</body>
</html>