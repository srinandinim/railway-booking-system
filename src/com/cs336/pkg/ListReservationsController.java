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
public class ListReservationsController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String transitLine = request.getParameter("TransitLine");
		String userName = request.getParameter("customerUserName");
		String month = request.getParameter("reservationMonth");
		String sqlYear = request.getParameter("reservationYear");
		int sqlMonth = 0;
		if(month.equals("January")) {
			sqlMonth=1;
		}
		else if(month.equals("February")) {
			sqlMonth=2;
		}
		else if(month.equals("March")) {
			sqlMonth=3;
		}
		else if(month.equals("April")) {
			sqlMonth=4;
		}
		else if(month.equals("May")) {
			sqlMonth=5;
		}
		else if(month.equals("June")) {
			sqlMonth=6;
		}
		else if(month.equals("July")) {
			sqlMonth=7;
		}
		else if(month.equals("August")) {
			sqlMonth=8;
		}
		else if(month.equals("September")) {
			sqlMonth=9;
		}
		else if(month.equals("October")) {
			sqlMonth=10;
		}
		else if(month.equals("November")) {
			sqlMonth=11;
		}
		else {
			sqlMonth=12;
		}
		
		Statement stmt;
		try {
			stmt=con.createStatement();
			String getSQL = null;
			if(transitLine==null && userName!=null) {
				getSQL = "SELECT * FROM reservation WHERE BINARY customer_username = \'" + userName + "\'"+ " AND BINARY MONTH(reservation_origin_datetime)=" + sqlMonth + " AND YEAR(reservation_origin_datetime)=" + sqlYear +";";
			}
			else if(transitLine!=null && userName==null) {
				getSQL = "SELECT * FROM reservation WHERE BINARY transit_line = \'" + transitLine + "\'"+ " AND BINARY MONTH(reservation_origin_datetime)=" + sqlMonth + " AND YEAR(reservation_origin_datetime)=" + sqlYear +";";
			}
			else if(transitLine!=null && userName!=null) {
				getSQL = "SELECT * FROM reservation WHERE BINARY transit_line = \'" + transitLine + "\' AND customer_username = \'" + userName + "\'"+ " AND BINARY MONTH(reservation_origin_datetime)=" + sqlMonth + " AND YEAR(reservation_origin_datetime)=" + sqlYear +";";
			}
			if(getSQL!=null) {
				ResultSet result = stmt.executeQuery(getSQL);
				ArrayList<Reservation> reservations = new ArrayList<Reservation>();
				while(result.next()) {
					String reservationOrigin = null;
					String reservationDestination = null;
					Statement stmt1 = con.createStatement();
					
					String getOrigin = "SELECT name FROM station WHERE BINARY station_id =" + result.getInt(5)  + ";";
					ResultSet result1 = stmt1.executeQuery(getOrigin);
					while(result1.next()) {
						reservationOrigin = result1.getString(1);
					}
					reservationOrigin = "Station Name: " + reservationOrigin + ", Station ID: " + result.getString(5);
					
					String getDestination = "SELECT name FROM station WHERE BINARY station_id =" + result.getInt(7) +  ";";
					ResultSet result2 = stmt1.executeQuery(getDestination);
					while(result2.next()) {
						reservationDestination = result2.getString(1);
					}
					reservationDestination = "Station Name: " + reservationDestination + ", Station ID: " + result.getString(7);
					
					reservations.add(new Reservation(result.getString(1), result.getString(2),result.getString(3),result.getString(4),reservationOrigin, 
							result.getString(6), reservationDestination, result.getString(8),result.getString(9),result.getString(10),result.getString(11)));
				}
				request.setAttribute("valid-reservations", reservations);
				request.setAttribute("transit-line", transitLine);
				request.setAttribute("user", userName);
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
