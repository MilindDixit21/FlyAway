<%@page import="com.flyaway.table.Flights"%>
<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Flight Details</title>
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
<link href="css/style.css" rel="stylesheet" />
<style type="text/css">
html, body {  height: 100%;  margin: 0;}
.btn_primary {background: #00aa00;color: #fff;	font-weight: bold;	padding: 15px 30px;	border: none;	outline: none;	border-radius: 35px;	font-size: 1.2em;	float: right;}
</style>
</head>
<body>
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
	Session se = HibernateUtil.getsessionFactory().openSession();

	int fid = Integer.parseInt(request.getParameter("flight_id"));
	int capacity = Integer.parseInt(request.getParameter("capacity"));

	Flights fl = se.load(Flights.class, fid);
	%>

	<%
	
	request.getSession().setAttribute("flightid", fid);
	request.getSession().setAttribute("capacity", capacity);
	
	%>
	
	<table class="table_detail roundedCorner">
		<tr>
			<td>
				<h3>Departure Information</h3> Date : <%=fl.getDate()%> <br>
				Travelers: <%=capacity%> <br> <span class="bold_txt"
				style="text-transform: capitalize;"><%=fl.getDepartCity()%>
					&#10143; <%=fl.getArriveCity()%></span> <br> <%=fl.getFlightNo()%>
				| <%=fl.getAirlineName()%> | Duration <br>

			</td>
		</tr>
	</table>

	<%
	double payment = fl.getPrice();
	double cf = 12.00;
	double result = (capacity * payment) + cf;
	%>

	<table class="table_detail roundedCorner table_dark fair_details">
		<tr>
			<td><h3>Fare Details</h3>
				<div>
					<span class="sub">Cost per person</span><span class="super">$<%=String.format("%.2f", fl.getPrice()) %></span> 
				</div>
				<div>
					<span class="sub">Number of travelers</span><span class="super"><%=capacity%></span>
				</div>
				<div>
					<span class="sub">Convenience Fee</span><span class="super">$<%=String.format("%.2f", cf) %></span>
				</div>
				<div class="fair_details_pay">
					<span class="sub">You pay today:</span><span class="super">$<%=String.format("%.2f", result)%></span>
				</div> <!-- <button class="btn_primary" type="submit"> Continue to Checkout</button>  -->
				<div class="fair_details_bottom">
					
					<%
						if(request.getSession().getAttribute("customer_Id") == null){
					%>
						<a class="btn_primary" href="registration.jsp?flight_id=<%=fid %>&capacity=<%=capacity %>">Book Now</a>
					<%
			
						}else if(request.getSession().getAttribute("customer_Id") != null){ 
					%>
						<a class="btn_primary" href="admin/payment.jsp">Pay Now</a>
					<%
						}

					%>
					
					
				</div></td>
		</tr>
	</table>

	<%
se.close();
%>

<div class="push"></div>
	</div>
	<footer class="footer">
			<p>&copy; FlyAway, All Rights Reserved</p>
	</footer>
</body>
</html>