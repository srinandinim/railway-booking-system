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
public class ListTrainSchedulesController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String origin = request.getParameter("Origin");
		String destination = request.getParameter("Destination");
		
		
		Statement stmt;
		try {
			stmt=con.createStatement();
			String getSQL = null;
			if(origin==null && destination!=null) {
				getSQL = "SELECT * from train_schedule WHERE BINARY destination_station_id=\'" + destination + "\';";
			}
			else if(origin!=null && destination==null) {
				getSQL = "SELECT * from train_schedule WHERE BINARY origin_station_id=\'" + origin + "\';";
			}
			else if(origin!=null && destination!=null) {
				getSQL = "SELECT * from train_schedule WHERE BINARY origin_station_id=\'" + origin + "\' AND destination_station_id=\'"+ destination + "\';";
			}
			if(getSQL!=null) {
				ResultSet result = stmt.executeQuery(getSQL);
				ArrayList<TrainSchedule> schedules = new ArrayList<TrainSchedule>();
				while(result.next()) {
					String originName = null;
					String destinationName = null;
					Statement stmt1 = con.createStatement();
					
					String getOrigin = "SELECT name FROM station WHERE BINARY station_id =" + result.getString(5) + ";";
					ResultSet result1 = stmt1.executeQuery(getOrigin);
					while(result1.next()) {
						originName = result1.getString(1);
					}
					originName = "Station ID: " + result.getString(5) + ", Station Name: " + originName;
					
					String getDestination = "SELECT name FROM station WHERE BINARY station_id =" + result.getString(6) + ";";
					ResultSet result2 = stmt1.executeQuery(getDestination);
					while(result2.next()) {
						destinationName = result2.getString(1);
					}
					destinationName = "Station ID: " + result.getString(6) + ", Station Name: " + destinationName;
					
					schedules.add(new TrainSchedule(result.getString(1), result.getString(2),result.getString(3),result.getString(4),originName, 
							destinationName, result.getString(7)));
				}
				request.setAttribute("valid-schedules", schedules);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}
		
		RequestDispatcher rd = request.getRequestDispatcher("customerRep.jsp");
		rd.forward(request, response);
//		response.sendRedirect("customerRep.jsp");
		db.closeConnection(con);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
