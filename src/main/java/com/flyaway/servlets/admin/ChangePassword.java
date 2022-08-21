package com.flyaway.servlets.admin;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;
import com.flyaway.table.Customer;
import com.flyaway.util.FormValidator;
import com.flyaway.util.HibernateUtil;

/**
 * Servlet implementation class ChangePassword
 */
@WebServlet("/updatepwd")
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String oldpwd = request.getParameter("oldpwd");
		String newpwd = request.getParameter("newpwd");
		
		
		if( !FormValidator.isPassword(oldpwd)||
			!FormValidator.isPassword(newpwd)){
				
				String err = "";
				
				if( !FormValidator.isPassword(oldpwd) ){
	        		err += "err01";
	        	}
	    		if ( !FormValidator.isPassword(newpwd) ) {
	    			err += "err02";
	        	}
	    		response.sendRedirect("updatepassword.jsp?error="+err);
			} else {
				Session se = HibernateUtil.getsessionFactory().openSession();
				
				String custId = (String) request.getSession().getAttribute("customer_Id");
				Customer user = se.load(Customer.class, custId);
				
				if(user.getPassword() == oldpwd) {
				user.setPassword(newpwd);

				Transaction transaction = se.beginTransaction();
				se.save(user);
				transaction.commit();
				RequestDispatcher rd = request.getRequestDispatcher("dashboard.jsp");
				rd.include(request, response);
				PrintWriter out = response.getWriter();
				out.print("<span class='alert alert-info'>Password has changed! </span>");
				}
				if(user.getPassword()!= oldpwd) {
					RequestDispatcher rd = request.getRequestDispatcher("updatepassword.jsp?error=0");
					rd.include(request, response);
					PrintWriter out = response.getWriter();
					out.print("<span class='alert alert-danger'>Password does not match </span>");
					//response.sendRedirect("updatepassword.jsp?error="+err);
				}
				se.close();
			}
		}

}
