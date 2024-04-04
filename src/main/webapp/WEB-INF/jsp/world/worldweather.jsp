<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    
   	<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		
	<link rel="stylesheet" href="/static/css/worldstyle.css" type="text/css">
	
</head>
<body>
	<div id="wrap">
		<!--<c:import url="/WEB-INF/jsp/include/header.jsp" /> -->
		<section class="contents d-flex justify-content-center align-items-center">
			<div>
				<div id="map"></div>
				<div id="weeklyWeather">
				</div>
			</div>
		</section>
	</div>
	<script src="/static/js/apikey.js"></script>
	<script src="/static/js/initMap.js"></script>
	<script>
	    
	</script> 
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBesWJE6GVunGS2VquR8T4NeP6LJcIKhIU&callback=initMap"></script>

</body>
</html>