<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<!-- 상오님이 만드신 상단부 css 일단 시험적용 -->
<link rel="stylesheet" href="/static/css/getSatelliteImages.css"
	type="text/css">

<!-- 	카카오지도 -->
<!-- <script type="text/javascript" -->
<!-- 	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c2a73f16f9f1ea4f2552915a06073cfd"></script> -->
'

<!-- jquery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Echarts -->
<script
	src="https://cdn.jsdelivr.net/npm/echarts@5.5.0/dist/echarts.min.js"></script>

<!-- <script -->
<!-- 	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c2a73f16f9f1ea4f2552915a06073cfd&libraries=services,clusterer,drawing"></script> -->
<!-- <script src="/static/js/drawPolygon.js"></script> -->


<!-- 버튼 실험중 -->
<style>
/* 스타일링을 위한 간단한 CSS */
button {
	margin: 5px;
	padding: 10px;
	cursor: pointer;
}
</style>

<!-- 차트 담을 div -->
<style>
    #chart-container-SO2,
    #chart-container-CO,
    #chart-container-NO2,
    #chart-container-O3,
    #chart-container-AQI {
        display: inline-block;
        width: 50px;
        height: 50px;
        margin-right: 10px; /* 각 차트 사이의 간격 조정 */
    }
</style>


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
		<button onclick="updateImageDate('yesterday')">어제</button>
		<button onclick="updateImageDate('today')">오늘</button>
		<button onclick="updateImageDate('tomorrow')">내일</button>
	</div>
	<div>
		<button onclick="updateImageTime('Am')">오전</button>
		<button onclick="updateImageTime('Pm')">오후</button>
	</div>
	<div>
		<button onclick="updateImageDust('10')">미세먼지</button>
		<button onclick="updateImageDust('25')">초미세먼지</button>
	</div>

	<!-- 미세먼지 사진 교체버튼 (꾸미기만 남음) -->
	<script>
		let todayAm10ImageUrl = "${todayAm10Image}";
		let todayAm25ImageUrl = "${todayAm25Image}";
		let todayPm10ImageUrl = "${todayPm10Image}";
		let todayPm25ImageUrl = "${todayPm25Image}";
		let yesterdayAm10ImageUrl = "${yesterdayAm10Image}";
		let yesterdayAm25ImageUrl = "${yesterdayAm25Image}";
		let yesterdayPm10ImageUrl = "${yesterdayPm10Image}";
		let yesterdayPm25ImageUrl = "${yesterdayPm25Image}";
		let tomorrowAm10ImageUrl = "${tomorrowAm10Image}";
		let tomorrowAm25ImageUrl = "${tomorrowAm25Image}";
		let tomorrowPm10ImageUrl = "${tomorrowPm10Image}";
		let tomorrowPm25ImageUrl = "${tomorrowPm25Image}";

		let imagePath = ""; // 초기 이미지 경로
		let tdate = "today";
		let ttime = "Am"; // 기본값 오전으로 설정
		let tdust = "10"; // 기본값 미세먼지로 설정

		function updateImageDate(value) {
			tdate = value;
			updateResultImage();
		}

		function updateImageTime(value) {
			ttime = value;
			updateResultImage();
		}

		function updateImageDust(value) {
			tdust = value;
			updateResultImage();
		}

		function updateResultImage() {
			imagePath = tdate + ttime + tdust + "ImageUrl";
			document.getElementById("resultImage").src = eval(imagePath);
		}

		window.onload = function() {
			updateResultImage();
		};
	</script>

	<div>
		<img id="resultImage" src="" alt="Result Image">
	</div>


<!-- 차트 작업중 -->
<div id="chart-container-SO2" style="width: 100px; height: 100px;"></div>
<div id="chart-container-CO" style="width: 100px; height: 100px;"></div>
<div id="chart-container-NO2" style="width: 100px; height: 100px;"></div>
<div id="chart-container-O3" style="width: 100px; height: 100px;"></div>
<div id="chart-container-AQI" style="width: 100px; height: 100px;"></div>

