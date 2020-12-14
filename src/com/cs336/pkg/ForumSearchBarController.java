package com.cs336.pkg;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AdminRevenueListingController
 */
public class ForumSearchBarController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String searchBar = request.getParameter("searchBar");
		String search = searchBar.toLowerCase();
		System.out.println("Search Value: " + search);

		// System.out.println(question);
		// System.out.println(searchBar);

		Statement stmtSearch;
		try {
			System.out.println("HI");
			stmtSearch = con.createStatement();
			StringTokenizer tokenSearchVals = new StringTokenizer(search, " ", false);
			HashSet<String> uniqueQuestions = new HashSet<String>();

			while (tokenSearchVals.hasMoreTokens()) {
				String searchVal = tokenSearchVals.nextToken();
				String searchChecker = "SELECT * FROM forum WHERE LOWER(question) LIKE " + "\'%" + searchVal + "%\';";
				ResultSet result = stmtSearch.executeQuery(searchChecker);
				while (result.next()) {
					uniqueQuestions.add(result.getString(1));
				}
			}
			ArrayList<String> questions = new ArrayList<String>(uniqueQuestions);
			ArrayList<String> answers = new ArrayList<String>();
			for (int i = 0; i < questions.size(); i++) {
				String searchChecker = "SELECT * FROM forum WHERE question=\'" + questions.get(i) + "\';";
				ResultSet result = stmtSearch.executeQuery(searchChecker);
				while (result.next()) {
					if (result.getString(2) == null) {
						answers.add("");
					} else {
						answers.add(result.getString(2));
					}
				}
			}
			request.setAttribute("valid-questions", questions);
			request.setAttribute("valid-answers", answers);
			RequestDispatcher rd = request.getRequestDispatcher("contact.jsp");
			rd.forward(request, response);
			db.closeConnection(con);

//				System.out.println("IN IF");
//				response.sendRedirect("questionFailed.jsp");
//				return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		// response.sendRedirect("contact.jsp");
	}

}
