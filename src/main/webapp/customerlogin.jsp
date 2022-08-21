<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
</head>
<body>
<table class="container table_detail roundedCorner box_shadow">
<tr>
<td>
<h3>Login</h3><br>
	<form action="customerLogin" method="post">

		<label>Username</label><input type="text" name="username" value="bruce@gmail.com"> <br>
		<label>Password:</label><input type="password" name="password" value="bruce123"> <br>
		<span class="form_btn">
		<button class="btn" type="submit" style="margin: 0 auto; width: 26%; margin: 10px 65px 0 0;">login</button>
		</span>
	</form>
</td>
</tr>
</table>
</body>
</html>