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
<title>search flight</title>
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
<link rel="stylesheet" href="css/style.css">


<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>

<style type="text/css">html, body {  height: 100%;  margin: 0;}body {background: #0d3188;}</style>

</head>
<body id="bookaflight">
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


	<table class="container table_detail roundedCorner box_shadow">
		<tr>
			<td>
				<h3>Search a flight!</h3>
				<br>
				<form action="flights.jsp" method="post">
					<label>Departing from?</label><input type="text" name="depart" ><br>
					<label>Going to?</label><input type="text" name="arrive" ><br> 
					<span class="form_bottom"> 
						<label>Number of Passengers</label>
						<select class="form-select" aria-label="Number of Passengers" name="capacity" id="capacity" style="width: auto;">
							<option selected>Number of Passengers</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="8">9</option>
							<option value="8">10</option>
						</select><br>
					<label for="date" class="visually-hidden">Departure Date</label>
					<input class="form-control" style="width: auto;" id="date" name="date" placeholder="MM/DD/YYYY" type="text" aria-label="date" aria-describedby="addon-wrapping" /> <br>
					</span><br>
					<span class="form_btn">
						<button class="btn" type="submit" style="margin: 0 auto; width: 26%; margin: 10px 65px 0 0;">Search</button>
					</span>
					
				</form>
			</td>
		</tr>
	</table>
	<div class="push"></div>
	</div>
	<footer class="footer">
			<p>&copy; FlyAway, All Rights Reserved</p>
	</footer>
<script>
	$(function() {
		$("#date").datepicker({
			minDate : "-3M",
			maxDate : "+3M",
			showAnim : "slideDown"

		});
	});
	
</script>
</body>
</html>