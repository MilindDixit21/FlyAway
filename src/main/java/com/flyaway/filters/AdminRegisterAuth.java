package com.flyaway.filters;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import org.hibernate.Session;
import org.hibernate.query.Query;

import com.flyaway.table.Admin;
import com.flyaway.util.HibernateUtil;

/**
 * Servlet Filter implementation class AdminRegisterAuth
 */
@WebFilter("/registerAdminLogin")
public class AdminRegisterAuth implements Filter {

    /**
     * Default constructor. 
     */
    public AdminRegisterAuth() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		PrintWriter out = response.getWriter();
		String username = "admin";

		Session se = HibernateUtil.getsessionFactory().openSession();

		try {
			
		CriteriaBuilder cb = se.getCriteriaBuilder();
		CriteriaQuery<Admin> cq = cb.createQuery(Admin.class);
		Root<Admin> root = cq.from(Admin.class);

		//query
		cq.select(root).where(cb.like(root.get("username"), username));

		Query<Admin> query = se.createQuery(cq);

		List<Admin> admins = query.getResultList();
			
			if(admins.size()== 0) {
				chain.doFilter(request, response);
			}	
			if(admins.size()== 1) {
				
				RequestDispatcher rd = request.getRequestDispatcher("adminlogin.jsp");
				rd.include(request, response);
				out.print("<div class='alert alert-info' style='line-height: 1.7em;'>Use below credentials to log-in:<br><strong>Username: </strong>admin<br><strong>Password: </strong>admin</div>");
		}
		
	} catch (Exception e) {
		System.out.println(e.getClass()+" "+e.getMessage());
	}
	
	se.close();
		
		
		
		//
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
