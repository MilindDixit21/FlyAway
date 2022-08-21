<%@page import="java.util.List"%>
<%@page import="org.hibernate.query.Query"%>
<%@page import="javax.persistence.criteria.Predicate"%>
<%@page import="com.flyaway.table.Flights"%>
<%@page import="javax.persistence.criteria.Root"%>
<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="javax.persistence.criteria.CriteriaBuilder"%>
<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.flyaway.util.FormValidator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search result</title>
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
<link href="css/style.css" rel="stylesheet" />	
<style type="text/css">
html, body {  height: 100%;  margin: 0;}
.table_flight{border-collapse: collapse; border-spacing: 0; border: 1px solid #000; width: 100%;font-family: sans-serif;}
tr.tbl_header {background: #0f4a96;color: #fff;font-weight: 600;}
.table_flight td{border: 0.5px solid #7f95a8;padding: 5px 0 5px 23px;margin: 0;}
.table_flight td a {background: #b51717;padding: 2px 30px;color: #fff;text-decoration: none;}
.table_flight td a:hover {background:#e31d1d;}
</style>

</head>
<body id="flightSearchResult">
<div class="container_wrapper">
<%
	if(request.getSession().getAttribute("customer_Id") == null){
		%>
		<jsp:include page="globalmenu.jsp"></jsp:include>
		<%
			
	}else if(request.getSession().getAttribute("customer_Id") != null){ 
		%>
		<jsp:include page="admin/adminmenu.jsp"></jsp:include>
		<%
	}

%>


<%

						//START JAVA
							String dateCheck = request.getParameter("date");
							String arriveCheck = request.getParameter("arrive");
							String departCheck = request.getParameter("depart");
							String capacityCheck = request.getParameter("capacity");
							
							if(capacityCheck.equals("Number of Passengers")){
								capacityCheck=null;
							}
							
							//ERROR CHECK
							if(!FormValidator.isAlphabet(departCheck)||
								!FormValidator.isAlphabet(arriveCheck)||
								!FormValidator.isDateTime(dateCheck)||
								!FormValidator.isInt(capacityCheck)){
								
									%>
		                    		<div class="alert alert-danger" role="alert">
		                    		<% 
			                    	if( !FormValidator.isAlphabet(departCheck) ){
			                    		%>
										<b>Departure city has invalid characters or is blank.</b><br>
			                    		<%
			                    	}
		                    		if ( !FormValidator.isAlphabet(arriveCheck) ) {
			                    		%>
										<b>Arrival city has invalid characters or is blank.</b><br>
			                    		<%
			                    	}
		                    		if ( !FormValidator.isDateTime(dateCheck) ) {
			                    		%>
										<b>Date is invalid or is blank.</b><br>
			                    		<%
			                    	}
		                    		if ( !FormValidator.isInt(capacityCheck) ) {
			                    		%>
										<b>Selected number of passengers is not a number.</b><br>
			                    		<%
			                    	}
			                    	%>
									</div>
		                    		<%
							} else {
							
							try{
							//handle date reformat
							String in = request.getParameter("date");
							String depart = request.getParameter("depart");
							String arrive = request.getParameter("arrive");
							Integer capacity = Integer.parseInt(request.getParameter("capacity"));
							
							//DEBUG
							System.out.println("date: "+in);
							System.out.println("depart: "+depart);
							System.out.println("arrive: "+arrive);
							System.out.println("capacity: "+capacity);
							
							Session se = HibernateUtil.getsessionFactory().openSession();
					    	se.beginTransaction();
							CriteriaBuilder cb = se.getCriteriaBuilder();
							CriteriaQuery<Flights> cr = cb.createQuery(Flights.class);
							Root<Flights> root = cr.from(Flights.class);
							/* helpful link: https://www.baeldung.com/hibernate-criteria-queries*/

							Predicate equalsArriveCity = cb.equal(root.get("arriveCity"),arrive);
							Predicate equalsDepartCity = cb.equal(root.get("departCity"),depart);
							Predicate hasCapacity = cb.ge(root.<Integer>get("capacity"),capacity);
							Predicate equalsDate = cb.equal(root.get("date"),in);
							//Predicate gtDate = cb.greaterThanOrEqualTo(root.<Date>get("date"),date1);
							//Predicate ltDate = cb.lessThanOrEqualTo(root.<Date>get("date"),date2);
							
							cr.select(root).where(cb.and(equalsArriveCity,equalsDepartCity,hasCapacity,equalsDate));
							Query<Flights> query = se.createQuery(cr);
				            List<Flights> flights = query.getResultList();
				            
				            for(Flights f : flights) {
				        %>
				        
				        <table class="container table_detail roundedCorner gray_border box_shadow">
						<tr>
						<td class="details">
						<div class="col-left">&nbsp;<%=f.getFlightNo() %> <br> <p class="airline_name"><%=f.getAirlineName() %> </p> </div>
						<div class="col-right"><%=f.getDepartCity() %> <span class="divider"><i class="fa fa-long-arrow-right" aria-hidden="true" data-fa-transform="rotate-45"></i></span> <%=f.getArriveCity()%></div>
						<div class="date"><%=f.getDate() %></div>
						<hr>
						</td>
						<td class="price">
						<a class="btn btn-primary btn-sm" href="flightdetailscontinue.jsp?flight_id=<%=f.getFlight_id() %>&capacity=<%=capacity %>">
						<%=String.format("%.2f", f.getPrice()) %>
						</a>
						</td>
						</tr>
				       </table>
						
						<%		
							}//close for loop
				           
					    	se.close();
						  
						//END JAVA
						%>
						  
						
				<%
					if(flights.size()<1){
						%>
                		<div class="alert alert-danger" role="alert">
                		<b>Sorry, no results found for that search...</b>
                		</div>
                		<% 
					}
				}catch(Exception e){
					System.out.println(e.getClass()+" "+e.getMessage());
					%>
					<div class="alert alert-danger" role="alert">
					<b>There was an error with your query or url parameters.</b>
					</div>
					<%
				}
				
				}//close error check if statement	    
				%>	

        <div class="push"></div>
	</div>
	<footer class="footer">
			<p>&copy; FlyAway, All Rights Reserved</p>
	</footer>
	
        <script src="js/scripts.js"></script>
        <script>
            $(function () {
                $("#datepicker").datepicker();
            });
        </script>
</body>
</html>