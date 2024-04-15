package com.weather.main.sevice;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class MainService {
	private static final String NAVER_API_KEY_ID = "vzqhpvb94n";
	private static final String NAVER_API_KEY = "Zs4cJbU5Iw5m7D5791rqP1A4R54WiSi0B1wcXCd1";

	private static final String WEATHER_API_KEY = "Uw6gaLxXT6Kse3SbXODEh3jf7z4UQQ5UWXm0qQflrhIHEXFvNGRRi%2BWrU1BQu8rhdkUYKwr7vvQnAfhhhSxkjw%3D%3D";
	

    public String searchAddressToCoordinate(String address) {
    	String NAVER_API_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=" + address;
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-NCP-APIGW-API-KEY-ID", NAVER_API_KEY_ID);
		headers.set("X-NCP-APIGW-API-KEY", NAVER_API_KEY);
		
        HttpEntity<String> entity = new HttpEntity<>("parameters", headers);

		ResponseEntity<String> response = restTemplate.exchange(NAVER_API_URL + city, HttpMethod.GET, entity,
				String.class);

        return response.getBody();
    }
	
	public String getWeatherByCity(String city, String base_date, String base_time)
			throws UnsupportedEncodingException, URISyntaxException {
		// 각 도시의 격자 값 매핑
		@SuppressWarnings("serial")
		Map<String, int[]> CITY_GRID_MAP = new HashMap<String, int[]>() {
			{
				put("서울", new int[] { 60, 127 });
				put("춘천", new int[] { 73, 134 });
				put("강릉", new int[] { 92, 131 });
				put("대전", new int[] { 67, 100 });
				put("안동", new int[] { 91, 106 });
				put("전주", new int[] { 36, 89 });
				put("대구", new int[] { 89, 90 });
				put("포항", new int[] { 87, 106 });
				put("광주", new int[] { 58, 74 });
				put("여수", new int[] { 73, 66 });
				put("부산", new int[] { 98, 76 });
				put("제주", new int[] { 52, 38 });
			}
		};

		int[] grid = CITY_GRID_MAP.get(city);
		if (grid == null) {
			throw new IllegalArgumentException("Invalid city: " + city);
		}

		String WEATHER_API_URL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
		String baseDate = base_date;
		String baseTime = base_time;
		String pageNo = "1";
		String numOfRows = "1000";
		String dataType = "json";

		WEATHER_API_URL += "?serviceKey=" + WEATHER_API_KEY;
		WEATHER_API_URL += "&pageNo=" + pageNo;
		WEATHER_API_URL += "&numOfRows=" + numOfRows;
		WEATHER_API_URL += "&dataType=" + dataType;
		WEATHER_API_URL += "&base_date=" + baseDate;
		WEATHER_API_URL += "&base_time=" + baseTime;
		WEATHER_API_URL += "&nx=" + URLEncoder.encode(String.valueOf(grid[0]), "UTF-8");
		WEATHER_API_URL += "&ny=" + URLEncoder.encode(String.valueOf(grid[1]), "UTF-8");

		URI uri = new URI(WEATHER_API_URL);
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<String> entity = new HttpEntity<>("parameters", headers);
		ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);

		return response.getBody();
	}

	public String getCityLocation(String city) {
		String NAVER_API_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=";
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.set("X-NCP-APIGW-API-KEY-ID", NAVER_API_KEY_ID);
		headers.set("X-NCP-APIGW-API-KEY", NAVER_API_KEY);
		HttpEntity<String> entity = new HttpEntity<>("parameters", headers);

		ResponseEntity<String> response = restTemplate.exchange(NAVER_API_URL + city, HttpMethod.GET, entity,
				String.class);
		
		return response.getBody();
	}
}
