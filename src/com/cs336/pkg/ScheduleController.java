package com.cs336.pkg;

import java.io.*;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * Servlet implementation class ScheduleController
 */
public class ScheduleController extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub		
		
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			Statement stmt = con.createStatement();
			
			int originStationId = Integer.parseInt(request.getParameter("origin"));
			int destStationId = Integer.parseInt(request.getParameter("dest"));
			String travelDate = request.getParameter("travelDate");
			
			String trainQuery = "SELECT train_schedule.transit_line, origin.train_id, origin.dept, dest.dept FROM (SELECT stops.train_id train_id, stops.departure_time dept FROM stops WHERE stops.station_id="+originStationId+") origin, (SELECT stops.train_id train_id, stops.departure_time dept FROM stops WHERE stops.station_id="+destStationId+") dest, train_schedule WHERE origin.train_id = dest.train_id AND origin.train_id = train_schedule.train_id AND origin.dept < dest.dept AND DATE(origin.dept) = \""+travelDate+"\"";
									
			ResultSet resultSet = stmt.executeQuery(trainQuery);
			ArrayList<Train> trains = new ArrayList<>();
			if (!resultSet.isBeforeFirst()) {
				System.out.println ("There is no valid schedules");
			}
			
			while (resultSet.next()) {
				trains.add(new Train(resultSet.getString(1), resultSet.getInt(2), resultSet.getString(3), resultSet.getString(4)));				
			}
			for (int i = 0; i < trains.size(); i++) {
				String stopQuery = "SELECT stat.name FROM stops s, station stat WHERE s.train_id ="+trains.get(i).getTrainId()+" AND s.departure_time>\""+trains.get(i).getOrigin()+"\" AND s.departure_time<\""+trains.get(i).getDestination()+"\" AND s.station_id = stat.station_id";
				ResultSet stopSet = stmt.executeQuery(stopQuery);
				String allStops = "";
				while (stopSet.next()) {
					allStops += stopSet.getString(1) + ", ";
				}
				if (allStops.length() > 0)
					trains.get(i).setStops(allStops.substring(0, allStops.length()-2));
			}
			
			for (int i = 0; i < trains.size(); i++) {
				String fareQuery = "select t3.pps*t4.stopCount from (select t2.fare/t1.totCount pps from (select count(*) totCount from stops s where s.train_id = "+trains.get(i).getTrainId()+") t1, (select fare from train_schedule ts where ts.train_id = "+trains.get(i).getTrainId()+") t2) t3, (select count(*)+1 stopCount from stops s where s.train_id = "+trains.get(i).getTrainId()+" and s.departure_time > \""+trains.get(i).getOrigin()+"\" and s.departure_time < \""+trains.get(i).getDestination()+"\") t4;";
				ResultSet fareSet = stmt.executeQuery(fareQuery);
				fareSet.next();
				trains.get(i).setFare(fareSet.getInt(1));
			}
			
			String originQuery = "SELECT name FROM station WHERE station_id=" + originStationId;
			resultSet = stmt.executeQuery(originQuery);
			resultSet.next();
			request.setAttribute("origin", resultSet.getString(1));
			
			String destQuery = "SELECT name FROM station WHERE station_id=" + destStationId;
			resultSet = stmt.executeQuery(destQuery);
			resultSet.next();
			request.setAttribute("destination", resultSet.getString(1));
			
			request.setAttribute("travelDate", travelDate);
			request.setAttribute("valid-trains", trains);
			
			RequestDispatcher rd = request.getRequestDispatcher("schedule.jsp");
			rd.forward(request, response);
			db.closeConnection(con);
		}
			
		catch (Exception e) {
			System.out.print(e);
		}
	}

}

