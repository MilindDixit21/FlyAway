<%@page import="com.flyaway.table.Admin"%>
<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add flight</title>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="../css/style.css" rel="stylesheet" />
<style type="text/css">
body {background: #0d3188;} .table_detail{background: #fff;}
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<!-- Importing icon cdn -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>

<script>
	$(function() {
		$("#datepicker").datepicker();
	});
</script>



</head>
<body>
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
		<tr>
			<td>
				<h3>Add flight!</h3> <br>
				<form action="../addf" method="post">

					<label>Flight Number: </label><input type="text" name="flight_no"> <br>
					<label>Airline:</label><input type="text" name="airline_company"> <br> 
					<label>Source: </label><input type="text" name="flight_source"> <br> 
					<label>destination:</label><input type="text" name="flight_destination"> <br> 
					<label>price:</label><input type="text" name="flight_price"> <br> 
					<label>Capacity:</label><input type="text" name="capacity"> <br> 
					<label for="datepicker">Date:</label><input type="text" name="date" id="datepicker"> <br>

					<!-- <label>Date: </label><input id="date" name="date" placeholder="MM/DD/YYYY" type="date" aria-label="date" aria-describedby="addon-wrapping" /> <br>  -->
					<span class="form_btn">
						<button class="btn" type="submit" style="margin: 0 auto; width: 26%; margin: 10px 65px 0 0;">Save</button>
						</span>

				</form>
				</td>
		</tr>
	</table>
				
				<!-- Bootstrap core JS--> <script
					src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
				<!-- Core theme JS--> <script src="js/scripts.js"></script>
</body>
</html>