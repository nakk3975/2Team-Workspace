function initMap() {
	var map = new google.maps.Map(document.getElementById('map'), {
		zoom: 2,
		center: { lat: 0, lng: 0 } // 지도의 초기 중심 위치
	});

	// 국가 마커와 지역 마커를 저장할 배열입니다.
	var countryMarkers = [];
	var regionMarkers = [];

	// 국가 정보를 불러와 마커를 생성합니다.
	$.ajax({
		type: "get",
		url: "/weather/countries",
		success: function(countries) {
			countries.forEach(function(country) {
				var marker = new google.maps.Marker({
					position: { lat: country.latitude, lng: country.longitude },
					map: map,
					title: country.name
				});
				countryMarkers.push(marker);

				// 국가 마커에 클릭 이벤트 리스너를 추가합니다.
				marker.addListener('click', function() {
					map.setZoom(8);
					map.setCenter(marker.getPosition());
					// 지역 마커를 불러오는 함수를 호출합니다.
					loadRegionMarkers(country.country, map);
				});
			});
		},
		error: function() {
			alert("나라 정보 불러오기 오류");
		}
	});

	// 지도의 줌 레벨이 변경될 때마다 마커의 가시성을 조절합니다.
	map.addListener('zoom_changed', function() {
		var zoomLevel = map.getZoom();
		// 줌 레벨에 따라 국가 마커와 지역 마커의 가시성을 조절합니다.
		countryMarkers.forEach(function(marker) {
			marker.setVisible(zoomLevel <= 6);
		});
		regionMarkers.forEach(function(marker) {
			marker.setVisible(zoomLevel > 6);
		});
	});

	// 도시 정보를 불러와 마커를 표시
	function loadRegionMarkers(countryCode, map) {
		$.ajax({
			type: "get",
			url: "/weather/region",
			data: { "countryCode": countryCode },
			success: function(response) {
				var regions = JSON.parse(response);
				// regions 배열을 순회합니다.
				for (var i = 0; i < regions.length; i++) {
					// 위도와 경도를 사용하여 마커를 생성합니다.
					var marker = new google.maps.Marker({
						position: { lat: regions[i].latitude, lng: regions[i].longitude },
						map: map,
						title: regions[i].name
					});
					// 마커를 배열에 추가합니다.
					regionMarkers.push(marker);

					marker.addListener('click', function() {
						// 지역 마커를 불러오는 함수를 호출합니다.
						loadWeatherForecast(marker.getPosition().lat(), marker.getPosition().lng());
						$('#weeklyWeather').show();
					});
				}
			},
			error: function() {
				alert("도시 정보 불러오기 오류");
			}
		});
	}

	// 현재 시간을 기준으로 가장 가까운 예보 데이터를 찾는 함수
	function findCurrentForecast(forecastList) {
		var now = new Date();
		var closestForecast = null;
		var closestTimeDiff = Infinity;

		forecastList.forEach(function(forecast) {
			var forecastTime = new Date(forecast.dt_txt);
			var timeDiff = Math.abs(forecastTime - now);
			if (timeDiff < closestTimeDiff) {
				closestTimeDiff = timeDiff;
				closestForecast = forecast;
			}
		});
		return closestForecast;
	}

	// 날씨 이미지를 불러오는 함수
	function getImage(weatherDescription) {
		var img = new Image();
		if (weatherDescription == "clear sky") {
			img.src = "/static/image/맑은하늘.png";
		} else if (weatherDescription == "few clouds") {
			img.src = "/static/image/대체로_맑음.png";
		} else if (weatherDescription == "scattered clouds") {
			img.src = "/static/image/구름_많음.png";
		} else if (weatherDescription == "broken clouds" || weatherDescription == "overcast clouds") {
			img.src = "/static/image/흐림.png";
		} else if (weatherDescription == "shower rain" || weatherDescription == "light rain" || weatherDescription == "rain" || weatherDescription == "heavy intensity rain" || weatherDescription == "moderate rain") {
			img.src = "/static/image/폭우.png";
		} else if (weatherDescription == "thunderstorm") {
			img.src = "/static/image/천둥번개.png";
		} else if (weatherDescription == "snow") {
			img.src = "/static/image/눈발.png";
		} else if (weatherDescription == "mist") {
			img.src = "/static/image/mist.png";
		}
		return img;
	}

	// 날씨 정보를 불러오는 함수
	function loadWeatherForecast(latitude, longitude) {
		$.ajax({
			type: "get",
			url: "/weather/forecast",
			data: { "lat": latitude, "lon": longitude },
			success: function(forecast) {
				var today = new Date();
				var forecastList = forecast.list;

				var forecastList = forecast.list;
				var currentForecast = findCurrentForecast(forecastList);
				if (currentForecast) {
					var nowTimeDiv = $('#nowTime');
					nowTimeDiv.empty(); // 기존 내용을 비웁니다.
					$('#nowWeather').empty();
					$('#weeklyForecast').empty();

					// 오늘의 모든 예보를 가져옵니다.
					var dailyForecasts = forecastList.filter(function(forecast) {
						var forecastDate = new Date(forecast.dt_txt);
						return forecastDate.getDate() === today.getDate();
					});

					// 켈빈을 섭씨로 변환합니다.
					var temp = (currentForecast.main.temp - 273.15).toFixed(0);
					var minTemp = (Math.min.apply(Math, dailyForecasts.map(function(forecast) { return forecast.main.temp_min; })) - 273.15).toFixed(0);
					var maxTemp = (Math.max.apply(Math, dailyForecasts.map(function(forecast) { return forecast.main.temp_max; })) - 273.15).toFixed(0);
					var feelTemp = (currentForecast.main.feels_like - 273.15).toFixed(0);
					var weatherDescription = currentForecast.weather[0].description;
					var pop = Math.round(currentForecast.pop * 100);
					var humidity = currentForecast.main.humidity; // 습도 값을 가져옵니다.

					var img = getImage(weatherDescription);

					nowTimeDiv.append($("<img>").attr("src", img.src).addClass("now-weather-icon"));
					nowTimeDiv.append($("<div>").text("현재 온도: " + temp + "°C").addClass("weather-temp"));
					nowTimeDiv.append($("<div>").text(pop + "%"));
					nowTimeDiv.append($("<div>").text(minTemp + "°/" + maxTemp + "° 체감온도 " + feelTemp + "°"));
					nowTimeDiv.append($("<div>").text("습도: " + humidity + "%"));
				}

				// 단기 데이터
				for (var i = 0; i < forecastList.length; i++) {
					var forecastTime = new Date(forecastList[i].dt_txt);
					if (forecastTime.getTime() >= today.getTime()) {
						var hoursDiff = Math.abs(today.getHours() - forecastTime.getHours());
						var timeDisplay = today.getDate() === forecastTime.getDate() ? (today > forecastTime ? hoursDiff + "시간 전" : hoursDiff + "시간 후") : forecastTime.getMonth() + 1 + "." + forecastTime.getDate() + "(" + ["일", "월", "화", "수", "목", "금", "토"][forecastTime.getDay()] + ")";
						var windDirection = ["북", "북동", "동", "남동", "남", "남서", "서", "북서"][Math.round(((forecastList[i].wind.deg % 360) / 45)) % 8];
						var rainProb = Math.round(forecastList[i].pop * 100) + "%";
						var maxTemp = (forecastList[i].main.temp_max - 273.15).toFixed(0);

						var img = getImage(forecastList[i].weather[0].description);
						var forecastDiv = $("<div class='time-weather'>").addClass("forecast");
						console.log(forecastList[i].weather[0].description);
						// 그래프 그리기
						var chartDiv = document.createElement('div');
						chartDiv.style.width = '100%';
						chartDiv.style.height = '200px';
						forecastDiv.append(chartDiv);

						var chart = echarts.init(chartDiv);
						var option = {
							grid: {
								//top: '5%', // 그래프의 위쪽 공백을 줄입니다.
								containLabel: true
							},
							xAxis: {
								type: 'category',
								data: ['Temp'],
								axisLabel: {
									show: false // 가로축 레이블을 제거합니다.
								}
							},
							yAxis: {
								type: 'value',
								min:0,
								max: Math.max.apply(Math, forecastList.map(function(forecast) { return (forecast.main.temp_max - 273.15).toFixed(0); })),
								axisLabel: {
									show: false // 세로축 레이블을 제거합니다.
								}
							},
							series: [{
								data: [(forecastList[i].main.temp_max - 273.15).toFixed(0)],
								type: 'bar',
								label: {
									show: true,
									position: 'top'
								}
							}]
						};
						chart.setOption(option);

						forecastDiv.append($("<div>").text(timeDisplay));
						forecastDiv.append($("<img>").attr("src", img.src).addClass("weather-icon"));
						forecastDiv.append($("<div>").text(maxTemp + "°"));
						forecastDiv.append($("<div>").text("강수확률: " + rainProb));
						forecastDiv.append($("<div>").text("풍향: " + windDirection));
						forecastDiv.append($("<div>").text("풍속: " + forecastList[i].wind.speed + "m/s"));
						
						$('#nowWeather').append(forecastDiv);
					}
				}

				var weeklyForecastList = forecastList.filter(function(forecast) {
					var forecastDate = new Date(forecast.dt_txt);
					return forecastDate.getHours() === 12; // 매일 오후 12시의 예보만 선택합니다.
				});

				// 주간 예보를 화면에 표시합니다.
				for (var i = 0; i < weeklyForecastList.length; i++) {
					var forecast = weeklyForecastList[i];
					var forecastDate = new Date(forecast.dt_txt);
					var dayOfWeek = ["일", "월", "화", "수", "목", "금", "토"][forecastDate.getDay()];
					var dateDisplay = (forecastDate.getMonth() + 1) + "." + forecastDate.getDate() + "(" + dayOfWeek + ")";
					var weeklyPop = Math.round(forecast.pop * 100);

					var dailyForecasts = forecastList.filter(function(forecast) {
						var forecastDateA = new Date(forecast.dt_txt);
						return forecastDate.getDate() === forecastDateA.getDate();
					});
					var minTemp = (Math.min.apply(Math, dailyForecasts.map(function(forecast) { return forecast.main.temp_min; })) - 273.15).toFixed(0);
					var maxTemp = (Math.max.apply(Math, dailyForecasts.map(function(forecast) { return forecast.main.temp_max; })) - 273.15).toFixed(0);
					var humidity = dailyForecasts[0].main.humidity;
		
					var imgMorning = getImage(dailyForecasts[0].weather[0].description); // 오전의 날씨 이미지
					var imgAfternoon = getImage(dailyForecasts[dailyForecasts.length - 1].weather[0].description);


					var forecastDiv = $("<div class='day-weather'>");
					forecastDiv.append($("<div>").text(dateDisplay));

					forecastDiv.append($("<img>").attr("src", imgMorning.src).addClass("now-weather-icon"));
					forecastDiv.append($("<img>").attr("src", imgAfternoon.src).addClass("now-weather-icon"));
					forecastDiv.append($("<div>").text(weeklyPop + "%"));
					forecastDiv.append($("<div>").text(minTemp + "° / " + maxTemp + "°"));
					forecastDiv.append($("<div>").text("습도: " + humidity + "%"));
					
					$('#weeklyForecast').append(forecastDiv); // 'weeklyForecast' div에 예보를 추가합니다.
				}
			},
			error: function() {
				alert("날씨 정보 불러오기 오류");
			}
		});
	}
}
// Google Maps 스크립트 로드 후 initMap 함수 호출
window.initMap = initMap;