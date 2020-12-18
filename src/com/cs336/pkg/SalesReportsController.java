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
			String begOfMonth = year + "-" + month + "-" + "01";

			Statement stmt;
			try {
				stmt = con.createStatement();
				String getFareSQL = "SELECT sum(total_fare) sum FROM reservation WHERE DATE(reservation_origin_datetime) >= \""
						+ begOfMonth + "\" AND DATE(reservation_origin_datetime) <= LAST_DAY(\"" + begOfMonth + "\");";
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