<div>
    <!-- JSP 코드 -->
    <% 
    // 모델에서 데이터 가져오기
    String[][] data = (String[][]) request.getAttribute("todayAirs"); 
    %>

    <% 
    // 해당하는 지역의 데이터 인덱스 설정 
    double SO2Data = Double.parseDouble(data[0][1]); 
    double COData = Double.parseDouble(data[0][3]); 
    double NO2Data = Double.parseDouble(data[0][5]); 
    double O3Data = Double.parseDouble(data[0][7]); 
    double AQIData = Double.parseDouble(data[0][13]);
    String SO2Grade = data[0][0];
    String COGrade = data[0][2];
    String NO2Grade = data[0][4];
    String O3Grade = data[0][6];
    String AQIGrade = data[0][12];
    
    // 사용한 비율과 나머지 비율. 
    double SO2Ratio = (double) SO2Data / 0.15 * 100; 
    if (SO2Ratio >= 100) { 
        SO2Ratio = 100; 
    } 
    double SO2Remain = 100 - SO2Ratio; 
    
    double CORatio = (double) COData / 15 * 100; 
    if (CORatio >= 100) { 
        CORatio = 100; 
    } 
    double CORemain = 100 - CORatio; 

    double NO2Ratio = (double) NO2Data / 0.2 * 100; 
    if (NO2Ratio >= 100) { 
        NO2Ratio = 100; 
    } 
    double NO2Remain = 100 - NO2Ratio; 

    double O3Ratio = (double) O3Data / 0.15 * 100; 
    if (O3Ratio >= 100) { 
        O3Ratio = 100; 
    } 
    double O3Remain = 100 - O3Ratio; 

    double AQIRatio = (double) AQIData / 250 * 100; 
    if (AQIRatio >= 100) { 
        AQIRatio = 100; 
    } 
    double AQIRemain = 100 - AQIRatio; 
    %>

    <button onclick="updateCharts()">서울</button>
</div>

<script>
function updateCharts() {
    updateChart('SO2', <%= SO2Ratio %>, <%= SO2Remain %>, '<%= SO2Grade %>');
    updateChart('CO', <%= CORatio %>, <%= CORemain %>, '<%= COGrade %>');
    updateChart('NO2', <%= NO2Ratio %>, <%= NO2Remain %>, '<%= NO2Grade %>');
    updateChart('O3', <%= O3Ratio %>, <%= O3Remain %>, '<%= O3Grade %>');
    updateChart('AQI', <%= AQIRatio %>, <%= AQIRemain %>, '<%= AQIGrade %>');
}

function updateChart(chemical, ratio, remain, grade) {
    let option = {
        legend: {
            orient: 'vertical',
            left: 10,
            data: [chemical]
        },
        series: [{
            name: chemical,
            type: 'pie',
            radius: ['50%', '70%'],
            avoidLabelOverlap: false,
            label: {
                show: true,
                position: 'center',
                formatter: '{text|' + grade + '}',
                rich: {
                    text: {
                        fontSize: 16,
                        color: '#333',
                        align: 'center',
                        lineHeight: 24
                    }
                }
            },
            labelLine: {
                show: false
            },
            data: [{
                value: ratio,
                name: '사용한 비율'
            }, {
                value: remain,
                name: '나머지 비율',
                itemStyle: {
                    normal: {
                        color: 'rgba(128, 128, 128, 0.5)'  // 옅은 회색으로 변경
                    }
                }
            }]
        }],
        tooltip: null,
        hover: null
    };

    let dom = document.getElementById("chart-container-" + chemical);
    let myChart = echarts.init(dom);
    myChart.setOption(option);
}
</script>

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




	<!-- 		지역별 등급 출력 테스트 -->
	<%-- 	<c:forEach begin="0" end="37" step="1" var="index"> --%>
	<%-- 		<c:out value="${today10Grades[index]}" /> --%>
	<%-- 	</c:forEach> --%>

</body>
</html>