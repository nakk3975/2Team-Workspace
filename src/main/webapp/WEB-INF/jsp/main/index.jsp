<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>우리 날씨</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/echarts@latest/dist/echarts.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=vzqhpvb94n"></script>

<link rel="stylesheet" href="/static/css/style.css">
</head>

<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section class="d-flex mt-3">
			<article class="col-9">
				<div>
					<div id="week">
						<h4>주간 예보</h4>
						<div id="location" class="d-flex">
							<select id="citySelect" class="form-control" style="width: 80%">
								<!-- 도시 옵션은 스크립트에서 동적으로 추가됩니다 -->
							</select> <select id="districtSelect" class="form-control"
								style="width: 80%">
								<!-- 구 옵션은 스크립트에서 동적으로 추가됩니다 -->
							</select>
							<button id="searchButton" class="btn btn-primary">조회</button>
						</div>
						<div id="weeklyWeather">
							<div id="nowTime">
								
							</div>
							<div id="nowWeather">
							</div>
							<div id="weeklyForecast">
							</div>
						</div>
					</div>
				</div>
			</article>
			<aside class="col-3">
				<h4 class="text-center">전국 날씨</h4>
				<div id="map" style="width: 100%; height: 350px;"></div>
				<div id="mapDetail" class="mt-3 pt-2 pb-2"></div>
			</aside>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div>
	<script src="/static/js/script.js"></script>
	<script>
		$(document).ready(function() {
	
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
		});
		
		function getFutureDate(dayOffset) {
		    let date = new Date();
		    date.setDate(date.getDate() + dayOffset);
		    let month = date.getMonth() + 1; // JavaScript의 getMonth()는 0부터 시작합니다.
		    let day = date.getDate();
		    let dayOfWeek = ["일", "월", "화", "수", "목", "금", "토"][date.getDay()]; // JavaScript의 getDay()는 일요일부터 시작합니다.
		    return month + "/" + day + "(" + dayOfWeek + ")";
		}

		function getWeatherIcon(weather) {
		    // 눈발, 흐림, 구름_많음, 폭우, 맑은하늘
			// - 맑음
			// - 구름많음, 구름많고 비, 구름많고 눈, 구름많고 비/눈, 구름많고 소나기
			// - 흐림, 흐리고 비, 흐리고 눈, 흐리고 비/눈, 흐리고 소나기

		    if (weather === "맑음") {
		        return "/static/image/맑은하늘.png";
		    } else if (weather === "구름많음") {
		        return "/static/image/구름_많음.png";
		    } else if (weather == "흐림") {
		        return "/static/image/흐림.png";
		    } else if(weather == "구름많고 비" || weather == "구름많고 비/눈" || weather == "구름많고 소나기"){
		        return "/static/image/폭우.png";
		    } else {
		    	return "/static/image/눈발.png";
		    }
		}
		
		$("#searchButton").click(function(){
			var city = $("#citySelect").val();
		    var district = $("#districtSelect").val();
		    var address = city + " " + district;
		    $("#weeklyWeather").show();
		    $.ajax({		        url: "/weather/searchAddress",
		        type: "GET",
		        data: {"address": address},
		        success: function(data){
		        	var json = JSON.parse(data);

		            // 위도와 경도를 가져옵니다.
		            var latlng = {
		                _lat: json.addresses[0].y,
		                _lng: json.addresses[0].x
		            };

		            // 위도와 경도를 격자 좌표로 변환합니다.
		            var grid = returnLatLng(latlng);
		            
		         	// 현재 날짜와 시간을 가져오기
					let now = new Date();
					let base_date = now.getFullYear().toString() + (now.getMonth() + 1).toString().padStart(2, '0') + now.getDate().toString().padStart(2, '0');  // 'YYYYMMDD' 형식의 오늘 날짜

					// API 제공 시간에 맞춰 base_time 설정
					let baseTimes = [2, 5, 8, 11, 14, 17, 20, 23];
					let currentHour = now.getHours();
					let base_time;
					for (let i = baseTimes.length - 1; i >= 0; i--) {
						if (currentHour >= baseTimes[i]) {
							base_time = (baseTimes[i] < 10 ? '0' : '') + baseTimes[i] + '00';
							break;
						}
					}

					$.ajax({
					    url: "/weather/midTa",
					    type: "GET",
					    data:{"city":city, "base_date":base_date},
					    success: function(data) {
					    	let taJson = JSON.parse(data);
					        let taItems = taJson.response.body.items.item;
				            
					        $.ajax({
							    url: "/weather/mid",
							    type: "GET",
							    data:{"city":city, "base_date":base_date},
							    success: function(data) {
							    	let midJson = JSON.parse(data);
							        let midItems = midJson.response.body.items.item;
				                    let taItem = taItems[0];
				                    let midItem = midItems[0];
				                    for(let i = 3; i <= 7; i++) {
				                        let dateDisplay = getFutureDate(i); // i일 후의 날짜를 가져옵니다.
				                        let forecastDiv = $("<div class='day-weather'>");
				                        forecastDiv.append($("<div>").text(dateDisplay));

				                        forecastDiv.append($("<img>").attr("src", getWeatherIcon(midItem["wf"+i+"Am"])).addClass("now-weather-icon"));
				                        forecastDiv.append($("<img>").attr("src", getWeatherIcon(midItem["wf"+i+"Pm"])).addClass("now-weather-icon"));
				                        forecastDiv.append($("<div>").text("강수 확률: " + midItem["rnSt"+i+"Am"] + "% / " + midItem["rnSt"+i+"Pm"] + "%"));
				                        forecastDiv.append($("<div>").text("최저/최고 기온: " + taItem["taMin"+i] + "° / " + taItem["taMax"+i] + "°"));

				                        $('#weeklyForecast').append(forecastDiv); // 'weeklyForecast' div에 예보를 추가합니다.
				                    }
				                    
				                }
				            });
				        }
				    });

					
					$.ajax({
						url: "/weather/getNowWeather",
						type: "GET",
						data: {"nx": grid.x,"ny": grid.y, "base_date":base_date, "base_time":base_time},
						success: function(data) {
							let nowJson = JSON.parse(data);
							console.log(nowJson);
							let nowItems = nowJson.response.body.items.item;
							let nowWeather = "";
							let temperature = ""; // 현재 온도
					        let humidity = "";  // 현재 습도
					        
							for(let i = 0; i < nowItems.length; i++) {
								if(nowItems[i].category == "PTY") {
									if (nowItems[i].obsrValue == '0') {
										nowWeather = "/static/image/흐림.png";
						    	    } else if (nowItems[i].obsrValue == '1') {
						    	    	nowWeather = "/static/image/폭우.png";
						    	    } else if (nowItems[i].obsrValue == '2') {
						    	    	nowWeather = "/static/image/눈발.png";
						    	    } else if (nowItems[i].obsrValue == '3') {
						    	    	nowWeather = "/static/image/눈발.png";
						    	    } else if (nowItems[i].obsrValue == '4') {
						    	    	nowWeather = "/static/image/폭우.png";
						    	    } else if (nowItems[i].obsrValue == '5') {
						    	    	nowWeather = "/static/image/폭우.png";
						    	    } else if (nowItems[i].obsrValue == '6') {
						    	    	nowWeather = "/static/image/눈발.png";
						    	    }
								} else if(nowItems[i].category == "SKY")  {
									if (nowItems[i].obsrValue == '1') {
										nowWeather = "/static/image/맑은하늘.png";
						    	    } else if (nowItems[i].obsrValue == '3') {
						    	    	nowWeather = "/static/image/구름_많음.png";
						    	    } else if (nowItems[i].obsrValue == '4') {
						    	    	nowWeather = "/static/image/흐림.png";
						    	    }
								} else if(nowItems[i].category == "T1H") {
									temperature = nowItems[i].obsrValue;
								} else if (nowItems[i].category == "REH") {
									humidity = nowItems[i].obsrValue;
								}
							}
					        // '#nowTime' div에 추가
					        $('#nowTime').append($("<img>").attr("src", nowWeather).addClass("weather-icon"));
					        $('#nowTime').append($("<div>").text("현재 온도 : " + temperature + "°").addClass("weather-temp"));
					        $('#nowTime').append($("<div>").text("습도 " + humidity + "%"));
						},
					    error: function() {
					        alert("현재 날씨 정보 에러");
					    }
					});

					$.ajax({
					    url: "/weather/getWeatherByAddress",
					    type: "GET",
					    data: {"nx": grid.x,"ny": grid.y, "base_date":base_date, "base_time":base_time},
					    success: function(data) {
					    	$('#nowWeather').val("");
					    	let weatherJson = JSON.parse(data);
					    	let addressItems = weatherJson.response.body.items.item;
					    	
					    	let weatherInfo = "";
					    	let weatherByDateTime = {};
					    	for (var i = 0; i < addressItems.length; i++) {
					    		let item = addressItems[i];
					    		let date = item.fcstDate; // 예측 날짜
					    		let time = item.fcstTime; // 예측 시간
					    		let dateTime = date + time; 
					    	    if (!weatherByDateTime[dateTime]) {
					    	        weatherByDateTime[dateTime] = {};
					    	    }
					    	    if (!weatherByDateTime[dateTime][item.category]) {
					    	        weatherByDateTime[dateTime][item.category] = item.fcstValue;
					    	    }
					    	}
					    	let dateTimes = Object.keys(weatherByDateTime).sort();
					    	for (let i = 0; i < dateTimes.length; i++) {
					    		let dateTime = dateTimes[i];
					    		let weatherInfo = weatherByDateTime[dateTime];
					    		let formattedDate = dateTime.substring(0, 8); 
					    		let formattedTime = dateTime.substring(8, 10) + '시';
					    		let direction = Math.floor((Number(weatherInfo.VEC) + 22.5 * 0.5) / 22.5);
					    		let directionNames = ["북", "북북동", "동북동", "동", "동동남", "동남", "남동남", "남", "남남서", "서남서", "서", "서서북", "서북", "북서북", "북", "북북동", "북"];
					    		let directionName = directionNames[direction];
					    	    
					    		let weather = "";
					    	    if (weatherInfo.SKY == '1') {
					    	        weather = "/static/image/맑은하늘.png";
					    	    } else if (weatherInfo.SKY == '3') {
					    	        weather = "/static/image/구름_많음.png";
					    	    } else if (weatherInfo.SKY == '4') {
					    	        weather = "/static/image/흐림.png";
					    	    } else if (weatherInfo.PTY == '1') {
					    	        weather = "/static/image/폭우.png";
					    	    } else if (weatherInfo.PTY == '2') {
					    	        weather = "/static/image/눈발.png";
					    	    } else if (weatherInfo.PTY == '3') {
					    	        weather = "/static/image/눈발.png";
					    	    } else if (weatherInfo.PTY == '4') {
					    	        weather = "/static/image/폭우.png";
					    	    }

					    	    let forecastDiv = $('<div>');

					    	    // 그래프 그리기
					    	    let chartDiv = document.createElement('div');
					    	    chartDiv.style.width = '100%';
					    	    chartDiv.style.height = '200px';
					    	    forecastDiv.append(chartDiv);

					    	    let chart = echarts.init(chartDiv);
					    	    let option = {
					    	        grid: {
					    	            containLabel: true
					    	        },
					    	        xAxis: {
					    	            type: 'category',
					    	            data: ['Temp'],
					    	            axisLabel: {
					    	                show: false
					    	            }
					    	        },
					    	        yAxis: {
					    	            type: 'value',
					    	            min:0,
					    	            max: weatherInfo.TMP,
					    	            axisLabel: {
					    	                show: false 
					    	            }
					    	        },
					    	        series: [{
					    	            data: [weatherInfo.TMP],
					    	            type: 'bar',
					    	            label: {
					    	                show: true,
					    	                position: 'top'
					    	            }
					    	        }]
					    	    };
					    	    chart.setOption(option);

					    	    forecastDiv.append($("<div>").text(formattedTime));
					    	    forecastDiv.append($("<img>").attr("src", weather).addClass("weather-icon"));
					    	    forecastDiv.append($("<div>").text(weatherInfo.TMP + "°"));
					    	    forecastDiv.append($("<div>").text("풍향: " + directionName));
					    	    forecastDiv.append($("<div>").text("풍속: " + weatherInfo.WSD + "m/s"));
					    	    
					    	    $('#nowWeather').append(forecastDiv);
					    	
					    	}
					    },
					    error: function() {
					        alert("날씨 정보 에러");
					    }
					});

		        },
		        error: function(){
		            alert("지역 좌표 불러오기 실패");
		        }
		    });
		});
	
	</script>
</body>
</html>