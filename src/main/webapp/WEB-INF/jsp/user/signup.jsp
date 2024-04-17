<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리날씨</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    
   	<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

	<link rel="stylesheet" href="/static/css/userstyle.css" type="text/css">

</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
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
					<div class="d-flex mt-3">
						<select id="citySelect" class="form-control">
		                            <!-- 도시 옵션은 스크립트에서 동적으로 추가됩니다 -->
	                    </select>
	                   	<select id="districtSelect" class="form-control">
	                        <!-- 구 옵션은 스크립트에서 동적으로 추가됩니다 -->
	                    </select>
                    </div>
					<button type="button" id="joinBtn" class="btn btn-primary btn-block mt-3">가입</button>
					
					
					<div class="d-flex justify-content-center mt-4">
						<h6>계정이 있으신가요?<a href="/user/signin/view">로그인</a></h6>
					</div>
					
				</div>
			</div>
			
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	<script src="/static/js/form.js"></script>
	<script>
		$(document).ready(function() {
			
			var check = false;
			
			var area_1 = ["서울특별시","부산광역시","대구광역시","인천광역시","광주광역시","대전광역시","울산광역시","세종특별자치시","경기도","강원도","충청도","전라도","경상도","제주특별자치도"];
		    var area_2 = {};
		    area_2["서울특별시"] = ["종로구","중구","용산구","성동구","광진구","동대문구","중랑구","성북구","강북구","도봉구","노원구","은평구","서대문구","마포구","양천구","강서구","구로구","금천구","영등포구","동작구","관악구","서초구","강남구","송파구","강동구"];
		    area_2["부산광역시"] = ["중구","서구","동구","영도구","부산진구","동래구","남구","북구","강서구","해운대구","사하구","금정구","연제구","수영구","사상구"];
		    area_2["대구광역시"] = ["중구","동구","서구","남구","북구","수성구","달서구","달성군"];
		    area_2["인천광역시"] = ["중구","동구","미추홀구","연수구","남동구","부평구","계양구","서구","강화군","옹진군"];
		    area_2["광주광역시"] = ["동구","서구","남구","북구","광산구"];
		    area_2["대전광역시"] = ["동구","중구","서구","유성구","대덕구"];
		    area_2["울산광역시"] = ["중구","남구","동구","북구","울주군"];
		    area_2["세종특별자치시"] = ["세종"];
		    area_2["경기도"] = ["수원","안양","안산","용인","부천","광명","평택","과천","오산","시흥","군포","의왕","하남","이천","안성","김포","화성","광주","여주","양평","고양","의정부","동두천","구리","남양주","파주","양주","포천","연천","가평"];
		    area_2["강원도"] = ["춘천","원주","강릉","동해","태백","속초","삼척","홍천","횡성","영월","평창","정선","철원","화천","양구","인제","고성","양양"];
		    area_2["충청도"] = ["청주","충주","제천","보은","옥천","영동","증평","진천","괴산","음성","단양","천안","공주","보령","아산","서산","논산","계룡","당진","금산","부여","서천","청양","홍성","예산","태안"];
		    area_2["전라도"] = ["전주","군산","익산","정읍","남원","김제","완주","진안","무주","장수","임실","순창","고창","부안","목포","여수","순천","나주","광양","담양","곡성","구례","고흥","보성","화순","장흥","강진","해남","영암","무안","함평","영광","장성","완도","진도","신안"];
		    area_2["경상도"] = ["포항","경주","김천","안동","구미","영주","영천","상주","문경","경산","군위","의성","청송","영양","영덕","청도","고령","성주","칠곡","예천","봉화","울진","울릉","창원","진주","통영","사천","김해","밀양","거제","양산","의령","함안","창녕","고성","남해","하동","산청","함양","거창","합천"];
		    area_2["제주특별자치도"] = ["제주","서귀포"];
	
		    // 도시 선택 박스에 도시 목록 추가
		    for (var i = 0; i < area_1.length; i++) {
		        $('#citySelect').append(new Option(area_1[i], area_1[i]));
		    }
	
		    // 도시 선택 박스의 선택이 변경되면 구 선택 박스의 목록을 업데이트
		    $('#citySelect').change(function() {
		        var city = $(this).val();
		        var districts = area_2[city];
		        $('#districtSelect').empty();
		        for (var i = 0; i < districts.length; i++) {
		            $('#districtSelect').append(new Option(districts[i], districts[i]));
		        }
		    });
	
		    // 페이지 로드 시 기본 도시의 구 목록을 구 선택 박스에 추가
		    var defaultCity = $('#citySelect').val();
		    var defaultDistricts = area_2[defaultCity];
		    for (var i = 0; i < defaultDistricts.length; i++) {
		        $('#districtSelect').append(new Option(defaultDistricts[i], defaultDistricts[i]));
		    }
			
			// id 입력창 변경 시 (중복확인 후 값을 변경 했을 때 다시 중복확인 누르게 바꿈)
			$("#idInput").on("change", function() {
				check = false;
				$("#idDuplication").hide();
				$("#idNotDuplication").hide();
			});
			
			// 중복체크 버튼 클릭 시
			$("#idCheckBtn").on("click", function() {
				let id = $("#idInput").val();
				
				if(!valueCheck($("#idInput"), "아이디")){
					return;
				}
				
				$.ajax({
					type:"get"
					, url:"/user/signup/duplication"
					, data:{"id": id}
					, success:function(data) {
						// 결과가 true면 중복 되었다는 텍스트 출력
						if(data.result) {
							$("#idDuplication").show();
							$("#idNotDuplication").hide();
							check = false;
						// false면 사용 가능하다고 출력
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
			
			// 가입버튼 클릭시
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
				
				// 이메일 유효성 체크
				if(!exptext.test(email)){
					alert("이메일 형식이 맞지 않습니다.");
					email.val("");
					email.focus();
					return;
				}
				
				// 비밀번호와 비밀번호 확인이 일치하는지 체크
				if(password != passwordConfirm){
					alert("비밀번호와 비밀번호확인이 일치하지 않습니다.");
					passwordConfirm.val("");
					passwordConfirm.focus();
					return;
				}
				
				// id 중복체크가 안 되어 있을 시 알림
				if(!check){
					alert("아이디 중복체크를 해주세요");
					return;
				}
				
				$.ajax({
					type:"post"
					, url:"/user/signup"
					, data:{"id":id, "password":password, "name":name, "email":email}
					, success:function(data) {
						// 회원가입 성공 시 로그인 화면으로 이동
						if(data.result == "success"){
							alert("가입이 완료되었습니다.");
							location.href="/user/signin/view";
						// 실패 시 오류 알림
						} else {
							alert("입력 오류");
						}
					}
					, error:function() {
						alert("회원가입 api 오류");
					}
				});
			});
		});
	</script>
</body>
</html>