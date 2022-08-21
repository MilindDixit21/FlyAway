<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
<link rel="stylesheet" href="css/style.css">
<style type="text/css">html, body {  height: 100%;  margin: 0;}</style>
</head>
<body>

<div class="home_container container_wrapper">
	<header class="d-flex align-items-center" id="home">
		<jsp:include page="globalmenu.jsp"></jsp:include>

		
			<div class="row">
				<div class="col text-center">
					<h3
						class="text-uppercase font-weight-bold display-4 text-light banner-heading">Welcome to FlyAway</h3>
					<a href="searchflight.jsp"
						class="btn btn-lg btn-outline-primary text-uppercase px-5">Find your flight</a>
				</div>
			</div>
			<div class="push"></div>
		
	</header>
	</div>
	<footer class="footer" style="background: #0d3188;">
			<p>&copy; FlyAway, All Rights Reserved</p>
	</footer>

</body>
</html>