<%@page import="javax.persistence.criteria.Root"%>
<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="javax.persistence.criteria.CriteriaBuilder"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.List"%>
<%@page import="com.flyaway.table.Flights"%>
<%@page import="org.hibernate.query.Query"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book a flight</title>
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
</head>
<body>

<h3>Book a flight!</h3>

<table class="table_flight">
<tr>
<td>Flight No.</td>
<td>Airline</td>
<td>Source</td>
<td>Destination</td>
<td>Price</td>
<td>Action</td>
</tr>

<%

Session ses = HibernateUtil.getsessionFactory().openSession();

CriteriaBuilder cb = ses.getCriteriaBuilder();
CriteriaQuery<Flights> cq = cb.createQuery(Flights.class);
Root<Flights> root = cq.from(Flights.class);

//cq.select(root).where(cb.ge(root.get("flight_price"), (double) 1000));
//cq.select(root).where(cb.like(root.get("flight_source"), "mumbai"));
//cq.select(root).where(cb.ge(root.get("flight_price"), (double)1000));

Query<Flights> query = ses.createQuery(cq);
List<Flights> flight = query.getResultList();

for(Flights fl :flight) {
	%>
	
<tr>
	<td> <%= fl.getFlightNo()  %> </td>
	<td> <%= fl.getAirlineName() %> </td>
	<td> <%= fl.getDepartCity() %> </td>
	<td> <%= fl.getArriveCity() %> </td>
	<td> <%= fl.getPrice() %> </td>
	<td> <a href="?flight_id=<%= fl.getFlight_id() %>">Continue</a></td>
</tr>
<%

}
ses.close();
%>

</table>

</body>
</html>