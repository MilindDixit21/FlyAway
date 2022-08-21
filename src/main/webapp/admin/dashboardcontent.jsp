<%@page import="java.util.List"%>
<%@page import="org.hibernate.query.Query"%>
<%@page import="javax.persistence.criteria.Predicate"%>
<%@page import="javax.persistence.criteria.CriteriaBuilder"%>
<%@page import="javax.persistence.criteria.Root"%>
<%@page import="com.flyaway.table.FlightRegistry"%>
<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="com.flyaway.table.Payment"%>
<%@page import="com.flyaway.table.Flights"%>
<%@page import="com.flyaway.table.Customer"%>
<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<table border="1">
<tr>
<td> Booking Id</td>  
<td>Flight #</td>	
<td>Airline #</td>	
<td>Travel Date</td> 
<td>From</td>	
<td>To</td>		
<td>No of passengers:</td> 
<td>Total Fare:</td>	 
<td>Booking status:</td> 
</tr>

	<% 
                   		
try{
Session se = HibernateUtil.getsessionFactory().openSession();
int customerid =43; 
//(int) session.getAttribute("customer_Id");


se.beginTransaction();
CriteriaBuilder cb = se.getCriteriaBuilder();
CriteriaQuery<FlightRegistry> cr = cb.createQuery(FlightRegistry.class);
Root<FlightRegistry> root = cr.from(FlightRegistry.class);
/* helpful link: https://www.baeldung.com/hibernate-criteria-queries*/


Predicate customerIdMatch = cb.equal(root.get("customer"),customerid);

cr.select(root).where(cb.equal(root.get("customer"), (int) customerid));
Query<FlightRegistry> query = se.createQuery(cr);
List<FlightRegistry> flightReg = query.getResultList();
	
for(FlightRegistry fr : flightReg){
	
Flights f = fr.getFlight();
Customer c = fr.getCustomer();
Payment p = fr.getPayment();

%>


 
<tr>

<td><%=fr.getFlight_registry_Id() %>  <%=fr.getFlight().getFlights().get(2) %></td>
<td><%=fr.getFlight().getFlightNo()%></td>
<td><%=f.getAirlineName() %></td>
<td><%=fr.getFlight().getDate() %></td>
<td><%=fr.getFlight().getDepartCity() %></td>
<td><%=fr.getFlight().getArriveCity() %></td>
<td><%=fr.getFlight().getCapacity() %></td>
<td><%=fr.getPayment().getPayment_Id()%></td>
<td><% out.print("Confirmed"); %></td>

</tr>



	
	
	<%
}
se.close();
} catch (Exception e){
System.out.println(e.getMessage());
	%>
	<tr><td><p>Ticket generation error.</p></td></tr>
	<%
}
	%>
</table>
</body>
</html>