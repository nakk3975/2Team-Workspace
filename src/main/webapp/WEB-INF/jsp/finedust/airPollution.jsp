<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.google.gson.Gson"%>
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
#chart-container-SO2, #chart-container-CO, #chart-container-NO2,
	#chart-container-O3, #chart-container-AQI {
	display: inline-block;
	width: 100px;
	height: 100px;
	margin-right: 10px; /* 각 차트 사이의 간격 조정 */
}
</style>


<!-- 버튼스타일 -->
<style>
button {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            background-color: #007bff; /* 파랑색 배경 */
            color: #fff; /* 흰색 텍스트 */
            margin: 5px;
        }

        /* 버튼 호버 효과 */
        button:hover {
            background-color: #0056b3; /* 진한 파랑색 배경 */
        }

        /* 버튼 클릭 효과 */
        button:active {
            background-color: #004080; /* 더 진한 파랑색 배경 */
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



	<!-- 미세먼지 예측도 -->
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
		let tdate = "today"; // 기본값 오늘로 설정
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
	</script>

	<div>
		<img id="resultImage" src="" alt="Result Image">
	</div>




	<!-- 대기오염 정보 지역별 차트 및 미세먼지/초미세먼지 정보-->
	<div id="chart-container-O3"></div>
	<div id="chart-container-CO"></div>
	<div id="chart-container-SO2"></div>
	<div id="chart-container-NO2"></div>
	<div id="chart-container-AQI"></div>

	<div id="gradeTableContainer">
	
	</div>
	<%
	String[][] todayAirs = (String[][]) request.getAttribute("todayAirs");
	String[][] dustGrades = (String[][]) request.getAttribute("dustGrades");
	Gson gson = new Gson();
	String jsonTodayAirs = gson.toJson(todayAirs);
	String jsonDustGrades = gson.toJson(dustGrades);
	%>

	<div>
		<button onclick="updateCharts(0);">서울</button>
		<button onclick="updateCharts(1);">제주</button>
		<button onclick="updateCharts(2);">전남</button>
		<button onclick="updateCharts(3);">전북</button>
		<button onclick="updateCharts(4);">광주</button>
		<button onclick="updateCharts(5);">경남</button>
		<button onclick="updateCharts(6);">경북</button>
		<button onclick="updateCharts(7);">울산</button>
		<button onclick="updateCharts(8);">대구</button>
		<button onclick="updateCharts(9);">부산</button>
		<button onclick="updateCharts(10);">충남</button>
		<button onclick="updateCharts(11);">충북</button>
		<button onclick="updateCharts(12);">세종</button>
		<button onclick="updateCharts(13);">대전</button>
		<button onclick="updateCharts(14);">강원</button>
		<button onclick="updateCharts(15);">경기</button>
		<button onclick="updateCharts(16);">인천</button>
	</div>

	<script>
		function updateCharts(cityIndex) {

			let airData = <%=jsonTodayAirs%>;

			let SO2Data = parseFloat(airData[cityIndex][1]);
			let COData = parseFloat(airData[cityIndex][3]);
			let NO2Data = parseFloat(airData[cityIndex][5]);
			let O3Data = parseFloat(airData[cityIndex][7]);
			let AQIData = parseFloat(airData[cityIndex][13]);
			let SO2Grade = airData[cityIndex][0];
			let COGrade = airData[cityIndex][2];
			let NO2Grade = airData[cityIndex][4];
			let O3Grade = airData[cityIndex][6];
			let AQIGrade = airData[cityIndex][12];

			let SO2Ratio = (SO2Data / 0.15) * 100;
			if (SO2Ratio >= 100) {
				SO2Ratio = 100;
			}
			let SO2Remain = 100 - SO2Ratio;

			let CORatio = (COData / 15) * 100;
			if (CORatio >= 100) {
				CORatio = 100;
			}
			let CORemain = 100 - CORatio;

			let NO2Ratio = (NO2Data / 0.2) * 100;
			if (NO2Ratio >= 100) {
				NO2Ratio = 100;
			}
			let NO2Remain = 100 - NO2Ratio;

			let O3Ratio = (O3Data / 0.15) * 100;
			if (O3Ratio >= 100) {
				O3Ratio = 100;
			}
			let O3Remain = 100 - O3Ratio;

			let AQIRatio = (AQIData / 250) * 100;
			console.log(AQIData);
			if (AQIRatio >= 100) {
				AQIRatio = 100;
			}
			let AQIRemain = 100 - AQIRatio;

			updateChart('SO2', SO2Data, SO2Ratio, SO2Remain, SO2Grade);
			updateChart('CO', COData, CORatio, CORemain, COGrade);
			updateChart('NO2', NO2Data, NO2Ratio, NO2Remain, NO2Grade);
			updateChart('O3', O3Data, O3Ratio, O3Remain, O3Grade);
			updateChart('AQI', AQIData, AQIRatio, AQIRemain, AQIGrade);
			updateGradeTable(cityIndex);
		}

		function updateChart(chemical, data, ratio, remain, grade) {

			let gradeColor;
			let otherColor;

			if (grade == '좋음') {
				gradeColor = '#32A1FF'; //파랑
				otherColor = '#CEE5FD';
			} else if (grade == '보통') {
				gradeColor = '#00C73C'; //녹색
				otherColor = '#C8F0D4';
			} else if (grade == '나쁨') {
				gradeColor = '#FDA60E'; //노랑
				otherColor = '#FFDAB5';
			} else {
				gradeColor = '#E64746'; //빨강
				otherColor = '#F4CCCC';
			}

			let option = {
				legend : {
					show : false,
					orient : 'vertical',
					left : 10,
					data : [ chemical ]
				},
				series : [ {
					name : chemical,
					type : 'pie',
					radius : [ '50%', '70%' ],
					avoidLabelOverlap : false,
					label : {
						show : true,
						position : 'center',
						formatter : '{text|' + data + '}',
						rich : {
							text : {
								fontSize : 16,
								color : gradeColor,
								align : 'center',
								lineHeight : 24
							}
						}
					},
					labelLine : {
						show : false
					},
					data : [ {
						value : ratio,
						name : '사용한 비율',
						itemStyle : {
							normal : {
								color : gradeColor
							}
						}
					}, {
						value : remain,
						name : '나머지 비율',
						itemStyle : {
							normal : {
								color : otherColor
							// 연한색으로 채움.
							}
						}
					} ]
				} ],
			};

			let dom = document.getElementById("chart-container-" + chemical);
			let myChart = echarts.init(dom);
			myChart.setOption(option);

		}

		function updateGradeTable(cityIndex) {

			let dustData =<%=jsonDustGrades%>;

			//사용하지 않는 도시 건너뛰기
			if (cityIndex >= 17) {
				cityIndex += 2;
			} else if (cityIndex >= 14) {
				cityIndex += 1;
			}

			let yesterday10Grade = dustData[0][2 * (cityIndex) + 1];
			let today10Grade = dustData[1][2 * (cityIndex) + 1];
			let tomorrow10Grade = dustData[2][2 * (cityIndex) + 1];
			let yesterday25Grade = dustData[3][2 * (cityIndex) + 1];
			let today25Grade = dustData[4][2 * (cityIndex) + 1];
			let tomorrow25Grade = dustData[5][2 * (cityIndex) + 1];

			let tableHtml = '<table border="1">' +
		    '<tr>' +
		    '<th> 등급 </th>' +
		    '<th> 어제 </th>' +
		    '<th> 오늘 </th>' +
		    '<th> 내일 </th>' +
		    '</tr>' +
		    '<tr>' +
		    '<td> 미세먼지 </td>' +
		    '<td>' + yesterday10Grade + '</td>' +
		    '<td>' + today10Grade + '</td>' +
		    '<td>' + tomorrow10Grade + '</td>' +
		    '</tr>' +
		    '<tr>' +
		    '<td> 초 미세먼지 </td>' +
		    '<td>' + yesterday25Grade + '</td>' +
		    '<td>' + today25Grade + '</td>' +
		    '<td>' + tomorrow25Grade + '</td>' +
		    '</tr>' +
		    '</table>';

			document.getElementById("gradeTableContainer").innerHTML = tableHtml;
		}

		window.onload = function() {
			updateCharts(0);
			updateResultImage();
		};
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

</body>
</html>