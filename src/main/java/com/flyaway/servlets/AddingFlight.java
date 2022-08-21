package com.flyaway.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.flyaway.table.Flights;
import com.flyaway.util.HibernateUtil;

/**
 * Servlet implementation class AddFlight
 */
@WebServlet("/AddFlight")
public class AddingFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddingFlight() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		Session session = HibernateUtil.getsessionFactory().openSession();
		String flight_no = request.getParameter("flight_no");
		String flight_source = request.getParameter("flight_source");
		String flight_destination = request.getParameter("flight_destination");
		double flight_price = Double.parseDouble(request.getParameter("flight_price"));
		String airline_company = request.getParameter("airline_company");
		int capacity =Integer.parseInt(request.getParameter("capacity"));
		String travel_date = request.getParameter("date");
		
				
		Flights flights = new Flights(flight_no, flight_source, flight_destination, flight_price, airline_company, capacity, travel_date);
		
		
		Transaction transaction = session.beginTransaction();
		
		session.save(flights);
		
		transaction.commit();
		session.close();
		
		response.sendRedirect("admin/listflights.jsp");
		
		
	}

}
