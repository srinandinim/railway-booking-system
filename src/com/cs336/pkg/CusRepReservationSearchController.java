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
public class CusRepReservationSearchController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String reservationDate = request.getParameter("reservationDate");
		String transitLine = request.getParameter("transitLine");
		
		
		Statement stmt;
		try {
			stmt=con.createStatement();
			String getSQL = "SELECT DISTINCT customer_username FROM reservation WHERE DATE(reservation_destination_datetime) = \'" + reservationDate + 
					"\' AND transit_line=\'" + transitLine + "\';";
				ResultSet result = stmt.executeQuery(getSQL);
				ArrayList<String> customers = new ArrayList<String>();
				while(result.next()) {
					customers.add(result.getString(1));
				}
				request.setAttribute("valid-customers", customers);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}
		
		RequestDispatcher rd = request.getRequestDispatcher("customerRep.jsp");
		rd.forward(request, response);
//		response.sendRedirect("customerRep.jsp");
		db.closeConnection(con);

		}catch(

	Exception e)
	{
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}

}
