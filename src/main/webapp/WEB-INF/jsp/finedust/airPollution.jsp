<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<!-- 상오님이 만드신 상단부 css 일단 시험적용 -->
<link rel="stylesheet" href="/static/css/getSatelliteImages.css"
	type="text/css">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c2a73f16f9f1ea4f2552915a06073cfd"></script>
<!-- <script -->
<!-- 	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- JavaScript 파일 불러오기 -->
<!-- <script src="js/drawPolygon.js"></script> -->


<style>
.flex-container {
	display: flex;
	justify-content: space-around; /* 이미지들을 가운데로 정렬 */
	gap: 20px; /* 각 이미지 사이의 간격 */
}

.flex-item {
	text-align: center;
}
</style>


<meta charset="UTF-8">
<title>우리 날씨 - 대기오염</title>
</head>
<body>


	<!-- 상오님이 만드신 상단 부분 일단 적용 -->
	<div class="navbar">
		<div>
			<a href="index.html"><img src="/static/image/logo.png" id="Logo"
				alt="왼쪽 이미지"></a>
		</div>
		<div>
			<h1>우리 날씨</h1>
		</div>
		<div class="login-container">
			<div>
				<a href="">
					<button class="login-button">로그인</button>
				</a>
			</div>
			<div>
				<a href="#" class="LoginOption">아이디 찾기</a> <a href="/"
					class="LoginOption">비밀번호 찾기</a> <a href="/user/signup"
					class="LoginOption">회원가입</a>
			</div>
		</div>
	</div>

	<div id="box">
		<div id="top">
			<div id="mid_content">
				<span><a href="index.html" class="Menu">지역 날씨</a></span> <span><a
					href="/" class="Menu">세계 날씨</a></span> <span><a href="/"
					class="Menu">미세먼지</a></span> <span><a
					href="/satellite/getSatelliteImages" class="Menu">위성영상</a></span> <span><a
					href="/" class="Menu_except">날씨 앱</a></span>

			</div>
		</div>
	</div>



	<!-- 카카오 지도 실험 -->
	<div id="map" style="width: 500px; height: 650px;"></div>
	<script>
		var container = document.getElementById('map');
		var options = {
			center : new kakao.maps.LatLng(36, 128),
			level : 13
		};

		var map = new kakao.maps.Map(container, options);

		var polygonPath = [ 
			    new kakao.maps.LatLng(35.866300, 128.589798),
				new kakao.maps.LatLng(35.865392, 128.590624),
				new kakao.maps.LatLng(35.865930, 128.591635),
				new kakao.maps.LatLng(35.867118, 128.591021),
				new kakao.maps.LatLng(35.867472, 128.589993) ];

		// 다각형 생성 및 지도에 표시
		var polygon = new kakao.maps.Polygon({
			path : polygonPath,
			strokeWeight : 3,
			strokeColor : '#39DE2A',
			strokeOpacity : 0.8,
			strokeStyle : 'longdash',
			fillColor : '#A2FF99',
			fillOpacity : 0.7
		});
		polygon.setMap(map);
	</script>




	<ul>
		<!-- 	금일 서울의 데이터 하나 시험출력 -->
		<li>${todayAirs[0][0]}</li>
	</ul>

	<!-- 미세먼지,초미세먼지 사진 시험출력 -->
	<div class="flex-container">
		<div class="flex-item">
			<h2>어제 오전 미세먼지</h2>
			<img src="${yesterdayAm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
		<div class="flex-item">
			<h2>어제 오후 미세먼지</h2>
			<img src="${yesterdayPm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
	</div>
	<div class="flex-container">
		<div class="flex-item">
			<h2>어제 오전 초미세먼지</h2>
			<img src="${yesterdayAm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
		<div class="flex-item">
			<h2>어제 오후 초미세먼지</h2>
			<img src="${yesterdayPm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
	</div>
	<div class="flex-container">
		<div class="flex-item">
			<h2>오늘 오전 미세먼지</h2>
			<img src="${todayAm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
		<div class="flex-item">
			<h2>오늘 오후 미세먼지</h2>
			<img src="${todayPm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
	</div>
	<div class="flex-container">
		<div class="flex-item">
			<h2>오늘 오전 초미세먼지</h2>
			<img src="${todayAm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
		<div class="flex-item">
			<h2>오늘 오후 초미세먼지</h2>
			<img src="${todayPm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
	</div>
	<div class="flex-container">
		<div class="flex-item">
			<h2>내일 오전 미세먼지</h2>
			<img src="${tomorrowAm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
		<div class="flex-item">
			<h2>내일 오후 미세먼지</h2>
			<img src="${tomorrowPm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
	</div>
	<div class="flex-container">
		<div class="flex-item">
			<h2>내일 오전 초미세먼지</h2>
			<img src="${tomorrowAm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
		<div class="flex-item">
			<h2>내일 오후 초미세먼지</h2>
			<img src="${tomorrowPm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다.">
		</div>
	</div>




	<!-- 		지역별 등급 출력 테스트 -->
	어제 미세먼지 :
	<c:forEach begin="0" end="37" step="1" var="index">
		<c:out value="${yesterday10Grades[index]}" />
	</c:forEach>
	<br /> 오늘 미세먼지 :
	<c:forEach begin="0" end="37" step="1" var="index">
		<c:out value="${today10Grades[index]}" />
	</c:forEach>
	<br /> 내일 미세먼지 :
	<c:forEach begin="0" end="37" step="1" var="index">
		<c:out value="${tomorrow10Grades[index]}" />
	</c:forEach>
	<br /> 어제 초미세먼지 :
	<c:forEach begin="0" end="37" step="1" var="index">
		<c:out value="${yesterday25Grades[index]}" />
	</c:forEach>
	<br /> 오늘 초미세먼지 :
	<c:forEach begin="0" end="37" step="1" var="index">
		<c:out value="${today25Grades[index]}" />
	</c:forEach>
	<br /> 내일 초미세먼지 :
	<c:forEach begin="0" end="37" step="1" var="index">
		<c:out value="${tomorrow25Grades[index]}" />
	</c:forEach>
	<br />

</body>
</html>