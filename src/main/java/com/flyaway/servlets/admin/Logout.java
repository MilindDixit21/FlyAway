package com.flyaway.servlets.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Logout
 */
@WebServlet({ "/admin/logout", "/logout" })
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Logout() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if (request.getSession().getAttribute("customer_Id") != null) {
			request.getSession().invalidate();
			response.sendRedirect("../index.jsp");

		} else if (request.getSession().getAttribute("admin_id") != null) {
			request.getSession().invalidate();
			response.sendRedirect("../index.jsp");

		} else if (request.getSession().getAttribute("logged") != null) {
			request.getSession().invalidate();
			response.sendRedirect("../index.jsp");
			
		} else if (request.getSession().getAttribute("flightid") != null) {
			request.getSession().invalidate();
			response.sendRedirect("../index.jsp");
		} else {
			request.getSession().invalidate();
			response.sendRedirect("index.jsp");
		}	
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
