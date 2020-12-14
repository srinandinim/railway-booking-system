package com.cs336.pkg;

import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * Servlet implementation class RegistrationController
 */
public class RegistrationController extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String birthday = request.getParameter("dob");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String disabled = request.getParameter("disabled");
		
		int disabledBoolean = 0;
		if(disabled!=null && disabled.equals("Yes")){
			disabledBoolean=1;
		}
		
		//checks string lengths for firstName, lastName, email, username, password
		if(firstName.length()>50){
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		if(lastName.length()>50){
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		if(email.length()>200){
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		if(username.length()>50){
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		if(password.length()>50){
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		
		//here to line 110 makes sure the birthday was inputted correctly
		
		if(birthday.length()!=10){
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		
		
		if(birthday.charAt(4)!='-' || birthday.charAt(7)!='-'){
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		
		for(int i = 0; i<birthday.length(); i++){
			if(i==4 || i==7) continue;
			if(!Character.isDigit(birthday.charAt(i))){
				response.sendRedirect("registrationFailed.jsp");
				return;
			}
		}
		
		int year = Integer.valueOf(birthday.substring(0, 4));
		int month = Integer.valueOf(birthday.substring(5, 7));
		int day = Integer.valueOf(birthday.substring(8, 10));
		
		if(Integer.valueOf(birthday.substring(0, 4))<1890 || Integer.valueOf(birthday.substring(0, 4))>2020){
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		
		if(Integer.valueOf(birthday.substring(5, 7))>12 || Integer.valueOf(birthday.substring(5, 7))<1){
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		
		if(month==4 || month==6 || month==9 || month==11){
			if(day>30 || day<=0){
				response.sendRedirect("registrationFailed.jsp");
				return;
			}
		}
		else if(month==2){
			if(year%4==0){
				if(day>29 || day<=0){
					response.sendRedirect("registrationFailed.jsp");
					return;
				}
			}
			else{
				if(day>28 || day<=0){
					response.sendRedirect("registrationFailed.jsp");
					return;
				}
			}
		}
		else{
			if(day>31 || day<=0){
				response.sendRedirect("registrationFailed.jsp");
				return;
			}
		}
		//end of checking birthday
		
		//check to make sure username is unique
		String usernameChecker = "SELECT * FROM customer WHERE BINARY username=" + "\'" + username + "\'";
		Statement stmt;
		try {
			stmt = con.createStatement();
			ResultSet result = stmt.executeQuery(usernameChecker);
			boolean isValid = result.next();
	
			
			if(isValid){
				response.sendRedirect("registrationFailed.jsp");
				return;
			}
		
			String sqlString = "Insert INTO customer VALUES (\'" + username + "\', \'" + firstName + "\', \'" + lastName + 
					"\', \'" + email + "\', \'" + password + "\', \'" + birthday + "\', " + disabledBoolean + ");";
					
			PreparedStatement insertCust = con.prepareStatement(sqlString);
			insertCust.executeUpdate();
		
	
			db.closeConnection(con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HttpSession session=request.getSession(true);
		
		session.setAttribute("name", firstName);
		session.setAttribute("email", email);
		session.setAttribute("username", username);
		
		response.sendRedirect("reservations.jsp");
	}

}

