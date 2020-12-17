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

		String trainStop = request.getParameter("trainStop");
		System.out.println(trainStop);
		
		
		Statement stmt;
		try {
			String getSql = "SELECT stops.transit_line, stops.train_ID, stops.station_id, ts.origin_station_id, ts.destination_station_id, ts.departure_datetime, ts.arrival_datetime "
					+ "FROM train_schedule ts, stops WHERE stops.station_id = "+ trainStop +" AND ts.transit_line = stops.transit_line AND ts.train_id = stops.train_id;";
					
			stmt=con.createStatement();
			ResultSet result = stmt.executeQuery(getSql);
			ArrayList<TrainSchedule> schedules = new ArrayList<TrainSchedule>();
				while(result.next()) {	
					schedules.add(new TrainSchedule(result.getString(1), result.getString(2),result.getString(3),result.getString(4),result.getString(5), result.getString(6), result.getString(7)));	
				}
				

			request.setAttribute("valid-schedules", schedules);
			
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
