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

import com.flyaway.table.Admin;
import com.flyaway.util.HibernateUtil;


/**
 * Servlet implementation class RegisterAdmin
 */
@WebServlet("/registerAdminLogin")
public class RegisterAdminUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterAdminUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = "admin";
		String password = "admin";
		
		Session hs = HibernateUtil.getsessionFactory().openSession();
		
		Admin adm = new Admin(username, password);
		
		Transaction tran = hs.beginTransaction();
		hs.save(adm);
		tran.commit();
		hs.close();
		
		RequestDispatcher rd = request.getRequestDispatcher("adminlogin.jsp");
		rd.include(request, response);
		PrintWriter out = response.getWriter();
		out.print("registerd");
		
	}

}
