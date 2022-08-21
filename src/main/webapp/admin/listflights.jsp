<%@page import="com.flyaway.table.Admin"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.query.Query"%>
<%@page import="javax.persistence.criteria.Root"%>
<%@page import="com.flyaway.table.Flights"%>
<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="javax.persistence.criteria.CriteriaBuilder"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List all flights</title>
<link href="../css/style.css" rel="stylesheet" />
<style type="text/css">
body {background: #0d3188;} .table_detail{background: #fff;}
</style>
</head>
<body id="listallflights">


<%
Session se = HibernateUtil.getsessionFactory().openSession();

int adminid = (int) session.getAttribute("admin_id");

//to access 'Customer' database
Admin adminlogin = se.load(Admin.class, adminid);
%>

<nav class="navbar admin_menu system">
<a href="javascript:void(0);" class="welcome"><i class="fa fa-user" aria-hidden="true"></i> <%=adminlogin.getUsername() %></a>
		<ul class="navbar-nav">
		<li class="nav-item"><a href="listflights.jsp" class="nav-link">List all flights</a></li>
			<li class="nav-item"><a href="addflight.jsp" class="nav-link">Add flight</a></li>
			<li class="nav-item"><a href="logout" class="nav-link">Logout</a></li>
		</ul>
</nav>

<%
se.close();
%> 

<table class="container table_detail roundedCorner box_shadow">
<tr> <td colspan="7"><a href="addflight.jsp" class="pagelink">add flight</a><h3>Flight Listings!</h3></td> </tr>
<tr class="tbl_header">
<td>Flight No.</td>
<td>Airline</td>
<td>Source</td>
<td>Destination</td>
<td>Date</td>
<td>Price</td>
<td>Action</td>
</tr>


<% 
Session ses = HibernateUtil.getsessionFactory().openSession();
Transaction transaction = ses.beginTransaction();

CriteriaBuilder cb = ses.getCriteriaBuilder();
CriteriaQuery<Flights> cq = cb.createQuery(Flights.class);
Root<Flights> root = cq.from(Flights.class);
		
Query<Flights> query = ses.createQuery(cq);
List<Flights> flights = query.getResultList();

for(Flights fl :flights) {
	%>
	
	<tr>
		<td> <%= fl.getFlightNo()  %> </td>
		<td> <%= fl.getAirlineName() %> </td>
		<td> <%= fl.getDepartCity() %> </td>
		<td> <%= fl.getArriveCity() %> </td>
		<td> <%=fl.getDate() %></td>
		<td> <%= fl.getPrice() %> </td>
		<td> <a href="delete?flight_id=<%= fl.getFlight_id() %>" class="form_btn">Delete</a></td>
	</tr>
	<%
}

transaction.commit();
ses.close();

%>
</table>

</body>
</html>