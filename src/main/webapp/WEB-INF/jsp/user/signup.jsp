<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리날씨</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    
   	<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

	<link rel="stylesheet" href="/static/css/style.css" type="text/css">

</head>
<body>
	<div id="wrap">
		<section class="contents d-flex justify-content-center">
			<div class="join d-flex justify-content-center mt-4">
				<div class="join-box my-4">
					<h1 class="text-center mb-5">회원가입</h1>
					<div class="input-group">
					  	<input type="text" class="form-control" placeholder="아이디" id="idInput">
					  	<button class="btn btn-primary" type="button" id="idCheckBtn">중복확인</button>
					</div>
					<span id="idDuplication" class="text-danger small" style="display:none">중복된 아이디 입니다.</span>
					<span id="idNotDuplication" class="text-success small" style="display:none">사용 가능한 아이디 입니다.</span>
					<input type="password" placeholder="비밀번호" id="passwordInput" class="form-control mt-3">
					<input type="password" placeholder="비밀번호 확인" id="passwordConfirmInput" class="form-control mt-3">
					<input type="text" placeholder="이름" id="nameInput" class="form-control mt-3">
					<input type="text" placeholder="이메일" id="emailInput" class="form-control mt-3">
					<button type="button" id="joinBtn" class="btn btn-primary btn-block mt-3">가입</button>
					
					
					<div class="d-flex justify-content-center mt-4">
						<h6>계정이 있으신가요?<a href="/user/signin/view">로그인</a></h6>
					</div>
					
				</div>
			</div>
			
		</section>
	</div>
	
	<script src="/static/js/form.js"></script>
	<script>
		$(document).ready(function() {
			
			var check = false;
			
			$("#idInput").on("change", function() {
				check = false;
				$("#idDuplication").hide();
				$("#idNotDuplication").hide();
			});
			
			$("#idCheckBtn").on("click", function() {
				let id = $("#idInput").val();
				
				if(!valueCheck($("#idInput"), "아이디")){
					return;
				}
				
				$.ajax({
					type:"get"
					, url:"/user/signup/duplication"
					, data:{"loginId": id}
					, success:function(data) {
						if(data.result) {
							$("#idDuplication").show();
							$("#idNotDuplication").hide();
							check = false;
						} else {
							$("#idDuplication").hide();
							$("#idNotDuplication").show();
							check = true;
						}
					}
					, error:function(){
						alert("중복검사 에러");
					}
				});
				
			});
			
			$("#joinBtn").on("click", function() {
				let id = $("#idInput").val();
				let password = $("#passwordInput").val();
				let passwordConfirm = $("#passwordConfirmInput").val();
				let name = $("#nameInput").val();
				let email = $("#emailInput").val();
				let exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
				
				if(!valueCheck($("#idInput"), "아이디")){
					return;
				}
				if(!valueCheck($("#passwordInput"), "패스워드")){
					return;
				}
				if(!valueCheck($("#passwordConfirmInput"), "패스워드확인")){
					return;
				}
				if(!valueCheck($("#nameInput"), "이름")){
					return;
				}
				if(!valueCheck($("#emailInput"), "이메일")){
					return;
				}
				
				if(!exptext.test(email)){
					alert("이메일 형식이 맞지 않습니다.");
					email.val("");
					email.focus();
					return;
				}
				
				if(password != passwordConfirm){
					alert("비밀번호와 비밀번호확인이 일치하지 않습니다.");
					passwordConfirm.val("");
					passwordConfirm.focus();
					return;
				}
				
				if(!check){
					alert("아이디 중복체크를 해주세요");
					return;
				}
				
				$.ajax({
					type:"post"
					, url:"/user/signup"
					, data:{"loginId":id, "password":password, "name":name, "email":email}
					, success:function(data) {
						if(data.result == "success"){
							alert("가입이 완료되었습니다.");
							location.href="/user/signin/view";
						} else {
							alert("가입 오류");
						}
					}
					, error:function() {
						alert("입력 오류");
					}
				});
			});
		});
	</script>
</body>
</html>