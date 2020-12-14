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
public class DeleteReservationController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		int resNum = Integer.parseInt(request.getParameter("resNum"));
		String username = (String) request.getSession().getAttribute("username");
		
		Statement stmtCheckResNum;
		try {
			stmtCheckResNum = con.createStatement();// add check to make sure it is their reservation
			String ResNumChecker = "SELECT * FROM reservation WHERE reservation_number="+resNum+" and customer_username=\""+username+"\";";
						
			ResultSet result = stmtCheckResNum.executeQuery(ResNumChecker);
			boolean isValid = result.next();
			if (isValid) {
				Statement stmt;
				try {
					stmt = con.createStatement();

					String sqlString = "DELETE FROM reservation WHERE reservation_number="+resNum+" and customer_username=\""+username+"\";";
					
					PreparedStatement insertEmployee = con.prepareStatement(sqlString);
					insertEmployee.executeUpdate();

					db.closeConnection(con);

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			else {
				System.out.println("INVALID resNum");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		response.sendRedirect("reservations.jsp");
	}

}
