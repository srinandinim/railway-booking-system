
package com.cs336.pkg;

import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AddCustomerController
 */
public class CusRepTrainScheduleController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		String departureDateTime = request.getParameter("departureDateTime");
		String arrivalDateTime = request.getParameter("arrivalDateTime");
		String fare = request.getParameter("fare");
		String originStationID = request.getParameter("originStationID");
		String destinationStationID = request.getParameter("destinationStationID");
		String trainID = request.getParameter("trainID");
		
		if(request.getParameter("newTransitLine")!=null) {
			String transitLine = request.getParameter("newTransitLine");
			Statement stmt;
			try {
				stmt = con.createStatement();
				String sqlString = "Insert INTO train_schedule VALUES (\'" + transitLine + "\', \'" + departureDateTime + "\', \'" +
				arrivalDateTime + "\', \'" + fare + "\', \'" + originStationID + "\', \'" + destinationStationID + "\', \'" + trainID + "\'" + ");";
				PreparedStatement insertTrainSchedule = con.prepareStatement(sqlString);
				insertTrainSchedule.executeUpdate();
			} catch(SQLException e) {
				response.sendRedirect("cusRepTrainScheduleFailed.jsp");
				e.printStackTrace();
				return;
			}
		} else if(request.getParameter("editTransitLine")!=null) {
			String transitLine = request.getParameter("editTransitLine");
			if (departureDateTime.length()!=0) {
				try {

					String sqlString = "UPDATE train_schedule SET departure_datetime= \'" + departureDateTime + "\' WHERE BINARY transit_line = \'" + transitLine
							+ "\' AND train_id=\'" + trainID + "\';";
					PreparedStatement editTrainSchedule = con.prepareStatement(sqlString);
					editTrainSchedule.executeUpdate();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					response.sendRedirect("cusRepTrainScheduleFailed.jsp");
					e.printStackTrace();
					return;
				}
			}
			if (arrivalDateTime.length()!=0) {
				try {

					String sqlString = "UPDATE train_schedule SET arrival_datetime= \'" + arrivalDateTime + "\' WHERE BINARY transit_line = \'" + transitLine
							+ "\' AND train_id=\'" + trainID + "\';";
					PreparedStatement editTrainSchedule = con.prepareStatement(sqlString);
					editTrainSchedule.executeUpdate();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					response.sendRedirect("cusRepTrainScheduleFailed.jsp");
					e.printStackTrace();
					return;
				}
			}
			if (fare.length()!=0) {
				try {

					String sqlString = "UPDATE train_schedule SET fare= \'" + fare + "\' WHERE BINARY transit_line = \'" + transitLine
							+ "\' AND train_id=\'" + trainID + "\';";
					PreparedStatement editTrainSchedule = con.prepareStatement(sqlString);
					editTrainSchedule.executeUpdate();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					response.sendRedirect("cusRepTrainScheduleFailed.jsp");
					e.printStackTrace();
					return;
				}
			}
			if (originStationID.length()!=0) {
				try {

					String sqlString = "UPDATE train_schedule SET origin_station_id= \'" + originStationID + "\' WHERE BINARY transit_line = \'" + transitLine
							+ "\' AND train_id=\'" + trainID + "\';";
					PreparedStatement editTrainSchedule = con.prepareStatement(sqlString);
					editTrainSchedule.executeUpdate();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					response.sendRedirect("cusRepTrainScheduleFailed.jsp");
					e.printStackTrace();
					return;
				}
			}
			if (destinationStationID.length()!=0) {
				try {

					String sqlString = "UPDATE train_schedule SET destination_station_id= \'" + destinationStationID + "\' WHERE BINARY transit_line = \'" + transitLine
							+ "\' AND train_id=\'" + trainID + "\';";
					PreparedStatement editTrainSchedule = con.prepareStatement(sqlString);
					editTrainSchedule.executeUpdate();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					response.sendRedirect("cusRepTrainScheduleFailed.jsp");
					e.printStackTrace();
					return;
				}
			}
		} else if(request.getParameter("deleteTransitLine")!=null) {
			try {
				String transitLine = request.getParameter("deleteTransitLine");
				
				String sqlString = "DELETE FROM reservation WHERE BINARY transit_line = \'" + transitLine + "\' AND train_id=\'" + trainID + "\';";
				PreparedStatement deleteTrainSchedule = con.prepareStatement(sqlString);
				deleteTrainSchedule.executeUpdate();
				
				sqlString = "DELETE FROM stops WHERE BINARY transit_line = \'" + transitLine + "\' AND train_id=\'" + trainID + "\';";
				deleteTrainSchedule = con.prepareStatement(sqlString);
				deleteTrainSchedule.executeUpdate();
				
				sqlString = "DELETE FROM train_schedule WHERE BINARY transit_line = \'" + transitLine + "\' AND train_id=\'" + trainID + "\';";
				deleteTrainSchedule = con.prepareStatement(sqlString);
				deleteTrainSchedule.executeUpdate();
				
			} catch(SQLException e) {
				response.sendRedirect("cusRepTrainScheduleFailed.jsp");
				e.printStackTrace();
				return;
			}
		}
		
		
		

		db.closeConnection(con);

		response.sendRedirect("customerRep.jsp");
	}

}