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
					let hours = now.getHours();
					let base_time = (hours < 10 ? '0' : '') + hours + '00';  // 정각시를 'HH00' 형식으로

					// 클릭한 지역의 날씨 정보를 가져오기
					$.ajax({
						url: '/weather/getWeatherByCity',
						data: { "city": city, "base_date": base_date, "base_time": base_time },
						success: function(weatherData) {
							var weatherJson = JSON.parse(weatherData);
							var weatherInfo = {};
							for (var i = 0; i < weatherJson.response.body.items.item.length; i++) {
								weatherInfo[weatherJson.response.body.items.item[i].category] = weatherJson.response.body.items.item[i].obsrValue;
							}

							// 16방위를 한글로 변환
							var direction = Math.floor((Number(weatherInfo.VEC) + 22.5 * 0.5) / 22.5);
							var directionNames = ["북", "북북동", "동북동", "동", "동남동", "남남동", "남", "남남서", "서남서", "서", "서북서", "북북서", "북"];
							var directionName = directionNames[direction];
							// 날씨 정보를 mapDetail div에 표시하기
							$('#mapDetail').html(
								'<p>현재 기온: ' + weatherInfo.T1H + '℃</p>' +
								'<p>강수량: ' + weatherInfo.RN1 + 'mm</p>' +
								'<p>습도: ' + weatherInfo.REH + '%</p>' +
								'<p>풍속: ' + weatherInfo.WSD + 'm/s</p>' +
								'<p>풍향: ' + directionName + '°</p>'
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


