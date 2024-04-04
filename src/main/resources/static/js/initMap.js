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
					});
				}
			},
			error: function() {
				alert("도시 정보 불러오기 오류");
			}
		});
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
				var weeklyWeather = $('#weeklyWeather');
				weeklyWeather.empty();

				for (var i = 0; i < forecastList.length; i++) {
					var forecastTime = new Date(forecastList[i].dt_txt);
					var hoursDiff = Math.abs(today.getHours() - forecastTime.getHours());
					var timeDisplay = today.getDate() === forecastTime.getDate() ? (today > forecastTime ? hoursDiff + "시간 전" : hoursDiff + "시간 후") : forecastTime.getMonth() + 1 + "." + forecastTime.getDate() + "(" + ["일", "월", "화", "수", "목", "금", "토"][forecastTime.getDay()] + ")";
					var windDirection = ["북", "북동", "동", "남동", "남", "남서", "서", "북서"][Math.round(((forecastList[i].wind.deg % 360) / 45)) % 8];
					var rainProb = Math.round(forecastList[i].pop * 100) + "%";
					var minTemp = (forecastList[i].main.temp_min - 273.15).toFixed(2);
					var maxTemp = (forecastList[i].main.temp_max - 273.15).toFixed(2);

					var forecastDiv = $("<div>").addClass("forecast");
					forecastDiv.append($("<h1>").text("예보"));
					forecastDiv.append($("<div>").text("시간: " + timeDisplay));
					forecastDiv.append($("<div>").text("날씨: " + forecastList[i].weather[0].description));
					forecastDiv.append($("<div>").text("풍향: " + windDirection));
					forecastDiv.append($("<div>").text("풍속: " + forecastList[i].wind.speed));
					forecastDiv.append($("<div>").text("강수확률: " + rainProb));
					forecastDiv.append($("<div>").text("최저기온: " + minTemp + "°C"));
					forecastDiv.append($("<div>").text("최고기온: " + maxTemp + "°C"));

					weeklyWeather.append(forecastDiv);
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


