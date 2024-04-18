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
<script	src="https://cdn.jsdelivr.net/npm/echarts@5.5.0/dist/echarts.min.js"></script>
<!-- 카카오지도 -->
<script type="text/javascript"src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c2a73f16f9f1ea4f2552915a06073cfd"></script>
<!-- 상단부 스타일 -->
<link rel="stylesheet" href="/static/css/finedustStyle.css"	type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"	crossorigin="anonymous">

<meta charset="UTF-8">
<title>우리 날씨 - 대기오염</title>
</head>

<body>
	<div id="pageBox">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<div id="titleBox">
			<div id="title">
				<span>미세먼지</span>
			</div>
		</div>
		<div id="contentBox">
			<div id="mapBox">
				<button id="menuButton" onclick="openMenuPopup()">메뉴</button>
				<button id="toggleButton" onclick="toggleView(); showMenuButton(); closeMenuPopup(); toggleInfo()">예측도</button>
				<div id="mapTitle">현황도</div>
				<div id="mapInfo"></div>
				<div id="buttonBox">
					<div class="buttonGroup">
						<button onclick="updateImageDust('10'); showMapInfo(searchDate , searchTime, '10')">미세먼지</button>
						<button onclick="updateImageDust('25'); showMapInfo(searchDate , searchTime, '25')">초미세먼지</button>
					</div>
					<div class="buttonGroup">
						<button onclick="updateImageDate('yesterday'); showMapInfo('yesterday', searchTime, searchDust)">어제</button>
						<button onclick="updateImageDate('today'); showMapInfo('today' , searchTime, searchDust)">오늘</button>
						<button onclick="updateImageDate('tomorrow'); showMapInfo('tomorrow' , searchTime, searchDust)">내일</button>
					</div>
					<div class="buttonGroup">
						<button onclick="updateImageTime('Am'); showMapInfo(searchDate , 'Am', searchDust)">오전</button>
						<button onclick="updateImageTime('Pm'); showMapInfo(searchDate , 'Pm', searchDust)">오후</button>
					</div>
					
				</div>
				<div id="map"></div>
					<div id="resultImageContainer">
    					<img id="resultImage" src="" alt="">
  						<span class="alt-text">이미지가 아직 없습니다.</span>
					</div>
				</div>
			<div id="graphBox">
				<div id="regionButtonBox">
					<button id="regionPopupButtons" onclick="openRegionPopup()">지역선택</button>
					<div id="graphTitle"></div>
					<div id="regionButtons">
						<button onclick="updateCharts(14); showRegionInfo('강원');">강원</button>
    					<button onclick="updateCharts(15); showRegionInfo('경기');">경기</button>
    					<button onclick="updateCharts(5); showRegionInfo('경남');">경남</button>
   					 	<button onclick="updateCharts(6); showRegionInfo('경북');">경북</button>
					    <button onclick="updateCharts(4); showRegionInfo('광주');">광주</button>
					    <button onclick="updateCharts(8); showRegionInfo('대구');">대구</button>
					    <button onclick="updateCharts(13); showRegionInfo('대전');">대전</button>
					    <button onclick="updateCharts(9); showRegionInfo('부산');">부산</button>
					    <button onclick="updateCharts(0); showRegionInfo('서울');">서울</button>
					    <button onclick="updateCharts(12); showRegionInfo('세종');">세종</button>
					    <button onclick="updateCharts(7); showRegionInfo('울산');">울산</button>
					    <button onclick="updateCharts(16); showRegionInfo('인천');">인천</button>
					    <button onclick="updateCharts(2); showRegionInfo('전남');">전남</button>
					    <button onclick="updateCharts(3); showRegionInfo('전북');">전북</button>
					    <button onclick="updateCharts(1); showRegionInfo('제주');">제주</button>
					    <button onclick="updateCharts(10); showRegionInfo('충남');">충남</button>
					    <button onclick="updateCharts(11); showRegionInfo('충북');">충북</button>
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
					<img src="/static/image/airGradeTable.png" id="gradeTable" alt="등급표">
				</div>
			</div>
		</div>
		<div id="sourceExplainBox">
			<span>자료 출처 - 에어코리아</span>
		</div>
	</div>
	
	<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	


	

	<script>
		//사용할 api 데이터 Json 형태로 만듦 (ajax 를 사용하지 않고, 자바 내장 Future 클래스를 사용하여 배열로 만들어 넘겼음.)
		<%
		String[][] todayAirs = (String[][]) request.getAttribute("todayAirs");
		String[][] dustGrades = (String[][]) request.getAttribute("dustGrades");
		Gson gson = new Gson();
		String jsonTodayAirs = gson.toJson(todayAirs);
		String jsonDustGrades = gson.toJson(dustGrades);
		%>
		
		//airData : 금일 대기정보 api, dustData : 어제~내일의 미세먼지, 초미세먼지 등급예보 api.
		let airData =<%=jsonTodayAirs%>;
		let dustData =<%=jsonDustGrades%>;
		
		//에어코리아에서 제공하는 예측도 api
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

		//버튼에 따라 변수들이 바뀌고, 이 변수값들을 합쳐 불러올 이미지를 지정.
		let imagePath = "";
		let searchDate = "today";
		let searchTime = "";
		let searchDust = "10";
		
		//오전, 오후 기본값을 현재 시간에 따라 변경
		let currentTime = new Date();
	    let currentHour = currentTime.getHours();
	    searchTime = currentHour >= 12 ? 'Pm' : 'Am';
	    

		//지역 선택버튼 팝업
		function openRegionPopup() {
			let regionPopup = document.getElementById("regionButtons");
			if (regionPopup.style.display === "grid") {
				regionPopup.style.display = "none";
			} else {
				regionPopup.style.display = "grid";
			}
		}
		
		//지도 위 메뉴버튼
		function showMenuButton(){
			let menuButtonPopup = document.getElementById("menuButton");
			if(menuButtonPopup.style.display == "grid"){
				menuButtonPopup.style.display = "none";
			} else {
				menuButtonPopup.style.display = "grid";
			}
		}

		//지도 위 메뉴창 팝업
		function openMenuPopup() {
			let menuPopup = document.getElementById("buttonBox");
			if (menuPopup.style.display === "grid") {
				menuPopup.style.display = "none";
			} else {
				menuPopup.style.display = "grid";
			}
		}
		
		//토글버튼을 누르면 메뉴팝업창을 닫음.
		function closeMenuPopup(){
			let menuPopup = document.getElementById("buttonBox");
			if (menuPopup.style.display === "grid") {
				menuPopup.style.display = "none";
			}
		}
		
		// 선택된 지역 정보를 표시
		function showRegionInfo(regionName) {
		    let graphTitle = document.getElementById("graphTitle");
		    graphTitle.innerHTML = "<span>" + regionName + '의 현재 대기상태' + "</span>";
		}
		
		
		//선택된 지도 정보를 표시
		function showMapInfo(searchDate , searchTime, searchDust){
			let mapInfo = document.getElementById("mapInfo");
			
			let dateInfo;
			let timeInfo;
			let dustInfo;
			
			if(searchDate=='yesterday'){
				dateInfo='어제 ';
			}else if (searchDate =='today'){
				dateInfo='오늘 ';
			}else{
				dateInfo='내일 ';
			}
			
			if(searchTime =='Am'){
				timeInfo ='오전 ';
			}else {
				timeInfo ='오후 ';
			}
			
			if(searchDust == '10'){
				dustInfo ='미세먼지 ';
			}else{
				dustInfo ='초미세먼지 ';
			}
			
			let info = dateInfo + timeInfo + dustInfo;
			
		   	mapInfo.innerHTML = "<span>" + info + "</span>";
		}
		
		function toggleInfo(){
			let mapInfo = document.getElementById("mapInfo");
			if (mapInfo.style.display === "grid") {
				mapInfo.style.display = "none";
			} else {
				mapInfo.style.display = "grid";
			}
		}
		
		
		//에어코리아에서 제공하는 예측도와, 에어코리아에서 제공하는 데이터를 기반으로 그린 폴리곤 지도를 토글하는 기능
		let polygons = [];
		
		function toggleView() {
			
			let resultImageContainer = document.getElementById('resultImageContainer');
			let button = document.activeElement;
			if (button.innerText === "예측도") {
				button.innerText = "현황도";
				resultImageContainer.style.display = 'flex';
			} else {
				button.innerText = "예측도";
				resultImageContainer.style.display = 'none';
			}
		}
		
		//어제, 오늘, 내일 버튼
		function updateImageDate(value) {
			searchDate = value;
			updateResultImage();
		}

		//오전, 오후 버튼
		function updateImageTime(value) {
			searchTime = value;
			updateResultImage();
		}
		
		//미세먼지, 초미세먼지 버튼
		function updateImageDust(value) {
			searchDust = value;
			updateResultImage();
		}

		let search;

		//위의 버튼값을 토대로 불러올 이미지를 결정.
		function updateResultImage() {
			imagePath = searchDate + searchTime + searchDust + "ImageUrl";
			search = searchDate + searchDust;
			document.getElementById("resultImage").src = eval(imagePath);
		}

		
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
			

			//도넛 차트에서 칠할 비율을 계산. remain은 남은부분. 연한색으로 칠하기위해 따로 저장
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

			//각 차트를 업데이트
			updateChart('SO2', SO2Data, SO2Ratio, SO2Remain, SO2Grade);
			updateChart('CO', COData, CORatio, CORemain, COGrade);
			updateChart('NO2', NO2Data, NO2Ratio, NO2Remain, NO2Grade);
			updateChart('O3', O3Data, O3Ratio, O3Remain, O3Grade);
			updateChart('AQI', AQIData, AQIRatio, AQIRemain, AQIGrade);
			updateChart('dust10', dust10Data, dust10Ratio, dust10Remain, dust10Grade);
			updateChart('dust25', dust25Data, dust25Ratio, dust25Remain, dust25Grade);

			//지역을 선택하면, 지역선택창이 닫히도록함.
			let regionPopup = document.getElementById("regionButtons");
			regionPopup.style.display = "none";
		}

		
		//각 차트 업데이트하는 함수
		function updateChart(chemical, data, ratio, remain, grade) {

			let gradeColor;
			let otherColor;
			let textSize;

			//미세먼지, 초미세먼지 라벨 글씨크기를 크게만듦.
			if (chemical === 'dust10' || chemical === 'dust25') {
				textSize = 30;
			} else {
				textSize = 16;
			}

			//api에서 얻은 등급에 따라 도넛 그래프의 색을 지정
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

			//그래프 생성
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
		function loadMapAndPolygons(searchDust) {
			let map = new kakao.maps.Map(document.getElementById('map'), {
				center : new kakao.maps.LatLng(35.9078, 127.7669),
				level : 13,
				draggable : false,
				scrollwheel : false,
				disableDoubleClickZoom : true
			});

			// 지역별로 그린 폴리곤 좌표 배열을 담은 JSON 파일 불러오기.
			$.getJSON("/static/json/mapPolygon.json", function(data) {
				let features = data.features;
				let polygons = [];

				//각 폴리곤을 칠할때 참조할 데이터 배열 dustData의 index를 결정
				let dustIndex;
				if (searchDust == '10') {
					dustIndex = 8;
				} else if (searchDust == '25') {
					dustIndex = 10;
				}

				for (let i = 0; i < features.length; i++) {
					let feature = features[i];
					let coordinates = feature.geometry.coordinates[0];
					
					//json 파일 내 properties에서 각 도시별로 지정한 index를 불러옴.
					let properties = feature.properties;
					let index = properties.INDEX;

					let grade = airData[index][dustIndex];

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
						polygonCoords.push(new kakao.maps.LatLng(coord[1],coord[0]));
					}

					//폴리곤을 생성 후 등급에 따라 색을 칠함.
					let polygon = new kakao.maps.Polygon({
						path : polygonCoords,
						strokeWeight : 1,
						strokeColor : '#000000',
						strokeOpacity : 0.8,
						strokeStyle : 'solid',
						fillColor : gradeColor,
						fillOpacity : 0.7
					});

					polygon.setMap(map);
					polygons.push(polygon);
				}
			});
		};

		//서울기준 도넛그래프, 오늘오전 미세먼지 예측도, 오늘오전 미세먼지 폴리곤지도를 페이지 로딩시 불러옴.
		window.onload = function() {
			updateCharts(0);
			updateResultImage();
			loadMapAndPolygons(searchDust);
			showRegionInfo('서울');
			showMapInfo('today' , searchTime , '10');
		};
	</script>
</body>
</html>