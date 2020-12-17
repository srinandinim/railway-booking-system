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
 * Servlet implementation class ActiveTrainLinesController
 */
public class ActiveTrainLinesController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			String month = request.getParameter("Month");
			String year = request.getParameter("Year");
			request.setAttribute("transitLineMonth", month);
			request.setAttribute("transitLineYear", year);
			String begOfMonth = year + "-" + month + "-" + "01";

			Statement stmt;
			try {
				stmt = con.createStatement();
				String query = "SELECT transit_line, count(*) appearances FROM reservation WHERE DATE(reservation_origin_datetime) >= \""
						+ begOfMonth + "\" AND DATE(reservation_origin_datetime) <= LAST_DAY(\"" + begOfMonth
						+ "\") GROUP BY transit_line ORDER BY appearances DESC LIMIT 5;";

				ResultSet result = stmt.executeQuery(query);
				ArrayList<String> transitLines = new ArrayList<>();
				while (result.next()) {
					transitLines.add(result.getString(1));
				}
				request.setAttribute("active-transit-lines", transitLines);
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