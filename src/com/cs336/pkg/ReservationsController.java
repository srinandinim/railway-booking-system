package com.cs336.pkg;

import java.io.*;
import java.sql.*;
import java.time.Period;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ReservationsController
 */
public class ReservationsController extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		
		
		
		if (request.getSession().getAttribute("isLoggedIn") == null || !((boolean) request.getSession().getAttribute("isLoggedIn")) ) {
			response.sendRedirect("reservations.jsp");
			return;
		}
		
		String t1 = request.getParameter("origin-option");
		String t2 = request.getParameter("dest-option"); // saved in schedule.jsp
		
		if (t1 == null)
			return;
		
		String[] train1 = t1.split("//");
		String[] train2 = null;
		
		if (t2 != null)
			train2 = t2.split("//");
		
		String fare_type = "one-way";
		if (t2 != null) 
			fare_type = "round-trip";
		String date_made = java.time.LocalDate.now().toString();//
		double total_fare = Double.parseDouble(train1[6]);
		int origin = Integer.parseInt(train1[2]);
		String origin_datetime = train1[3];
		int destination = Integer.parseInt(train1[4]);
		String destination_datetime = train1[5];
		String username = (String) request.getSession().getAttribute("username");
		String transit_line = train1[0];
		int train_id = Integer.parseInt(train1[1]);
		
		//TODO: invalid reservation
		//if (t2 != null && destination_datetime > train2[3]) { // if train1 destination < train2 origin time
		//	response.sendRedirect("schedule.jsp");
		//	return;	
		//}
		
		response.sendRedirect("reservations.jsp");
		
		
		try {			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			
			String discountQuery = "SELECT birthday, disabled FROM customer WHERE username=\'" +username+ "\'";
			ResultSet resultSet = stmt.executeQuery(discountQuery);
			
			double discount = 0;
			if (resultSet.next()) {
				if (resultSet.getInt(2) == 1) {
					discount = 0.5;
				}
				else {
					int age = Period.between(resultSet.getDate(1).toLocalDate(), java.time.LocalDate.now()).getYears();
					
					if (age < 18)
						discount = 0.25;
					else if (age >= 65)
						discount = 0.35;	
				}
			}
			
			total_fare = total_fare * (1-discount);
			
			String insertQuery = "INSERT INTO reservation VALUES(NULL, \'" +fare_type+ "\', \'" +date_made+ "\', "+total_fare+", " +origin+ ", \'" +origin_datetime+ "\', " +destination+ ", \'" +destination_datetime+ "\', \'" +username+ "\', \'" +transit_line+ "\', " +train_id+ ");";
			
			PreparedStatement insertRes = con.prepareStatement(insertQuery);
			insertRes.executeUpdate();
			
			if (train2 != null) {
				total_fare = Double.parseDouble(train2[6]);
				origin = Integer.parseInt(train2[2]);
				origin_datetime = train2[3];
				destination = Integer.parseInt(train2[4]);
				destination_datetime = train2[5];
				transit_line = train2[0];
				train_id = Integer.parseInt(train2[1]);
				
				total_fare = total_fare * (1-discount);
				
				String insert2Query = "INSERT INTO reservation VALUES(NULL, \'" +fare_type+ "\', \'" +date_made+ "\', "+total_fare+", " +origin+ ", \'" +origin_datetime+ "\', " +destination+ ", \'" +destination_datetime+ "\', \'" +username+ "\', \'" +transit_line+ "\', " +train_id+ ");"; 
				
				PreparedStatement insertRes2 = con.prepareStatement(insert2Query);
				insertRes2.executeUpdate();
			}
			
						
			db.closeConnection(con);
			
		}
		
		catch (Exception e) {
			System.out.print(e);
		}
		
		
		
	}

}