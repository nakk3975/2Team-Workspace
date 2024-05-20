<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
	<link rel="stylesheet" href="/static/css/style.css" type="text/css">
</head>
<header class="navbar">
	<div>
      <!-- 왼쪽 이미지 -->
		<a href="#">
        	<img src="/static/image/404_Team Logo 2.png" id="logo" width="300px;" alt="왼쪽 이미지">
      	</a>
    </div>

    <div>
    	<h1>우리 날씨</h1>
    </div>

    <div class="login-container">
      	<c:choose>
			<c:when test="${not empty userId}">
				<div class="text-center">
				${userId}님 &nbsp;
				<a href="/user/signout"> 로그아웃</a>
				<a href="/user/myPage/view"> 마이페이지</a>
				</div>
			</c:when>
			<c:otherwise>
				<a href="/user/signin/view">
         			<button class="login-button btn btn-block btn-primary">로그인</button>
       			</a>
       			<div>
	        		<a href="/user/idSearch/view" class="login-option">아이디/비밀번호 찾기</a>
	        		<a href="/user/signup/view" class="login-option">회원가입</a>
	    		</div>
        	</c:otherwise>
		</c:choose>
	    
	</div>
</header>

<div id="box">
	<div id="top">
    	<nav id="midContent main-menu col-8 pt-3">

			<ul class="nav justify-content-around bg-warning">
				<li class="nav-item"><a href="/weather/main/view" class="nav-link font-weight-bold">지역날씨</a></li>
				<li class="nav-item"><a href="/weather/world/view" class="nav-link font-weight-bold">세계날씨</a></li>
				<li class="nav-item"><a href="/finedust/airPollution" class="nav-link font-weight-bold">미세먼지</a></li>
				<li class="nav-item"><a href="/satellite/getSatelliteImages" class="nav-link font-weight-bold">위성영상</a></li>
				<li class="nav-item"><a href="/app/introduce" class="nav-link font-weight-bold">날씨 앱</a></li>

			</ul>
		</nav>
	</div>
</div>
