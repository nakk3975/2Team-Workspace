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
			<div id="mapBox">
				<button id="menuButton" onclick="openMenuPopup()">메뉴</button>
				<div id="buttonBox">
					<div class="buttonGroup">
						<button onclick="updateImageDust('10')">미세먼지</button>
						<button onclick="updateImageDust('25')">초미세먼지</button>
					</div>
					<div class="buttonGroup">
						<button onclick="updateImageDate('yesterday')">어제</button>
						<button onclick="updateImageDate('today')">오늘</button>
						<button onclick="updateImageDate('tomorrow')">내일</button>
					</div>
					<div class="buttonGroup">
						<button onclick="updateImageTime('Am')">오전</button>
						<button onclick="updateImageTime('Pm')">오후</button>
					</div>
					<div class="buttonGroup">
						<button class="toggleButton" onclick="toggleView()">자세히</button>
					</div>
				</div>
				<div id="map"></div>
				<div id="resultImageContainer">
					<img id="resultImage" src="" alt="Result Image">
				</div>
			</div>
			<div id="graphBox">
				<div id="regionButtonBox">
					<button id="regionPopupButtons" onclick="openRegionPopup()">지역선택</button>
					<div id="graphTitle">
						<span>현재 대기 상태</span>
					</div>

					<div id="regionButtons">
						<button onclick="updateCharts(14);">강원</button>
						<button onclick="updateCharts(15);">경기</button>
						<button onclick="updateCharts(5);">경남</button>
						<button onclick="updateCharts(6);">경북</button>
						<button onclick="updateCharts(4);">광주</button>
						<button onclick="updateCharts(8);">대구</button>
						<button onclick="updateCharts(13);">대전</button>
						<button onclick="updateCharts(9);">부산</button>
						<button onclick="updateCharts(0);">서울</button>
						<button onclick="updateCharts(12);">세종</button>
						<button onclick="updateCharts(7);">울산</button>
						<button onclick="updateCharts(16);">인천</button>
						<button onclick="updateCharts(2);">전남</button>
						<button onclick="updateCharts(3);">전북</button>
						<button onclick="updateCharts(1);">제주</button>
						<button onclick="updateCharts(10);">충남</button>
						<button onclick="updateCharts(11);">충북</button>
					</div>
				</div>

				<div id="dustGraphBox">
					<div id="chartContainerdust10"></div>
					<div id="chartContainerdust25"></div>
				</div>

				<div id="dustGraphExplainBox">
					<div id="chartExplainO3">
						<span>미세먼지</span>
					</div>
					<div id="chartExplainCO">
						<span>초미세먼지</span>
					</div>
				</div>

				<div id="otherGraphBox">
					<div id="chartContainerO3"></div>
					<div id="chartContainerCO"></div>
					<div id="chartContainerSO2"></div>
					<div id="chartContainerNO2"></div>
					<div id="chartContainerAQI"></div>
				</div>

				<div id="otherGraphExplainBox">
					<div id="chartExplainO3">
						<span>오존</span>
					</div>
					<div id="chartExplainCO">
						<span>일산화탄소</span>
					</div>
					<div id="chartExplainSO2">
						<span>아황산가스</span>
					</div>
					<div id="chartExplainNO2">
						<span>이산화질소</span>
					</div>
					<div id="chartExplainAQI">
						<span>통합대기</span>
					</div>
				</div>

				<div id="gradeTableBox">
					<img src="/static/image/gradeTable.jpg" id="gradeTable" alt="등급표">
				</div>
			</div>
		</div>
		<div id="sourceExplainBox">
			<span>자료 출처 - 에어코리아</span>
		</div>
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

		function openRegionPopup() {
			let regionPopup = document.getElementById("regionButtons");
			if (regionPopup.style.display === "grid") {
				regionPopup.style.display = "none";
			} else {
				regionPopup.style.display = "grid";
			}
		}

		function openMenuPopup() {
			let menuPopup = document.getElementById("buttonBox");
			if (menuPopup.style.display === "grid") {
				menuPopup.style.display = "none";
			} else {
				menuPopup.style.display = "grid";
			}
		}

		function toggleView() {

			let button = document.activeElement;
			if (button.innerText === "자세히") {
				button.innerText = "간단히";
			} else {
				button.innerText = "자세히";
			}

			let mapContainer = document.getElementById('map');
			let resultImageContainer = document
					.getElementById('resultImageContainer');

			if (mapContainer.style.display === 'none') {
				mapContainer.style.display = 'block';
				resultImageContainer.style.display = 'none';

				for (let i = 0; i < polygons.length; i++) {
					polygons[i].setMap(map);
				}
			} else {
				mapContainer.style.display = 'none';
				resultImageContainer.style.display = 'block';

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

		let imagePath = "";
		let searchDate = "today";
		let searchTime = "Am";
		let searchDust = "10";
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
			search = searchDate + searchDust;
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
			let dust10Data = parseFloat(airData[cityIndex][9]);
			let dust25Data = parseFloat(airData[cityIndex][11]);
			let AQIData = parseFloat(airData[cityIndex][13]);
			let SO2Grade = airData[cityIndex][0];
			let COGrade = airData[cityIndex][2];
			let NO2Grade = airData[cityIndex][4];
			let O3Grade = airData[cityIndex][6];
			let dust10Grade = airData[cityIndex][8];
			let dust25Grade = airData[cityIndex][10];
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

			let dust10Ratio = (dust10Data / 150) * 100;
			if (dust10Ratio >= 100) {
				dust10Ratio = 100;
			}
			let dust10Remain = 100 - dust10Ratio;

			let dust25Ratio = (dust25Data / 75) * 100;
			if (dust25Ratio >= 100) {
				dust25Ratio = 100;
			}
			let dust25Remain = 100 - dust25Ratio;

			updateChart('SO2', SO2Data, SO2Ratio, SO2Remain, SO2Grade);
			updateChart('CO', COData, CORatio, CORemain, COGrade);
			updateChart('NO2', NO2Data, NO2Ratio, NO2Remain, NO2Grade);
			updateChart('O3', O3Data, O3Ratio, O3Remain, O3Grade);
			updateChart('AQI', AQIData, AQIRatio, AQIRemain, AQIGrade);
			updateChart('dust10', dust10Data, dust10Ratio, dust10Remain,
					dust10Grade);
			updateChart('dust25', dust25Data, dust25Ratio, dust25Remain,
					dust25Grade);
			console.log(dust10Data);
			console.log(dust25Data);
			console.log(dust10Grade);
			console.log(dust25Grade);

			let regionPopup = document.getElementById("regionButtons");
			regionPopup.style.display = "none";
		}

		//각 차트 업데이트하는 함수
		function updateChart(chemical, data, ratio, remain, grade) {

			let gradeColor;
			let otherColor;
			let textSize;

			if (chemical === 'dust10' || chemical === 'dust25') {
				textSize = 30;
			} else {
				textSize = 16;
			}

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
								fontSize : textSize,
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

		//카카오 지도 그리기.
		function loadMapAndPolygons(search) {
			let map = new kakao.maps.Map(document.getElementById('map'), {
				center : new kakao.maps.LatLng(35.9078, 127.7669),
				level : 13,
				draggable : false,
				scrollwheel : false,
				disableDoubleClickZoom : true
			});

			// JSON 파일 로드
			$.getJSON("/static/json/mapPolygon.json", function(data) {
				let features = data.features;
				let polygons = [];

				let timeIndex;
				if (search == 'yesterday10') {
					timeIndex = 0;
				} else if (search == 'today10') {
					timeIndex = 1;
				} else if (search == 'tomorrow10') {
					timeIndex = 2;
				} else if (search == 'yesterday25') {
					timeIndex = 3;
				} else if (search == 'today25') {
					timeIndex = 4;
				} else if (search == 'tomorrow25') {
					timeIndex = 5;
				}

				for (let i = 0; i < features.length; i++) {
					let feature = features[i];
					let coordinates = feature.geometry.coordinates[0];
					let properties = feature.properties;
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

					let polygonCoords = [];

					for (let j = 0; j < coordinates.length; j++) {
						let coord = coordinates[j];
						polygonCoords.push(new kakao.maps.LatLng(coord[1],
								coord[0]));
					}

					let fillColor = gradeColor;

					let polygon = new kakao.maps.Polygon({
						path : polygonCoords,
						strokeWeight : 1,
						strokeColor : '#000000',
						strokeOpacity : 0.8,
						strokeStyle : 'solid',
						fillColor : fillColor,
						fillOpacity : 0.7
					});

					polygon.setMap(map);
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