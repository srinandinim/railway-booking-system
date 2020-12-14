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
 * Servlet implementation class AdminRevenueListingController
 */
public class ForumController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		
		String question = request.getParameter("question");
		
		
		//System.out.println(question);
		//System.out.println(searchBar);
		
		Statement stmtCheckUser;
		try {
			stmtCheckUser = con.createStatement();
			String questionChecker = "SELECT * FROM forum WHERE question=" + "\'" + question + "\'";
			ResultSet result = stmtCheckUser.executeQuery(questionChecker);
			boolean isValid = result.next();
			if (isValid) {
				response.sendRedirect("questionFailed.jsp");
				return;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}
		
		Statement stmt;
		try {
			stmt = con.createStatement();

			String sqlString = "Insert INTO forum(question) VALUES (\'" + question + "\'" + ");";
			PreparedStatement insertQuestion = con.prepareStatement(sqlString);
			insertQuestion.executeUpdate();

			db.closeConnection(con);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
		
		response.sendRedirect("contact.jsp");
	}

}
