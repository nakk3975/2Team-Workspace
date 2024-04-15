var mapOptions = {
	center: new naver.maps.LatLng(36.0065, 127.5780),
	zoom: 6
};

var map = new naver.maps.Map('map', mapOptions);

var cities = ["서울", "춘천", "강릉", "안동", "포항", "대전", "대구", "전주", "부산", "여수", "광주", "제주"];

cities.forEach(function(city) {
	$.ajax({
		url: '/weather/getCityLocation',
		data: { city: city },
		success: function(data) {
			var json = JSON.parse(data)
			if (json.status === "OK" && json.addresses && json.addresses.length > 0) {
				var location = new naver.maps.LatLng(json.addresses[0].y, json.addresses[0].x);

				var CustomOverlay = function(options) {
					this._element = $('<div class="overlay"><div class="label">' + city + '</div></div>')

					this._addListener();
					this.setPosition(options.position);
					this.setMap(options.map || null);
				};

				CustomOverlay.prototype = new naver.maps.OverlayView();
				CustomOverlay.prototype.constructor = CustomOverlay;

				CustomOverlay.prototype.setPosition = function(position) {
					this._position = position;
					this.draw();
				};

				CustomOverlay.prototype.getPosition = function() {
					return this._position;
				};

				CustomOverlay.prototype.onAdd = function() {
					var overlayLayer = this.getPanes().overlayLayer;

					this._element.appendTo(overlayLayer);
				};

				CustomOverlay.prototype.onClick = function(e) {
					if (e.stopPropagation) {
						e.stopPropagation();
					} else {
						e.cancelBubble = true;
					}
					naver.maps.Event.trigger(this, 'click', this);
				};

				CustomOverlay.prototype.draw = function() {
					if (!this.getMap()) {
						return;
					}

					var projection = this.getProjection(),
						position = this.getPosition(),
						pixelPosition = projection.fromCoordToOffset(position);

					this._element.css('left', pixelPosition.x);
					this._element.css('top', pixelPosition.y);
				};

				CustomOverlay.prototype.onRemove = function() {
					naver.maps.Event.removeDOMListener(this._clickListener);
					this._element.remove();
					this._element.off();
				};

				CustomOverlay.prototype._addListener = function() {
					this._clickListener = naver.maps.Event.addDOMListener(this._element[0], 'click', naver.maps.Util.bind(this.onClick, this));
				};

				// 오버레이 생성
				var overlay = new CustomOverlay({
					position: location,
					map: map
				});

				// 오버레이 삭제 
				// overlay.setMap(null);

				// 오버레이 클릭 이벤트 리스너
				naver.maps.Event.addListener(overlay, "click", function(overlay) {
					// 기존에 표시되고 있던 정보를 지우기
					$('#mapDetail').empty();
					let x = json.addresses[0].x;
					let y = json.addresses[0].y;

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

					// 클릭한 지역의 날씨 정보를 가져오기
					$.ajax({
						url: '/weather/getWeatherByCity',
						data: { "city": city, "base_date": base_date, "base_time": base_time },
						success: function(weatherData) {
							var weatherJson = JSON.parse(weatherData);
							var weatherInfo = {};
							for (var i = 0; i < weatherJson.response.body.items.item.length; i++) {
								weatherInfo[weatherJson.response.body.items.item[i].category] = weatherJson.response.body.items.item[i].fcstValue;
							}

							// 16방위를 한글로 변환
							var direction = Math.floor((Number(weatherInfo.VEC) + 22.5 * 0.5) / 22.5);
							var directionNames = ["북", "북북동", "동북동", "동", "동동남", "동남", "남동남", "남", "남남서", "서남서", "서", "서서북", "서북", "북서북", "북", "북북동", "북"];
							var directionName = directionNames[direction];

							// 하늘 상태와 강수 형태를 한글로 변환
							var skyStatus = { '1': '맑음', '3': '구름많음', '4': '흐림' }[weatherInfo.SKY];
							var ptyStatus = { '0': '없음', '1': '비', '2': '비/눈', '3': '눈', '4': '소나기', '5': '빗방울', '6': '빗방울눈날림', '7': '눈날림' }[weatherInfo.PTY];

							// 강수량이 없는 경우 '0mm'로 설정
							var rainfall = weatherInfo.RN1 || '0';
							var weather;
							if(weatherInfo.SKY == '1') {
								weather = "/static/image/맑은하늘.png";
							} else if(weatherInfo.SKY == '3') {
								weather = "/static/image/구름_많음.png";
							} else if(weatherInfo.SKY == '4') {
								weather = "/static/image/흐림.png";
							} else if(weatherInfo.PTY == '1') {
								weather = "/static/image/폭우.png";
							} else if(weatherInfo.PTY == '2') {
								weather = "/static/image/눈발.png";
							} else if(weatherInfo.PTY == '3') {
								weather = "/static/image/눈발.png";
							} else if(weatherInfo.PTY == '4') {
								weather = "/static/image/폭우.png";
							}
							// 날씨 정보를 mapDetail div에 표시하기
							$('#mapDetail').html(
								'<div class="text-center">' +
									'<h3>' + city + '</h3>' +
									'<img src="' + weather + '" width="120px;">' + weatherInfo.TMP + '℃ <p id="rain" class="text-secondary">강수량 ' + rainfall + 'mm</p>' +
									'<div class="mt-3">최저 ' + weatherInfo.TMN + '℃ / 최고 ' + weatherInfo.TMX + '℃ </div>' +
									'<div id="wind" class="d-flex justify-content-around mt-3" width="40%">' + 
										'<div>풍향 ' + directionName + '</div>' +
										'<div> 풍속 ' + weatherInfo.WSD + 'm/s</div>' +
									'</div>' +
								'</div>'
							);
						},
						error: function() {
							alert("날씨 불러오기 에러");
						}
					});
				});
			}
		},
		error: function() {
			alert("지도 불러오기 오류");
		}
	});
});