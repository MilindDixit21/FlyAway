<%@page import="org.hibernate.Transaction"%>
<%@page import="com.flyaway.table.Customer"%>
<%@page import="com.flyaway.util.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Change password</title>
<link href="../css/style.css" rel="stylesheet" />
</head>
<body class="updatepassword">
<jsp:include page="adminmenu.jsp"></jsp:include>

		<%
		String error = request.getParameter("error");
		String success = request.getParameter("success");
		if(error!=null){
		%>
		<section class="page-section bg-light" id="updatepwd">
		<div class="alert alert-danger" role="alert">
			<%
			if(error.indexOf("01")>=0){
			%>
			old password has invalid characters or is blank.<br>
			<%
			}
			if(error.indexOf("02")>=0){
			%>
			New Password has invalid characters or is blank.<br>
			<%
			}
			%>
		</div>
	</section>
<%
}if(success!=null){
%>
<section class="page-section bg-light" id="updatepwd">
		<div class="alert alert-info" role="alert">
			password has been updated!
			<%
			}
%>
</div>
</section>


<table class="container table_detail roundedCorner box_shadow">
		<tr>
			<td>
				<h3>Update password</h3>
				<br>
				<form action="../updatepass" method="post">
				 <label>Email Id :</label><input type="text" name="email" value="<%= session.getAttribute("customer_email")%>" id="readOnlyText" readonly="readonly"><br>
				<label>old password</label><input type="text" name="oldpwd"><br>
				<label>new Password:</label><input type="text" name="newpwd"><br> 
				<span class="form_btn">
						<button class="btn" type="submit" style="margin: 0 auto; width: 26%; margin: 10px 65px 0 0;">Save</button>
					</span>
				</form>
			</td>
		</tr>
	</table>

</body>
</html>