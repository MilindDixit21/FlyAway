<%@page import="org.hibernate.query.Query"%>
<%@page import="javax.persistence.criteria.Root"%>
<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="javax.persistence.criteria.CriteriaBuilder"%>
<%@page import="com.flyaway.table.Admin"%>
<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin login</title>
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
<link href="css/style.css" rel="stylesheet" />
</head>

<body id="adminlogin">

<jsp:include page="globalmenu.jsp"></jsp:include>



<table class="container table_detail roundedCorner box_shadow">
<tr>
<td>
<h3>Admin Login</h3><br>
	<form action="adminLogin" method="post">
		<label>Username</label><input type="text" name="username"> <br>
		<label>Password:</label><input type="password" name="password"> <br>
		<span class="form_btn">
		<button class="btn" type="submit" style="margin: 0 auto; width: 26%; margin: 10px 15px 0 0;">login</button>
		<a class="btn btn_primary" href="registerAdminLogin">Register Admin User</a>
		</span>
	</form>
</td>
</tr>
</table>
</body>
</html>