package com.flyaway.filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginAuth
 */
@WebFilter("/admin/login")
public class LoginAuth implements Filter {

    /**
     * Default constructor. 
     */
    public LoginAuth() {
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
		
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpSession session = httpServletRequest.getSession(false);
		
		boolean isLoggedIn = false;
		
		if(session!=null && session.getAttribute("logged")!=null && session.getAttribute("customer_Id")!=null) {
			isLoggedIn = true;
		}
		//for testing
		System.out.println(isLoggedIn);
		System.out.println(session.getAttribute("logged"));
		System.out.println(session.getAttribute("customer_Id"));
		
		
		if(isLoggedIn) {
			chain.doFilter(request, response);
			
		}else {
			HttpServletResponse httpresponse = (HttpServletResponse) response;
			httpresponse.sendRedirect("../login.jsp?error=2");
		}
		
		System.out.println("hit!");
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
