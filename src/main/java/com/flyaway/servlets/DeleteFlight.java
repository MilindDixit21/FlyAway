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
 * Servlet implementation class DeleteFlight
 */
@WebServlet("/admin/delete")
public class DeleteFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteFlight() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int flight_id = Integer.parseInt(request.getParameter("flight_id"));
		
		Session session = HibernateUtil.getsessionFactory().openSession();
		Transaction trans = session.beginTransaction();
		
		Flights flights = session.load(Flights.class, flight_id);
		
		session.delete(flights);
				
		trans.commit();
		session.close();
		response.sendRedirect("listflights.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
