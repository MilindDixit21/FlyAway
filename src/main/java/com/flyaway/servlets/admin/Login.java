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
import com.flyaway.util.FormValidator;
import com.flyaway.util.HibernateUtil;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/userLogin")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
//		int flight_id = Integer.parseInt(request.getParameter("flight_id"));
//		int capacity = Integer.parseInt(request.getParameter("capacity"));
		
		
		
		if( !FormValidator.isEmail(username)||
			!FormValidator.isPassword(password)){
			
			String err = "";
			
			if( !FormValidator.isEmail(username) ){
        		err += "err01";
        	}
    		if ( !FormValidator.isPassword(password) ) {
    			err += "err02";
        	}
    		response.sendRedirect("login.jsp?error="+err);
		} else {
		
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
		
		if(customers.size() == 1) {
			
			Customer tempCust = customers.get(0);
			System.out.println("loginserv: "+tempCust.getCustomer_Id());
			
			HttpSession loginSession = request.getSession();
			loginSession.setAttribute("logged", true);
			loginSession.setAttribute("customer_Id", tempCust.getCustomer_Id() );
			
			
			 if(request.getSession().getAttribute("flightid") != null && request.getSession().getAttribute("capacity")!= null){
				 response.sendRedirect("admin/payment.jsp");
			 }else if(request.getSession().getAttribute("flightid") == null && request.getSession().getAttribute("capacity")== null){ 
			 	response.sendRedirect("admin/dashboard.jsp");
			 }
			
		}else {
//			RequestDispatcher rd = request.getRequestDispatcher("login.jsp?error=invalidCredentials");
//			rd.include(request, response);
//			PrintWriter out = response.getWriter();
//			out.print("<span class='alert alert-danger'>Invalid username or password. Please try again. </span>");
			response.sendRedirect("login.jsp?error=err03");
		}
		
		se.close();
		}
		
	}

}
