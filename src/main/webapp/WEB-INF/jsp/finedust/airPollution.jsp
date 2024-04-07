<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.net.URLEncoder" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<!-- 상오님이 만드신 상단부 css 일단 시험적용 -->
<link rel="stylesheet" href="/static/css/getSatelliteImages.css"
	type="text/css">
<!-- <script type="text/javascript" -->
<!-- 	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c2a73f16f9f1ea4f2552915a06073cfd"></script> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- <script -->
<!-- 	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c2a73f16f9f1ea4f2552915a06073cfd&libraries=services,clusterer,drawing"></script> -->
<!-- <script src="/static/js/drawPolygon.js"></script> -->
<script src="/static/js/finedustButton.js"></script>
<script>
var yesterdayAm10 = "${yesterdayAm10Image}";
var todayAm10 = "${todayAm10Image}";
var tomorrowAm10 = "${tomorrowAm10Image}";
var yesterdayPm10 = "${yesterdayPm10Image}";
var todayPm10 = "${todayPm10Image}";
var tomorrowPm10 = "${tomorrowPm10Image}";
var yesterdayAm25 = "${yesterdayAm25Image}";
var todayAm25 = "${todayAm25Image}";
var tomorrowAm25 = "${tomorrowAm25Image}";
var yesterdayPm25 = "${yesterdayPm25Image}";
var todayPm25 = "${todayPm25Image}";
var tomorrowPm25 = "${tomorrowPm25Image}";
</script>



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


<div>
 <img id="outputImage" src="" alt="오늘 이미지">
        <div id="outputText">오늘</div>
</div>
<button onclick="changeContent('yesterdayAm10')">어제 오전 미세먼지</button>
<button onclick="changeContent('todayAm10')">오늘 오전 미세먼지</button>
<button onclick="changeContent('tomorrowAm10')">내일 오전 미세먼지</button>
<button onclick="changeContent('yesterdayPm10')">어제 오후 미세먼지</button>
<button onclick="changeContent('todayPm10')">오늘 오후 미세먼지</button>
<button onclick="changeContent('tomorrowPm10')">내일 오후 미세먼지</button>
<button onclick="changeContent('yesterdayAm25')">어제 오전 초미세먼지</button>
<button onclick="changeContent('todayAm25')">오늘 오전 초미세먼지</button>
<button onclick="changeContent('tomorrowAm25')">내일 오전 초미세먼지</button>
<button onclick="changeContent('yesterdayPm25')">어제 오후 초미세먼지</button>
<button onclick="changeContent('todayPm25')">오늘 오후 초미세먼지</button>
<button onclick="changeContent('tomorrowPm25')">내일 오후 초미세먼지</button>



	<!-- 카카오 지도 실험 -->
<!-- 	<div id="map" style="width: 1000px; height: 1500px;">아니</div> -->


<!-- 		<div id="map" style="width: 500px; height: 650px;"></div> -->

<!-- 	 <script> -->
	<!--         var map = new kakao.maps.Map(document.getElementById('map'), { -->
	<!--             center: new kakao.maps.LatLng(36, 128), -->
	<!--             level: 13 -->
	<!--         }); -->

	<!--         var linePath = [ -->
	<!--             new kakao.maps.LatLng(36.866300, 126.589798), -->
	<!--             new kakao.maps.LatLng(34.865392, 127.590624), -->
	<!--             new kakao.maps.LatLng(37.865930, 128.591635), -->
	<!--             new kakao.maps.LatLng(36.867118, 129.591021), -->
	<!--             new kakao.maps.LatLng(35.867472, 128.589993) -->
	<!--         ]; -->

	<!--         // 선 그리기 -->
	<!--         var polyline = new kakao.maps.Polyline({ -->
	<!--             path: linePath, -->
	<!--             strokeWeight: 3, -->
	<!--             strokeColor: '#39DE2A', -->
	<!--             strokeOpacity: 0.8, -->
	<!--             strokeStyle: 'solid' -->
	<!--         }); -->
	<!--         polyline.setMap(map); -->

	<!--         // 선의 좌표 가져오기 -->
	<!--         var lineCoords = polyline.getPath(); -->

	<!--         // 폴리곤 만들기 -->
	<!--         var polygon = new kakao.maps.Polygon({ -->
	<!--             path: lineCoords, -->
	<!--             strokeWeight: 3, -->
	<!--             strokeColor: '#39DE2A', -->
	<!--             strokeOpacity: 0.8, -->
	<!--             strokeStyle: 'solid', -->
	<!--             fillColor: '#A2FF99', -->
	<!--             fillOpacity: 0.7 -->
	<!--         }); -->
	<!--         polygon.setMap(map); -->
	<!--     </script> -->




	<ul>
		<!-- 	금일 서울의 데이터 하나 시험출력 -->
		<li>${todayAirs[0][0]}</li>
	</ul>

	<!-- 미세먼지,초미세먼지 사진 시험출력 -->
