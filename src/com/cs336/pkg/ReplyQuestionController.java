package com.cs336.pkg;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ListReservationsController
 */
public class ReplyQuestionController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String question = request.getParameter("question");
		String answer = request.getParameter("answer");
		
		
		Statement stmt;
		try {
			stmt=con.createStatement();
			String getSQL = "UPDATE forum SET answer=\'" + answer + "\' WHERE question=\'" + question + "\';";
			PreparedStatement answerQuestion = con.prepareStatement(getSQL);
			answerQuestion.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}
		
		db.closeConnection(con);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.sendRedirect("contact.jsp");
	}

}
