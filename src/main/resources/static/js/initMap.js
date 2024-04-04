function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 2,
        center: {lat: 0, lng: 0} // 지도의 초기 중심 위치
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
                    position: {lat: country.latitude, lng: country.longitude},
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

 	function loadRegionMarkers(countryCode, map) {
 		$.ajax({
		    type: "get",
		    url: "/weather/region",
		    data:{"countryCode":countryCode},
		    success: function(regions) {
				 regions.forEach(function(region) {
                    var marker = new google.maps.Marker({
                        position: {lat: region.latitude, lng: region.longitude},
                        map: map,
                        title: region.name,
                        visible: false // 초기에는 지역 마커를 숨깁니다.
                    });
                    regionMarkers.push(marker);

                    // 지역 마커에 클릭 이벤트 리스너를 추가합니다.
                    marker.addListener('click', function() {
                        // 날씨 정보를 불러오는 로직을 추가합니다.
                    });
                });
            },
            error: function() {
                alert("도시 정보 불러오기 오류");
            }
        });
    }
}
	// Google Maps 스크립트 로드 후 initMap 함수 호출
	window.initMap = initMap;


