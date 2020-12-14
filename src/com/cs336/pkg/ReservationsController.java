package com.cs336.pkg;

import java.io.*;
import java.sql.*;

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
		// TODO Auto-generated method stub
		
		System.out.println (request.getParameter("origin-option"));
		System.out.println (request.getParameter("dest-option"));
		response.sendRedirect("reservations.jsp");
		
		try {
			
			String transitLine = request.getParameter("transitline");
			
			System.out.println(transitLine);
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			Statement stmt = con.createStatement();
			
			//int originStationId = Integer.parseInt(request.getParameter("origin"));
			
		}
		
		catch (Exception e) {
			System.out.print(e);
		}
		
		
		
	}

}