<!-- 	<div class="flex-container"> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>어제 오전 미세먼지</h2> -->
<%-- 			<img src="${yesterdayAm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>어제 오후 미세먼지</h2> -->
<%-- 			<img src="${yesterdayPm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<div class="flex-container"> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>어제 오전 초미세먼지</h2> -->
<%-- 			<img src="${yesterdayAm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>어제 오후 초미세먼지</h2> -->
<%-- 			<img src="${yesterdayPm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<div class="flex-container"> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>오늘 오전 미세먼지</h2> -->
<%-- 			<img src="${todayAm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>오늘 오후 미세먼지</h2> -->
<%-- 			<img src="${todayPm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<div class="flex-container"> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>오늘 오전 초미세먼지</h2> -->
<%-- 			<img src="${todayAm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>오늘 오후 초미세먼지</h2> -->
<%-- 			<img src="${todayPm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<div class="flex-container"> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>내일 오전 미세먼지</h2> -->
<%-- 			<img src="${tomorrowAm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>내일 오후 미세먼지</h2> -->
<%-- 			<img src="${tomorrowPm10Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<div class="flex-container"> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>내일 오전 초미세먼지</h2> -->
<%-- 			<img src="${tomorrowAm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 		<div class="flex-item"> -->
<!-- 			<h2>내일 오후 초미세먼지</h2> -->
<%-- 			<img src="${tomorrowPm25Image}" alt="해당 시간대의 이미지가 아직 제공되지 않았습니다."> --%>
<!-- 		</div> -->
<!-- 	</div> -->




	<!-- 		지역별 등급 출력 테스트 -->
<!-- 	어제 미세먼지 : -->
<%-- 	<c:forEach begin="0" end="37" step="1" var="index"> --%>
<%-- 		<c:out value="${yesterday10Grades[index]}" /> --%>
<%-- 	</c:forEach> --%>
<!-- 	<br /> 오늘 미세먼지 : -->
<%-- 	<c:forEach begin="0" end="37" step="1" var="index"> --%>
<%-- 		<c:out value="${today10Grades[index]}" /> --%>
<%-- 	</c:forEach> --%>
<!-- 	<br /> 내일 미세먼지 : -->
<%-- 	<c:forEach begin="0" end="37" step="1" var="index"> --%>
<%-- 		<c:out value="${tomorrow10Grades[index]}" /> --%>
<%-- 	</c:forEach> --%>
<!-- 	<br /> 어제 초미세먼지 : -->
<%-- 	<c:forEach begin="0" end="37" step="1" var="index"> --%>
<%-- 		<c:out value="${yesterday25Grades[index]}" /> --%>
<%-- 	</c:forEach> --%>
<!-- 	<br /> 오늘 초미세먼지 : -->
<%-- 	<c:forEach begin="0" end="37" step="1" var="index"> --%>
<%-- 		<c:out value="${today25Grades[index]}" /> --%>
<%-- 	</c:forEach> --%>
<!-- 	<br /> 내일 초미세먼지 : -->
<%-- 	<c:forEach begin="0" end="37" step="1" var="index"> --%>
<%-- 		<c:out value="${tomorrow25Grades[index]}" /> --%>
<%-- 	</c:forEach> --%>
<!-- 	<br /> -->

</body>
</html>