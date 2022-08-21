package com.flyaway.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.flyaway.table.Customer;
import com.flyaway.table.FlightRegistry;
import com.flyaway.table.Flights;
import com.flyaway.table.Payment;
import com.flyaway.util.HibernateUtil;

/**
 * Servlet implementation class SaveFlightRegistry
 */
@WebServlet("/SaveFlightRegistry")
public class SaveFlightRegistry extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveFlightRegistry() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int flight_id = Integer.parseInt(request.getParameter("flight_id"));
		int customer_id = Integer.parseInt(request.getParameter("customer_id"));
		int payment_id = Integer.parseInt(request.getParameter("payment_id"));
		int capacity = Integer.parseInt(request.getParameter("capacity"));
		
		System.out.println("flight_id: "+flight_id);
		System.out.println("customer_id: "+customer_id);
		System.out.println("payment_id: "+payment_id);
		System.out.println("capacity: "+capacity);
		
		
		Session session = HibernateUtil.getsessionFactory().openSession();
		Flights f = session.load(Flights.class,flight_id);
		Customer c = session.load(Customer.class,customer_id);
		Payment p = session.load(Payment.class,payment_id);

		int flightCapacity = f.getCapacity();
		f.setCapacity(flightCapacity-capacity);
		
		for (int i = 0; i < capacity; i++) {
			FlightRegistry fr = new FlightRegistry(f,c,p);	
			Transaction trans = session.beginTransaction();
			f.setFlightRegistry(fr);
			c.setFlightRegistry(fr);
			p.setFlightRegistry(fr);
			
			
			
			session.save(f);
			session.save(c);
			session.save(p);
			session.save(fr);
			
			trans.commit();
		}
		
		
		response.sendRedirect("confirmation.jsp?customer_id="+customer_id+"&flight_id="+flight_id+"&payment_id="+payment_id);
		
		session.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
