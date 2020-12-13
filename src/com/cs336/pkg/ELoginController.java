package com.cs336.pkg;

import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * Servlet implementation class ELoginController
 */
public class ELoginController extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub		
		
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			Statement stmt = con.createStatement();

			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			String correctPassword = "SELECT password FROM employee WHERE username=" + "\'" + username + "\'" + " LIMIT 1";
			
			ResultSet result = stmt.executeQuery(correctPassword);
			boolean isValid = result.next();
			if(!isValid || !password.equals(result.getString("password"))){
				System.out.println("Username or password is incorrect.");
				response.sendRedirect("loginFailed.jsp");
			}
			else {
				System.out.println("You have been logged in!");
				
				String nameQuery = "SELECT first_name FROM employee WHERE username=" + "\'" + username + "\'" + " LIMIT 1";
				ResultSet nameResult = stmt.executeQuery(nameQuery);
				
				nameResult.next();
				HttpSession session=request.getSession(true);
				System.out.println(nameResult.getString("first_name"));
				session.setAttribute("name", nameResult.getString("first_name"));
				session.setAttribute("username", username);
				session.setAttribute("isEmployee", true);
				session.setAttribute("isAdmin", false);
				if (username.equals("admin")) {
					session.setAttribute("isAdmin", true);
				}
				db.closeConnection(con);
				response.sendRedirect("index.jsp");
			}
			db.closeConnection(con);
		}
			
		catch (Exception e) {
			System.out.print(e);
		}
	}

}

