package com.cs336.pkg;

import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DeleteCustomerController
 */
public class DeleteCustomerController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String ssn = request.getParameter("ssn");

		Statement stmtCheckSSN;
		try {
			stmtCheckSSN = con.createStatement();
			String SSNChecker = "SELECT * FROM employee WHERE BINARY ssn=" + "\'" + ssn + "\'";
			ResultSet result = stmtCheckSSN.executeQuery(SSNChecker);
			boolean isValid = result.next();
			if (isValid) {
				Statement stmt;
				try {
					stmt = con.createStatement();

					String sqlString = "DELETE FROM employee WHERE BINARY ssn = \'" + ssn + "\';";

					PreparedStatement insertEmployee = con.prepareStatement(sqlString);
					insertEmployee.executeUpdate();

					db.closeConnection(con);

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		response.sendRedirect("admin.jsp");
	}

}
