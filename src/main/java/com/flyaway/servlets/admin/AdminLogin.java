package com.flyaway.servlets.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.query.Query;

import com.flyaway.table.Admin;
import com.flyaway.util.HibernateUtil;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/adminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		Session se = HibernateUtil.getsessionFactory().openSession();
		
		CriteriaBuilder cb = se.getCriteriaBuilder();
		CriteriaQuery<Admin> cq = cb.createQuery(Admin.class);
		Root<Admin> root = cq.from(Admin.class);
		
		//single where clause
		//cq.select(root).where(cb.equal(root.get("firstName"), username));
		
		//multiple where clauses (and, or)
		Predicate predicateForusername = cb.equal(root.get("username"), username);
		Predicate predicateForpassword = cb.equal(root.get("password"), password);
		Predicate predicateForusernameAndPassword = cb.and(predicateForusername, predicateForpassword);
		
		cq.where(predicateForusernameAndPassword); 
		
		Query<Admin> query = se.createQuery(cq);
		List<Admin> admin = query.getResultList();
		
		if(admin.size() ==1) {
			
			Admin tempAdmin = admin.get(0);
			System.out.println("loginserv: "+tempAdmin.getAdmin_id());
			
			HttpSession loginSession = request.getSession();
			loginSession.setAttribute("loggedAsAdmin", true);
			loginSession.setAttribute("admin_id", tempAdmin.getAdmin_id() );
			//loginSession.setAttribute("flight_id", flight_id );
			//loginSession.setAttribute("capacity", capacity );
			
			response.sendRedirect("admin/listflights.jsp");
			
		}else {
			RequestDispatcher rd = request.getRequestDispatcher("adminlogin.jsp?error=1");
			rd.include(request, response);
			PrintWriter out = response.getWriter();
			out.print("<span class='alert alert-danger'>Invalid username or password. Please try again. </span>");
		}
		
		se.close();
		
	}

}
