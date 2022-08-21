<%@page import="com.flyaway.table.Customer"%>
<%@page import="com.flyaway.table.Flights"%>
<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="../css/style.css" rel="stylesheet" />
<style type="text/css">
body { background: #0d3188;}.table_detail {background: #fff;}
</style>
</head>
<body id="dashboard" class="userpage">

	<jsp:include page="adminmenu.jsp"></jsp:include>
	
	<%
	// debug sessionAttribute
	//out.print("fid"+request.getSession().getAttribute("flightid"));
	%>

<%
	
	int customerid = (int) request.getSession().getAttribute("customer_Id");
	Session se = HibernateUtil.getsessionFactory().openSession();
	Customer c = se.load(Customer.class,customerid);
	
	request.getSession().setAttribute("customer_email", c.getEmail());
%>

 <table class="table table-striped table-hover table_detail roundedCorner cust_info">
								<tr>
								<td>
								<a href="updatepassword.jsp">change password</a>
								<h3 class="text-primary mt-0">Profile</h3>
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
	
</body>
</html>