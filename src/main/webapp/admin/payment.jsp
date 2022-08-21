<%@page import="com.flyaway.util.HibernateUtil"%>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="com.flyaway.table.Flights" %>
<%@ page import="com.flyaway.table.Customer" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>FlyAway - Registration</title>
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
   
  
    
    <div class="admin_payment_wrap">
    
        <section class="page-section bg-light" id="register">
            <div class="container px-5 px-lg-5">
                <div class="row gx-5 gx-lg-5 justify-content-center">
        	<%
			String error = request.getParameter("error");
		
			if(error!=null){
				%>
					<div class="alert alert-danger" role="alert">
				<%
				if(error.indexOf("01")>=0){
					%>
			   			<b>Name on Card has invalid characters or is blank.</b><br>
					<%
				}
				if(error.indexOf("02")>=0){
					%>
		   				<b>Credit Card number has invalid characters or is blank.</b><br>
					<%
				}
				if(error.indexOf("03")>=0){
					%>
			   			<b>Month is blank.</b><br>
					<%
				}
				if(error.indexOf("04")>=0){
					%>
			   			<b>Year is blank.</b><br>
					<%
				}
				if(error.indexOf("05")>=0){
					%>
			   			<b>CCV has invalid characters or is blank.</b><br>
					<%
				}
				
				if(error.indexOf("06")>=0){
					%>
			   			<b>Capacity is not a valid number or is blank.</b><br>
					<%
				}
				if(error.indexOf("07")>=0){
					%>
			   			<b>customer_id is not a valid number or is blank.</b><br>
					<%
				}
				if(error.indexOf("08")>=0){
					%>
			   			<b>flight_id is not a valid number or is blank.</b><br>
					<%
				}
				%>
				</div>
				<%
			}
			
			try{
				 
				    HttpSession httpSession = request.getSession(false);
					int flight_id = (int) session.getAttribute("flightid");
					int capacity = (int) session.getAttribute("capacity");
					int customer_id = (int) session.getAttribute("customer_Id");
					
					//debug sessionAttribute
					//out.print("f:"+httpSession.getAttribute("flightid")+"-c:"+httpSession.getAttribute("capacity")+"-cust:"+httpSession.getAttribute("customer_Id"));
				   
				  
				
			Session se = HibernateUtil.getsessionFactory().openSession();
			//int flight_id = Integer.parseInt(request.getParameter("flight_id"));
			//int customer_id = Integer.parseInt(request.getParameter("customer_id"));
			//int capacity = Integer.parseInt(request.getParameter("capacity"));
			Flights f = se.load(Flights.class,flight_id);
			Customer c = se.load(Customer.class,customer_id);
			
			%>
		
		 <!-- Customer Info -->
        <div class="page-section bg-light" id="flight_info">
            

                       
                       <% double actualCost = (capacity * f.getPrice()+ 12); %>
                       
                        <table class="table table-striped table-hover table_detail roundedCorner table_dark fair_details">
								<tr>
								<td><h3 class="text-primary mt-0">Flight Information</h3>
									<div><span class="sub">Flight Number</span><span class="super"><%=f.getFlightNo() %></span></div>
								    <div><span class="sub">Airline:</span><span class="super"><%=f.getAirlineName() %></span></div>
								    <div><span class="sub">Depart City</span><span class="super"><%=f.getDepartCity() %></span></div>
								    <div><span class="sub">Arrive City</span><span class="super"><%=f.getArriveCity() %></span></div>
								    <div><span class="sub">Date</span><span class="super"><%=f.getDate() %></span></div>
								    <div><span class="sub">Number of Travelers</span><span class="super"><%=capacity %> </span></div>
								    <div class="fair_details_pay"><span class="sub">You pay today</span><span class="super">$<%=String.format("%.2f", actualCost) %></span><button style="margin: 0 0 0 25px;" class="btn btn_primary" id="show">Confirm Booking</button></div>
								    </td>
						    	</tr>
						</table>
						
						
						
						<table class="table table-striped table-hover table_detail roundedCorner cust_info">
								<tr>
								<td> 
									<h3 class="text-primary mt-0">Customer Information</h3>
								    <div><span class="sub">Name:</span><span class="super"><%=c.getFirstName() %></span></div>
								    <div><span class="sub">Last Name:</span><span class="super"><%=c.getLastName() %></span></div>
								    <div><span class="sub">Date of Birth:</span><span class="super"><%=c.getDateOfBirth() %></span></div>
								    <div><span class="sub">Gender:</span><span class="super"><%=c.getGender() %></span></div>
								    <div><span class="sub">Street Address:</span><span class="super"><%=c.getSt_address() %></span></div>
								    <div><span class="sub">ID Type:</span><span class="super"><%=c.getId_type() %></span></div>
								    <div><span class="sub">ID Number:</span><span class="super"><%=c.getId_num() %></span></div>
								    <div><span class="sub">ID Exp Date:</span><span class="super"><%=c.getId_Exp_date() %></span></div>
								 </td>
						    	</tr>
						</table>
                    
        </div>
		
		
			
        <!-- Payment Info -->
        <div class="pops">
        <span id="close">&#10006;</span>
        <table class="table_detail roundedCorner box_shadow creditcard_details"><tr><td>
                    <div class="col-lg-12 text-center">
                        <h3 class="text-primary mt-0">Credit Card Payment - Enter your card details</h3>
                        <%
                        //error handling block here.
                        %>
                        <form class="row g-3 align-items-center" action="payment?flight_id=<%=f.getFlight_id() %>&customer_id=<%=c.getCustomer_Id() %>&capacity=<%=capacity %>" method="POST">
					    	
					    	<div class="col-auto">
					    		<label for="cc_name">Name on Card</label>
					      		<input type="text" class="form-control" name="cc_name"  id="cc_name">
					    	</div>
					    	<div class="col-auto">
					    		<label for="credit_card_num">Credit Card Number <span class="input-group-text" id="addon-wrapping">
				                        <i class="fa fa-credit-card">
				                        </i>
				                    </span></label>
						    		<input class="form-control" id="cc_num" name="cc_num" placeholder="Credit Card Number" type="text" aria-label="cc_num" aria-describedby="addon-wrapping"/>
					    	</div>
					    	<div class="col-auto">
					      		<label for="cc_month">Month</label>
	                            <select class="form-select" id="cc_month" name="cc_month">
	                                <option selected value=""></option>
	                                <option value="1">1</option>
	                                <option value="2">2</option>
	                                <option value="3">3</option>
	                                <option value="4">4</option>
	                                <option value="5">5</option>
	                                <option value="6">6</option>
	                                <option value="7">7</option>
	                                <option value="8">8</option>
	                                <option value="9">9</option>
	                                <option value="10">10</option>
	                                <option value="11">11</option>
	                                <option value="12">12</option>
	                            </select>
							</div>
							<div class="col-auto">
								<label for="ccmonth">Year</label>
					      		<select class="form-select" aria-label="cc_year" name="cc_year" id="cc_year">
									<option selected value=""></option>
	                                <option value="2022">2022</option>
	                                <option value="2023">2023</option>
	                                <option value="2024">2024</option>
	                                <option value="2025">2025</option>
	                                <option value="2026">2026</option>
	                                <option value="2027">2027</option>
	                                <option value="2028">2028</option>
	                                <option value="2029">2029</option>
	                                <option value="2030">2030</option>
	                                <option value="2030">2031</option>
								</select>
							</div>
							<div class="col-auto">
								<label for="cc_month">CCV/CVC</label>
					      		<input type="password" class="form-control" name="ccv"  id="ccv">
					    	</div>
					    	<div class="col-auto">
								<label for="">Amount to be paid</label>
					      	<input type="text" value="$<%=String.format("%.2f", actualCost) %>" id="readOnlyText" readonly>	
					    	</div>
					    	<div class="col-auto">
					    	<button type="submit" class="btn btn-secondary col-auto">Confirm Payment</button>
					    	</div>
						</form>
                    </div>
        </td></tr></table>        
        </div>        
                </div>
           
          
           
            </div>
        </section>
        
       <%	se.close();
			} catch (Exception e){
				out.print(e.getClass()+" "+e.getMessage());
				%>
				<div class="alert alert-danger" role="alert">
				<b>There was an error with your query or url parameters.</b>
				</div>
				<%
			}
			
			%>
        </div>
        <!-- Footer-->
      
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script>
        $(document).ready(function(){
            $('#show').click(function(){
                $('.pops').fadeIn();
            });
            $('#close').click(function(){
                $('.pops').fadeOut();
            });
        });
        </script>
    </body>
</html>