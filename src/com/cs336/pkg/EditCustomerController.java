package com.cs336.pkg;

import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class EditCustomerController
 */
public class EditCustomerController extends HttpServlet {

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

		Statement stmtCheckSSN;
		try {
			stmtCheckSSN = con.createStatement();
			String SSNChecker = "SELECT * FROM employee WHERE BINARY ssn=" + "\'" + ssn + "\'";
			ResultSet result = stmtCheckSSN.executeQuery(SSNChecker);
			boolean isValid = result.next();
			if (isValid) {
				if (firstName.length()!=0 && firstName.length() <= 50) {
					try {

						String sqlString = "UPDATE employee SET first_name= \'" + firstName + "\' WHERE BINARY ssn = \'" + ssn
								+ "\';";

						PreparedStatement editEmployee = con.prepareStatement(sqlString);
						editEmployee.executeUpdate();

					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if (lastName.length()!=0 && lastName.length() <= 50) {
					try {

						String sqlString = "UPDATE employee SET last_name= \'" + lastName + "\' WHERE BINARY ssn = \'" + ssn
								+ "\';";

						PreparedStatement editEmployee = con.prepareStatement(sqlString);
						editEmployee.executeUpdate();

					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if(username.length()!=0 && username.length() <= 50) {
					try {
						Statement stmt = con.createStatement();
						String usernameChecker = "SELECT * FROM employee WHERE BINARY username=" + "\'" + username + "\' AND ssn<> \'" + ssn + "\';";
						ResultSet usernameResult = stmtCheckSSN.executeQuery(usernameChecker);
						boolean isExistingUsername = usernameResult.next();
						if(!isExistingUsername) {
							String sqlString = "UPDATE employee SET username= \'" + username + "\' WHERE BINARY ssn = \'" + ssn + "\';";
							PreparedStatement editEmployee = con.prepareStatement(sqlString);
							editEmployee.executeUpdate();
						}

					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if(password.length()!=0 && password.length() <= 50) {
					try {

						String sqlString = "UPDATE employee SET password= \'" + password + "\' WHERE BINARY ssn = \'" + ssn + "\';";

						PreparedStatement editEmployee = con.prepareStatement(sqlString);
						editEmployee.executeUpdate();

					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			
				db.closeConnection(con);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.sendRedirect("admin.jsp");
	}

}