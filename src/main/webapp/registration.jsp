<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="com.flyaway.table.Flights"%>
<%@ page import="org.hibernate.Session"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>FlyAway - Registration</title>
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
<link href="css/style.css" rel="stylesheet" />
<style type="text/css">html, body {  height: 100%;  margin: 0;}</style>
<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>-->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>


</head>
<body id="page-top" class="bg_darkBlue">
<div class="container_wrapper">
	<jsp:include page="globalmenu.jsp"></jsp:include>


	<%
		String error = request.getParameter("error");
		
		if(error!=null){
			%>
		<section class="page-section bg-light" id="register">
		<div class="alert alert-danger" role="alert">
			<%
			if(error.indexOf("01")>=0){
				%>
			<b>First name has invalid characters or is blank.</b><br>
			<%
			}
			if(error.indexOf("02")>=0){
				%>
			<b>Last name has invalid characters or is blank.</b><br>
			<%
			}
			if(error.indexOf("03")>=0){
				%>
			<b>Date of birth is not a valid date or is blank.</b><br>
			<%
			}
			if(error.indexOf("04")>=0){
				%>
			<b>Street address is not a valid address or is blank.</b><br>
			<%
			}
			if(error.indexOf("05")>=0){
				%>
			<b>Gender is blank.</b><br>
			<%
			}
			if(error.indexOf("06")>=0){
				%>
			<b>ID type is blank.</b><br>
			<%
			}
			if(error.indexOf("07")>=0){
				%>
			<b>Id number contains illegal characters or is blank.</b><br>
			<%
			}
			if(error.indexOf("08")>=0){
				%>
			<b>Exp date is not a valid date or is blank.</b><br>
			<%
			}
			if(error.indexOf("09")>=0){
				%>
			<b>Capacity is not a valid number or is blank.</b><br>
			<%
			}
			if(error.indexOf("10")>=0){
				%>
			<b>flight_id is not a valid number or is blank.</b><br>
			<%
			}
			
			%>
		</div>
	</section>
	<%
		}
		try{
			int flight_id = Integer.parseInt(request.getParameter("flight_id"));
			int capacity = Integer.parseInt(request.getParameter("capacity"));
			Session se = HibernateUtil.getsessionFactory().openSession();
		
			Flights f = se.load(Flights.class,flight_id);
		
	%>

	<%	
		request.getSession().getAttribute("flightid");
		request.getSession().getAttribute("capacity");
		
		//out.print("f:"+request.getSession().getAttribute("flightid")+"-c:"+request.getSession().getAttribute("capacity"));
		%>
	<!-- Customer Registration -->
	<table class="table_detail roundedCorner box_shadow bg_white">
		<tr>
			<td>
				<section class="page-section bg-light" id="register">
					<div class="container">
						<h3 class="text-primary mt-0">Customer Registration</h3>
						<%
                        //error handling block here.
                        %>
						<form class="row g-3 align-items-center"
							action="register?flight_id=<%=f.getFlight_id() %>&capacity=<%=capacity %>"
							method="POST">
							<div class="col-auto">
								<label>First Name</label><input type="text" class="form-control"
									placeholder="First Name" name="firstName" id="firstName">
							</div>
							<div class="col-auto">
								<label>Last Name</label><input type="text" class="form-control"
									placeholder="Last Name" name="lastName" id="lastName">
							</div>
							<div class="col-auto">
								<label>Email</label><input type="text" class="form-control"
									placeholder="email" name="email" id="email">
							</div>
							<div class="col-auto">
								<label>Password</label><input type="password"
									class="form-control" placeholder="Password" name="password"
									id="password" >
							</div>
							<div class="col-auto">
								<label>Date of Birth</label> <input class="form-control"
									id="dateOfBirth" name="dateOfBirth"
									placeholder="MM/DD/YYYY" type="text"
									aria-label="date" aria-describedby="addon-wrapping" />
							</div>
							<div class="col-auto">
								<label>Street Address</label><input type="text"
									class="form-control" placeholder="Street Address"
									name="st_address" id="st_address">
							</div>
							<div class="col-auto">
								<label>Age</label><input type="text" class="form-control"
									placeholder="Age" name="age" id="age">
							</div>
							<div class="col-auto">
								<label>Gender</label><select class="form-select"
									aria-label="Gender" name="gender" id="gender">
									<option selected>Gender</option>
									<option value="Male">Male</option>
									<option value="Female">Female</option>
									<option value="Undisclosed">Prefer not to Say</option>
								</select>
							</div>
							<div class="col-auto">
								<label>ID Type</label><select class="form-select"
									aria-label="ID Type" name="id_type" id="id_type">
									<option selected>ID Type</option>
									<option value="Drivers License">Drivers License</option>
									<option value="ID Card">ID Card</option>
									<option value="Military ID">Military ID</option>
									<option value="Passport">Passport</option>
								</select>
							</div>
							<div class="col-auto">
								<label>ID Number</label><input type="text" class="form-control"
									placeholder="ID Number" name="id_num" id="id_num">
							</div>
							<div class="col-auto">
								<label>Exp Date</label><input class="form-control"
									id="id_exp_date" name="id_exp_date"
									placeholder="MM/DD/YYYY" type="text"
									aria-label="date" aria-describedby="addon-wrapping" />
							</div>
							<div class="col-auto">
							<label></label><button type="submit" class="btn btn-secondary col-auto">Create Account</button>
							<br>
							<br>
							<label></label>Have already an account? <a href="login.jsp?flight_id=<%=flight_id%>&capacity=<%=capacity%>" class="login_link">Login here</a><br>
							</div>
						</form>
					</div>
				</section>
			</td>
		</tr>
	</table>
	<!-- Flight Info -->
	<section class="page-section bg-light hidden" id="flight_info">
		<div class="container px-5 px-lg-5">
			<div class="row gx-5 gx-lg-5 justify-content-center">
				<div class="col-lg-12 text-center">
					<h4 class="text-primary mt-0">Flight Information</h4>
					<hr class="divider divider-primary" />
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th scope="col">Flight Number</th>
								<th scope="col">Airline Name</th>
								<th scope="col">Arrive City</th>
								<th scope="col">Depart City</th>
								<th scope="col">Price</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row"><%=f.getFlightNo() %></th>
								<td><%=f.getAirlineName() %></td>
								<td><%=f.getArriveCity() %></td>
								<td><%=f.getDepartCity() %></td>
								<td><%=f.getPrice() %></td>
							</tr>
						</tbody>
					</table>
					<% 
						se.close();
						} catch (Exception e) {
							%>
					<div class="alert alert-danger" role="alert">
						<b>There was an error with your query or url parameters.</b>
					</div>
					<%
						}
						
						
						%>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer-->
<div class="push"></div>
	</div>
	<footer class="footer">
			<p>&copy; FlyAway, All Rights Reserved</p>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<script>
	$(function() {
		$("#id_exp_date,#dateOfBirth").datepicker({
			showAnim : "slideDown"
		});
	});
</script>
</body>
</html>