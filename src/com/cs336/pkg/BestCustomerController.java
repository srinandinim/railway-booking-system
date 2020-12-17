package com.cs336.pkg;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BestCustomerController extends HttpServlet  {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			int month = Integer.parseInt(request.getParameter("Month"));
			int year = Integer.parseInt(request.getParameter("Year"));

			Statement stmt;
			try {
				stmt = con.createStatement();
				String query = "SELECT customer.first_name, customer.last_name, customer_username, SUM(total_fare) totalFare FROM reservation LEFT JOIN customer ON customer.username = customer_username WHERE MONTH(reservation_origin_datetime) = "+month+" and YEAR(reservation_origin_datetime) = "+year+" GROUP BY customer_username ORDER BY totalFare DESC;";
				String cusFirstName = "";
				String cusLastName = "";
				String cusUsername = "";
				double totalFare = 0;
				ResultSet result = stmt.executeQuery(query);
				if (result.next()) {
					cusFirstName = result.getString(1);
					cusLastName = result.getString(2);
					cusUsername = result.getString(3);
					totalFare = result.getDouble(4);
				}
				
				request.setAttribute("cusFirstName", cusFirstName);
				request.setAttribute("cusLastName", cusLastName);
				request.setAttribute("cusUsername", cusUsername);
				request.setAttribute("totalFare", totalFare);
				
			} catch (SQLException e) {
				e.printStackTrace();
			}

			RequestDispatcher rd = request.getRequestDispatcher("admin.jsp");
			rd.forward(request, response);

			db.closeConnection(con);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
