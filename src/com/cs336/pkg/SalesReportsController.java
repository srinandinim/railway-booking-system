package com.cs336.pkg;

import java.io.*;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SalesReportsController
 */
public class SalesReportsController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			String month = request.getParameter("Month");
			String year = request.getParameter("Year");
			request.setAttribute("salesDataMonth", month);
			request.setAttribute("salesDataYear", year);
			int SQLyear = Integer.valueOf(year);
			int SQLmonth = 0;
			if (month.equals("January")) {
				SQLmonth = 1;
			} else if (month.equals("February")) {
				SQLmonth = 2;
			} else if (month.equals("March")) {
				SQLmonth = 3;
			} else if (month.equals("April")) {
				SQLmonth = 4;
			} else if (month.equals("May")) {
				SQLmonth = 5;
			} else if (month.equals("June")) {
				SQLmonth = 6;
			} else if (month.equals("July")) {
				SQLmonth = 7;
			} else if (month.equals("August")) {
				SQLmonth = 8;
			} else if (month.equals("September")) {
				SQLmonth = 9;
			} else if (month.equals("October")) {
				SQLmonth = 10;
			} else if (month.equals("November")) {
				SQLmonth = 11;
			} else {
				SQLmonth = 12;
			}

			Statement stmt;
			try {
				stmt = con.createStatement();
				String getFareSQL = "SELECT sum(total_fare) FROM reservation WHERE BINARY MONTH(date_made)=" + SQLmonth
						+ " AND YEAR(date_made)=" + SQLyear + ";";
				ResultSet result = stmt.executeQuery(getFareSQL);
				while (result.next()) {
					if (result.getString(1) != null) {
						request.setAttribute("salesData", result.getString(1));
					} else {
						request.setAttribute("salesData", "0");
					}
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();

			}

			RequestDispatcher rd = request.getRequestDispatcher("admin.jsp");
			rd.forward(request, response);

			db.closeConnection(con);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}