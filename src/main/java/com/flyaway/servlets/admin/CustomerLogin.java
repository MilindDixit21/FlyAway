package com.flyaway.servlets.admin;

import java.io.IOException;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.query.Query;

import com.flyaway.table.Customer;
import com.flyaway.util.HibernateUtil;

/**
 * Servlet implementation class CustomerLogin
 */
@WebServlet("/CustomerLogin")
public class CustomerLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		int flight_id = Integer.parseInt(request.getParameter("flight_id"));
		int capacity = Integer.parseInt(request.getParameter("capacity"));
		
		Session se = HibernateUtil.getsessionFactory().openSession();
		
		CriteriaBuilder cb = se.getCriteriaBuilder();
		CriteriaQuery<Customer> cq = cb.createQuery(Customer.class);
		Root<Customer> root = cq.from(Customer.class);
		
		//single where clause
		//cq.select(root).where(cb.equal(root.get("firstName"), username));
		
		//multiple where clauses (and, or)
		Predicate predicateForusername = cb.equal(root.get("email"), username);
		Predicate predicateForpassword = cb.equal(root.get("password"), password);
		Predicate predicateForusernameAndPassword = cb.and(predicateForusername, predicateForpassword);
		
		cq.where(predicateForusernameAndPassword); 
		
		Query<Customer> query = se.createQuery(cq);
		
		List<Customer> customers = query.getResultList();
		
		if(customers.size() ==1) {
			
			Customer tempCust = customers.get(0);
			System.out.println("loginserv: "+tempCust.getCustomer_Id());
			
			HttpSession loginSession = request.getSession();
			loginSession.setAttribute("logged", true);
			loginSession.setAttribute("customer_Id", tempCust.getCustomer_Id() );
			loginSession.setAttribute("flight_id", flight_id );
			loginSession.setAttribute("capacity", capacity );
			
			response.sendRedirect("admin/dashboard.jsp?customer_Id="+tempCust.getCustomer_Id()+"&flight_id="+flight_id+"&capacity="+capacity);
			
		}else {
			response.sendRedirect("login.jsp?error=1");
		}
		
		se.close();
		
	}
}

