<%@page import="com.flyaway.table.Customer"%>
<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<%
Session se = HibernateUtil.getsessionFactory().openSession();

int customerid = (int) session.getAttribute("customer_Id");

//to access 'Customer' database
Customer customerlogin = se.load(Customer.class, customerid);
%>

<nav class="navbar admin_menu">
<a href="dashboard.jsp" class="welcome"><i class="fa fa-user" aria-hidden="true"></i> <%=customerlogin.getFirstName()+" "+customerlogin.getLastName() %></a>
		<ul class="navbar-nav">
		<li class="nav-item"><a href="dashboard.jsp" class="nav-link">Profile</a></li>
			<li class="nav-item"><a href="../searchflight.jsp" class="nav-link">Book Flight</a></li>
			<li class="nav-item"><a href="logout" class="nav-link">Logout</a></li>
		</ul>
</nav>

<%
se.close();
%> 

