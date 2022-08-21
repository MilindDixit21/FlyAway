<%@page import="org.hibernate.query.Query"%>
<%@page import="com.flyaway.util.HibernateUtil" %>
<%@page import="com.flyaway.table.Flights" %>
<%@page import="com.flyaway.table.FlightRegistry" %>
<%@page import="com.flyaway.table.Customer" %>
<%@page import="com.flyaway.table.Payment" %>
<%@page import="org.hibernate.Session" %>
<%@page import="org.hibernate.SessionFactory" %>
<%@page import="org.hibernate.HibernateException" %>
<%@page import="org.hibernate.SessionFactory" %>
<%@page import="org.hibernate.criterion.Restrictions" %>
<%@page import="javax.persistence.criteria.Predicate" %>
<%@page import="javax.persistence.criteria.CriteriaBuilder" %>
<%@page import="javax.persistence.criteria.CriteriaQuery" %>
<%@page import="javax.persistence.criteria.Root" %>
<%@page import="java.util.List" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Flight Confirmed</title>
	<meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="../css/style.css" rel="stylesheet" />
    
    <!-- Include jQuery -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

	<!-- Include Date Range Picker -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>

	<!-- Importing icon cdn -->
 	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body id="page-top">

<jsp:include page="adminmenu.jsp"></jsp:include>
	
	
<div class="admin_confirmatin_wrap">
        <section class="page-section bg-light" id="register">
	           <table class="table_detail roundedCorner box_shadow confirmation"> <tr><td>
	                <h3 class="text-primary font-weight-bold noPrint">Booking Confirmation</h3>
	                <p class="small noPrint"> Have your boarding pass in hand before you get to the airport</p>
	               	<span>
	               	<a href="javascript:void(0)" onclick="window.print();" class="print noPrint"><i class="fa fa-print" aria-hidden="true"></i></a>
	               	</span>
	               	
                   <% 
                   		
                   	try{
                   		Session se = HibernateUtil.getsessionFactory().openSession();
					  	int flight_id = Integer.parseInt(request.getParameter("flight_id"));
					  	int customer_id = Integer.parseInt(request.getParameter("customer_id"));
					  	int payment_id = Integer.parseInt(request.getParameter("payment_id"));
					  	
				    	se.beginTransaction();
						CriteriaBuilder cb = se.getCriteriaBuilder();
						CriteriaQuery<FlightRegistry> cr = cb.createQuery(FlightRegistry.class);
						Root<FlightRegistry> root = cr.from(FlightRegistry.class);
						/* helpful link: https://www.baeldung.com/hibernate-criteria-queries*/
	
						Predicate flightIdMatch = cb.equal(root.get("flight"),flight_id);
						Predicate customerIdMatch = cb.equal(root.get("customer"),customer_id);
						Predicate paymentIdMatch = cb.equal(root.get("payment"),payment_id);
						
						cr.select(root).where(cb.and(flightIdMatch,customerIdMatch,paymentIdMatch));
						Query<FlightRegistry> query = se.createQuery(cr);
			            List<FlightRegistry> flightReg = query.getResultList();
					  	
			            for(FlightRegistry fr : flightReg){
			            	
						Flights f = fr.getFlight();
						Customer c = fr.getCustomer();
						Payment p = fr.getPayment();
					
					%>
					
	               	
              		<div class="ticket_wrapper">
              		<div class="ticket_header">
					<span class="bold_txt">Boarding pass</span> <span class="label_head"><%=fr.getFlight().getDepartCity() %> &#10143; <%=fr.getFlight().getArriveCity() %></span>
	               	</div>
                    	<div class="ticket_content">

				      <span class="label">PASSENGER NAME : </span><span><%=c.getLastName()%>, <%=c.getFirstName()%></span><br>
				      <span class="label">AIRLINE # </span><span><%=f.getAirlineName() %></span><br>
				      <span class="label">FLIGHT # </span><span><%=fr.getFlight().getFlightNo()%></span><br>
				      <span class="label">TICKET # </span><span><%=fr.getFlight_registry_Id() %></span><br>
				      <span class="label">FROM : </span><span><%=fr.getFlight().getDepartCity() %></span><br>
				      <span class="label">TO : </span><span><%=fr.getFlight().getArriveCity() %></span><br>
				      <span class="label">BOARDING DATE :</span><span><%=f.getDate() %></span>
         			
         				</div>	   
              		</div>
                    
                    <% 
		            			}
			            		se.close();
				            } catch (Exception e){
				            	System.out.println(e.getMessage());
				            	%>
				            	<p>Ticket generation error.</p>
				            	<%
				            }
				            %>
                </td></tr>
				</table>
              </section>
</div>
</body>
</html>