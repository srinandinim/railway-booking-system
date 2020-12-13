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
public class AdminRevenueListingController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String transitLine = request.getParameter("transitLine");
		String customerName = request.getParameter("customerName");
		
		
		Statement stmt;
		try {
			stmt=con.createStatement();
			String getSQL = null;
			if(transitLine==null && customerName!=null) {
				getSQL = "SELECT customer_username, sum(total_fare) FROM reservation GROUP BY customer_username;";
				ResultSet result = stmt.executeQuery(getSQL);
				ArrayList<Integer> revenues = new ArrayList<Integer>();
				ArrayList<String> customerNames = new ArrayList<String>();
				while(result.next()) {
					customerNames.add(result.getString(1));
					revenues.add(result.getInt(2));
				}
				request.setAttribute("valid-revenues", revenues);
				request.setAttribute("valid-customerUsernames", customerNames);
			}
			else if(transitLine!=null && customerName==null) {
				getSQL = "SELECT transit_line, sum(total_fare) FROM reservation GROUP BY transit_line;";
				ResultSet result = stmt.executeQuery(getSQL);
				ArrayList<Integer> revenues = new ArrayList<Integer>();
				ArrayList<String> transitLines = new ArrayList<String>();
				while(result.next()) {
					transitLines.add(result.getString(1));
					revenues.add(result.getInt(2));
				}
				request.setAttribute("valid-revenues", revenues);
				request.setAttribute("valid-transitLines", transitLines);
			}
			else if(transitLine!=null && customerName!=null) {
				getSQL = "SELECT customer_username, transit_line, sum(total_fare) FROM reservation GROUP BY customer_username, transit_line;";
				ResultSet result = stmt.executeQuery(getSQL);
				ArrayList<Integer> revenues = new ArrayList<Integer>();
				ArrayList<String> customerUsernames = new ArrayList<String>();
				ArrayList<String> transitLines = new ArrayList<String>();
				while(result.next()) {
					customerUsernames.add(result.getString(1));
					transitLines.add(result.getString(2));
					revenues.add(result.getInt(3));
				}
				request.setAttribute("valid-revenues", revenues);
				request.setAttribute("valid-customerUsernamesBoth", customerUsernames);
				request.setAttribute("valid-transitLinesBoth", transitLines);
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

		response.sendRedirect("admin.jsp");
	}

}
