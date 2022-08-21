<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>login</title>
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
<link href="css/style.css" rel="stylesheet" />
</head>

<body id="customerlogin">

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
			Username has invalid characters or is blank.<br>
			<%
			}
			if(error.indexOf("02")>=0){
			%>
			Password has invalid characters or is blank.<br>
			<%
			}
			%>
		</div>
	</section>
<%
}
%>

	<table class="container table_detail roundedCorner box_shadow">
		<tr>
			<td>
				<h3>Login</h3>
				<br>
				<form action="userLogin" method="post">
					<label>Username</label><input type="text" name="username">
					<br> <label>Password:</label><input type="password"
						name="password"> <br> <span class="form_btn">
						<button class="btn" type="submit"
							style="margin: 0 auto; width: 26%; margin: 10px 65px 0 0;">login</button>
					</span>
				</form>
			</td>
		</tr>
	</table>

</body>
</html>