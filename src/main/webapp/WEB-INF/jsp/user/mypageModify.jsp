<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    
   	<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

	<link rel="stylesheet" href="/static/css/userstyle.css" type="text/css">
</head>
<body>
<%
// 세션에 저장된 속성 값 가져오기
int userNo = (Integer) session.getAttribute("userNo");
String userId = (String) session.getAttribute("userId");
String userName = (String) session.getAttribute("userName");
String userEmail = (String) session.getAttribute("userEmail");

%>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section class="contents d-flex justify-content-center">
			<div class="join">
				<div class="text-center">
				
					<h3 class="mt-3 mb-2">수정 정보 입력</h3>
					<hr>
					아이디 = <%= userId %>
					<input type = "hidden" id="userid" name="userid" value="<%=userId %>">
					<input type = "hidden" id="userno" name="userno" value="<%=userNo %>">
					<hr>
					<label for="username">수정할 이름: </label><br>
    				<input type="text" id="username" name="username" value="<%= userName %>"><br>
					<hr>
					<label for="username">수정할 이메일: </label><br>
    				<input type="text" id="useremail" name="useremail" value="<%= userEmail %>"><br>
					<hr>
				
					
					<button type="button" id="changeBtn" class="btn btn-primary btn-block mt-3 mb-2" data-id="${userId}">정보 수정</button>
					<hr>
					<a href="/user/myPage/view" class="btn btn-primary mt-3 mb-2">마이페이지</a>
				</div>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<script src="/static/js/form.js"></script>
	<script>
		$(document).ready(function() {
			
			$("#changeBtn").on("click", function() {
				
				let no = $("#userno").val();
				let name = $("#username").val();
				let email = $("#useremail").val();
				
				$.ajax({
					type: "post"
					, url: "/user/checkAndModify"
					, data: {"no":no, "name":name,"email":email}
					, success: function(data){
						if(data.result == "success"){
							alert("수정이 완료되었습니다. 다시 로그인해주십시오.");
							location.href="/user/signout";
						} else {
							alert("수정 실패");
						}
					}
					, error: function() {
						alert("정보 수정 에러");
					}
				});
			});
		});
	</script>
</body>
</html>