<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.google.gson.Gson"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<!-- Echarts -->
<script
	src="https://cdn.jsdelivr.net/npm/echarts@5.5.0/dist/echarts.min.js"></script>
<!-- 상단부 스타일 -->
<link rel="stylesheet" href="/static/css/finedustStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<!-- 카카오지도 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c2a73f16f9f1ea4f2552915a06073cfd"></script>

<!-- <script -->
<!-- 	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c2a73f16f9f1ea4f2552915a06073cfd&libraries=services,clusterer,drawing"></script> -->
<!-- <script src="/static/js/drawPolygon.js"></script> -->


<style>
/* 스타일링을 위한 간단한 CSS */
button {
	margin: 5px;
	padding: 10px;
	cursor: pointer;
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
	<div id="pageBox">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<div id="contentBox">
			<div id="mapBox" style="width: 600px; height: 650px;">
				<div id="map" style="width: 100%; height: 100%;"></div>
				<div id="resultImageContainer" style="display: none;">
					<img id="resultImage" src="" alt="Result Image"
						style="width: 600px; height: 650px;">
				</div>
			</div>
			<div id="graphBox">
				<div id="line10GraphBox"></div>
				<div id="line25GraphBox"></div>
				<div id="donutGraphBox">
					<div id="chartContainerO3"></div>
					<div id="chartContainerCO"></div>
					<div id="chartContainerSO2"></div>
					<div id="chartContainerNO2"></div>
					<div id="chartContainerAQI"></div>
				</div>
				<div id="donutGraphExplainBox">
					<div id="chartExplainSO2">
						<span>SO2</span>
					</div>
					<div id="chartExplainCO">
						<span>CO</span>
					</div>
					<div id="chartExplainNO2">
						<span>NO2</span>
					</div>
					<div id="chartExplainO3">
						<span>O3</span>
					</div>
					<div id="chartExplainAQI">
						<span>AQI</span>
					</div>
				</div>
			</div>
			<div id="pictureBox"></div>
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

	<button onclick="toggleView()">Toggle View</button>

	<div id="info-box"
		style="position: absolute; top: 10px; left: 10px; background-color: white; padding: 5px; border: 1px solid black; display: none;"></div>

	<!-- 대기오염 정보 지역별 차트 및 미세먼지/초미세먼지 정보-->
	<div id="gradeTableContainer"></div>

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

	<%
	String[][] todayAirs = (String[][]) request.getAttribute("todayAirs");
	String[][] dustGrades = (String[][]) request.getAttribute("dustGrades");
	Gson gson = new Gson();
	String jsonTodayAirs = gson.toJson(todayAirs);
	String jsonDustGrades = gson.toJson(dustGrades);
	%>

	<script>
		let polygons = [];

		function toggleView() {
			let mapContainer = document.getElementById('map');
			let resultImageContainer = document
					.getElementById('resultImageContainer');

			if (mapContainer.style.display === 'none') {
				mapContainer.style.display = 'block'; // 맵 보이기
				resultImageContainer.style.display = 'none'; // 결과 이미지 숨기기

				// 폴리곤 다시 지도에 추가
				for (let i = 0; i < polygons.length; i++) {
					polygons[i].setMap(map);
				}
			} else {
				mapContainer.style.display = 'none'; // 맵 숨기기
				resultImageContainer.style.display = 'block'; // 결과 이미지 보이기

				// 폴리곤 숨기기
				for (let i = 0; i < polygons.length; i++) {
					polygons[i].setMap(null);
				}
			}
		}

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
		let searchDate = "today"; // 기본값 오늘로 설정
		let searchTime = "Am"; // 기본값 오전으로 설정
		let searchDust = "10"; // 기본값 미세먼지로 설정
	

		function updateImageDate(value) {
			searchDate = value;
			updateResultImage();
		}

		function updateImageTime(value) {
			searchTime = value;
			updateResultImage();
		}

		function updateImageDust(value) {
			searchDust = value;
			updateResultImage();
		}

		let search;
		
		function updateResultImage() {
			imagePath = searchDate + searchTime + searchDust + "ImageUrl";
			search=searchDate + searchDust;
			loadMapAndPolygons(search);
			document.getElementById("resultImage").src = eval(imagePath);
		}

		let airData =
	<%=jsonTodayAirs%>
		;
		let dustData =
	<%=jsonDustGrades%>
		;

		//차트를 한번에 업데이트
		function updateCharts(cityIndex) {

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

			//도넛 차트에서 칠할 비율을 계산
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
			if (AQIRatio >= 100) {
				AQIRatio = 100;
			}
			let AQIRemain = 100 - AQIRatio;

			updateChart('SO2', SO2Data, SO2Ratio, SO2Remain, SO2Grade);
			updateChart('CO', COData, CORatio, CORemain, COGrade);
			updateChart('NO2', NO2Data, NO2Ratio, NO2Remain, NO2Grade);
			updateChart('O3', O3Data, O3Ratio, O3Remain, O3Grade);
			updateChart('AQI', AQIData, AQIRatio, AQIRemain, AQIGrade);
		}

		//각 차트 업데이트하는 함수
		function updateChart(chemical, data, ratio, remain, grade) {
			
			//차트 색 결정
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
							}
						}
					} ]
				} ],
			};

			let dom = document.getElementById("chartContainer" + chemical);
			let myChart = echarts.init(dom);
			myChart.setOption(option);

		}

		//우선 시험삼아 만든 등급 테이블 
		function updateGradeTable(cityIndex) {

			let yesterday10Grade = dustData[0][2 * (cityIndex) + 1];
			let today10Grade = dustData[1][2 * (cityIndex) + 1];
			let tomorrow10Grade = dustData[2][2 * (cityIndex) + 1];
			let yesterday25Grade = dustData[3][2 * (cityIndex) + 1];
			let today25Grade = dustData[4][2 * (cityIndex) + 1];
			let tomorrow25Grade = dustData[5][2 * (cityIndex) + 1];

			//사용하지 않는 도시 건너뛰기
			if (cityIndex >= 17) {
				cityIndex += 2;
			} else if (cityIndex >= 14) {
				cityIndex += 1;
			}

			let tableHtml = '<table border="1">' + '<tr>' + '<th> 등급 </th>'
					+ '<th> 어제 </th>' + '<th> 오늘 </th>' + '<th> 내일 </th>'
					+ '</tr>' + '<tr>' + '<td> 미세먼지 </td>' + '<td>'
					+ yesterday10Grade
					+ '</td>'
					+ '<td>'
					+ today10Grade
					+ '</td>'
					+ '<td>'
					+ tomorrow10Grade
					+ '</td>'
					+ '</tr>'
					+ '<tr>'
					+ '<td> 초 미세먼지 </td>'
					+ '<td>'
					+ yesterday25Grade
					+ '</td>'
					+ '<td>'
					+ today25Grade
					+ '</td>'
					+ '<td>'
					+ tomorrow25Grade + '</td>' + '</tr>' + '</table>';

			document.getElementById("gradeTableContainer").innerHTML = tableHtml;
		}

		//카카오 지도 그리기.
		function loadMapAndPolygons(search) {
			let map = new kakao.maps.Map(document.getElementById('map'), {
				center : new kakao.maps.LatLng(35.9078, 127.7669), // 대한민국의 중심 좌표
				level : 13, // 기본 배율 (대한민국 전체가 보이도록 조정)
				draggable : false, // 이동 기능 비활성화
				scrollwheel : false, // 확대/축소 기능 비활성화
				disableDoubleClickZoom : true
			// 더블클릭으로 확대 기능 비활성화
			});

			// JSON 파일 로드
			$.getJSON("/static/json/mapPolygon.json", function(data) {
				// JSON 데이터에서 features 배열 추출
				let features = data.features;

				// 폴리곤 배열 초기화
				let polygons = [];
				
				//오늘 미세먼지로 시험색상
				let timeIndex;
				if(search =='yesterday10'){
					timeIndex=0;
				}else if(search == 'today10'){
					timeIndex=1;
				}else if(search == 'tomorrow10'){
					timeIndex=2;
				}else if(search =='yesterday25'){
					timeIndex=3;
				}else if(search == 'today25'){
					timeIndex=4;
				}else if(search == 'tomorrow25'){
					timeIndex=5;
				}
				console.log(timeIndex);
				// 각 feature에 대해 폴리곤 생성
				for (let i = 0; i < features.length; i++) {
					let feature = features[i];
					let coordinates = feature.geometry.coordinates[0]; // 다각형의 첫 번째 좌표 배열만 사용
					let properties = feature.properties; // feature의 properties 가져오기
					let index = properties.INDEX;
					
					let grade = dustData[timeIndex][2 * (index) + 1];
					
					if (grade == '좋음') {
						gradeColor = '#32A1FF'; //파랑
					} else if (grade == '보통') {
						gradeColor = '#00C73C'; //녹색
					} else if (grade == '나쁨') {
						gradeColor = '#FDA60E'; //노랑
					} else {
						gradeColor = '#E64746'; //빨강
					}
					

					// 폴리곤 좌표 배열 초기화
					let polygonCoords = [];

					// 각 좌표에 대해 폴리곤 좌표 배열에 추가
					for (let j = 0; j < coordinates.length; j++) {
						let coord = coordinates[j];
						polygonCoords.push(new kakao.maps.LatLng(coord[1],
								coord[0]));
					}

					// 폴리곤 생성
					let fillColor = gradeColor;

					let polygon = new kakao.maps.Polygon({
						path : polygonCoords,
						strokeWeight : 1,
						strokeColor : '#000000',
						strokeOpacity : 0.8,
						strokeStyle : 'solid',
						fillColor : fillColor, // 색상 설정
						fillOpacity : 0.7
					});

					// 폴리곤 지도에 추가
					polygon.setMap(map);

					// 폴리곤 배열에 추가
					polygons.push(polygon);
				}
			});
		};

		window.onload = function() {
			updateCharts(0);
			updateResultImage();
			loadMapAndPolygons(search);
		};
	</script>
</body>
</html>