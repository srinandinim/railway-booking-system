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
 * Servlet implementation class RegistrationController
 */
public class ListReservationsController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String transitLine = request.getParameter("TransitLine");
		String userName = request.getParameter("customerUserName");
		
		
		Statement stmt;
		try {
			stmt=con.createStatement();
			String getSQL = null;
			if(transitLine==null && userName!=null) {
				getSQL = "SELECT * FROM reservation WHERE customer_username = \'" + userName + "\';";
			}
			else if(transitLine!=null && userName==null) {
				getSQL = "SELECT * FROM reservation WHERE transit_line = \'" + transitLine + "\';";
			}
			else if(transitLine!=null && userName!=null) {
				getSQL = "SELECT * FROM reservation WHERE transit_line = \'" + transitLine + "\' AND customer_username = \'" + userName + "\';";
			}
			if(getSQL!=null) {
				ResultSet result = stmt.executeQuery(getSQL);
				ArrayList<Reservation> reservations = new ArrayList<Reservation>();
				while(result.next()) {
					String reservationOrigin = null;
					String reservationDestination = null;
					Statement stmt1 = con.createStatement();
					
					String getOrigin = "SELECT name FROM station WHERE station_id =" + result.getInt(5) + ";";
					ResultSet result1 = stmt1.executeQuery(getOrigin);
					while(result1.next()) {
						reservationOrigin = result1.getString(1);
					}
					
					String getDestination = "SELECT name FROM station WHERE station_id =" + result.getInt(6) + ";";
					ResultSet result2 = stmt1.executeQuery(getDestination);
					while(result2.next()) {
						reservationDestination = result2.getString(1);
					}
					
					reservations.add(new Reservation(result.getString(1), result.getString(2),result.getString(3),result.getString(4),reservationOrigin, 
							reservationDestination, result.getString(7),result.getString(8),result.getString(9),result.getString(10)));
				}
				request.setAttribute("valid-reservations", reservations);
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

