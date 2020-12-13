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
public class AddCustomerController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String ssn = request.getParameter("ssn");
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		Statement stmtCheckUser;
		try {
			stmtCheckUser = con.createStatement();
			String usernameChecker = "SELECT * FROM employee WHERE username=" + "\'" + username + "\'";
			ResultSet result = stmtCheckUser.executeQuery(usernameChecker);
			boolean isValid = result.next();
			if (isValid) {
				response.sendRedirect("registrationFailed.jsp");
				return;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}
		try {
			stmtCheckUser = con.createStatement();
			String SSNChecker = "SELECT * FROM employee WHERE ssn=" + "\'" + ssn + "\'";
			ResultSet result = stmtCheckUser.executeQuery(SSNChecker);
			boolean isValid = result.next();
			if (isValid) {
				response.sendRedirect("registrationFailed.jsp");
				return;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		// consider fixing later (use SQL exception?)
		if (firstName.length() > 50) {
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		if (lastName.length() > 50) {
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		if (ssn.length() != 11) {
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		if (username.length() > 50) {
			response.sendRedirect("registrationFailed.jsp");
			return;
		}
		if (password.length() > 50) {
			response.sendRedirect("registrationFailed.jsp");
			return;
		}

		Statement stmt;
		try {
			stmt = con.createStatement();

			String sqlString = "Insert INTO employee VALUES (\'" + ssn + "\', \'" + firstName + "\', \'" + lastName
					+ "\', \'" + username + "\', \'" + password + "\'" + ");";

			PreparedStatement insertEmployee = con.prepareStatement(sqlString);
			insertEmployee.executeUpdate();

			db.closeConnection(con);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.sendRedirect("admin.jsp");
	}

}
