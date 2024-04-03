function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 2,
        center: {lat: 0, lng: 0} // 지도의 초기 중심 위치
    });
    
    $.ajax({
    	type:"get",
    	url:"/weather/countries",
    	success:function(data) {
    		for (var i = 0; i < data.length; i++) {
    			var country = data[i];
                var marker = new google.maps.Marker({
                    position: {lat: country.latitude, lng: country.longitude},
                    map: map,
                    title: country.name
                });

                // 마커에 클릭 이벤트 리스너를 추가합니다.
                // 클로저를 사용하여 각 마커에 대한 참조를 유지합니다.
                google.maps.event.addListener(marker, 'click', (function(marker, country) {
    return function() {
        map.setZoom(8);
        map.setCenter(marker.getPosition());

        $.ajax({
            type: "get",
            url: "/weather/countries/" + country.countryCode + "/regions",
            success: function(data) {
                // data는 각 나라의 도시 정보입니다.
                for (var i = 0; i < data.length; i++) {
                    var region = data[i];
                    var regionMarker = new google.maps.Marker({
                        position: {lat: region.latitude, lng: region.longitude},
                        map: map,
                        title: region.name
                    });

                    google.maps.event.addListener(regionMarker, 'click', (function(regionMarker, region) {
                        return function() {
                            // 클릭한 도시의 날씨 정보를 불러옵니다.
                            $.ajax({
                                type: "get",
                                url: "/weather/region/" + region.regionCode,
                                success: function(weatherData) {
                                    // weatherData는 도시의 날씨 정보입니다.
                                    alert(region.name + "의 날씨는 " + weatherData.weather + "입니다.");
                                },
                                error: function() {
                                    alert("날씨 정보 불러오기 오류");
                                }
                            });
                        };
                    })(regionMarker, region));
                }
            },
            error: function() {
                alert("도시 정보 불러오기 오류");
            }
        });
    };
})(marker, country));
            }
    	},
    	error:function() {
    		alert("나라 정보 불러오기 오류");
    	}
    	
    });

	// Google Maps 스크립트 로드 후 initMap 함수 호출
	window.initMap = initMap;
}

