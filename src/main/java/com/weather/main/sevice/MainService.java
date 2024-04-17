package com.weather.main.sevice;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
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
	
    public String searchAddressToCoordinate(String address) throws UnsupportedEncodingException, URISyntaxException {
    	String encodedAddress = URLEncoder.encode(address, StandardCharsets.UTF_8.toString());
    	String NAVER_API_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=" + encodedAddress;
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-NCP-APIGW-API-KEY-ID", NAVER_API_KEY_ID);
		headers.set("X-NCP-APIGW-API-KEY", NAVER_API_KEY);
		
		URI uri = new URI(NAVER_API_URL);
        HttpEntity<String> entity = new HttpEntity<>("parameters", headers);

		ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity,
				String.class);
		
        return response.getBody();
    }
    
    //현재 실황
    public String getNowWeather(int nx, int ny, String base_date, String base_time) throws URISyntaxException {

        // RestTemplate과 HttpHeaders를 생성합니다.
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();

        // HttpEntity를 생성합니다.
        HttpEntity<String> entity = new HttpEntity<>("parameters", headers);

        // URL 파라미터를 설정합니다.
        String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=" + WEATHER_API_KEY + "&dataType=JSON&numOfRows=1000&pageNo=1&base_date=" + base_date + "&base_time=" + base_time + "&nx=" + nx + "&ny=" + ny;
        URI uri = new URI(url);

        // API를 호출하고 결과를 받습니다.
        ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
        
        // 결과를 반환합니다.
        return response.getBody();
    }
    
    // 단기
	public String getWeather(int nx, int ny, String base_date, String base_time) throws URISyntaxException {

        // RestTemplate과 HttpHeaders를 생성합니다.
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();

        // HttpEntity를 생성합니다.
        HttpEntity<String> entity = new HttpEntity<>("parameters", headers);

        // URL 파라미터를 설정합니다.
        String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=" + WEATHER_API_KEY + "&dataType=JSON&numOfRows=1000&pageNo=1&base_date=" + base_date + "&base_time=" + base_time + "&nx=" + nx + "&ny=" + ny;
        URI uri = new URI(url);
        // API를 호출하고 결과를 받습니다.
        ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
        
        // 결과를 반환합니다.
        return response.getBody();
    }
	
	// 지역 코드 매핑
    @SuppressWarnings("serial")
	private final Map<String, String> areaCodeMap = new HashMap<String, String>() {{
        put("서울특별시", "11B00000");
        put("부산광역시", "11H20000");
        put("대구광역시", "11H10000");
        put("인천광역시", "11B00000");
        put("광주광역시", "11F20000");
        put("대전광역시", "11C20000");
        put("울산광역시", "11H20000");
        put("세종특별자치시", "11C20000");
        put("경기도", "11B00000");
        put("강원도", "11D10000");
        put("충청도", "11C20000");
        put("전라도", "11F20000");
        put("경상도", "11H20000");
        put("제주특별자치도", "11G00000");
    }};
    
    // 지역 코드 매핑
    @SuppressWarnings("serial")
	private final Map<String, String> areaCodeMap2 = new HashMap<String, String>() {{
        put("서울특별시", "11B10101");
        put("부산광역시", "11H20201");
        put("대구광역시", "11H10701");
        put("인천광역시", "11B20201");
        put("광주광역시", "11F20501");
        put("대전광역시", "11C20401");
        put("울산광역시", "11H20101");
        put("세종특별자치시", "11C20404");
        put("경기도", "11B20601");
        put("강원도", "11D20501");
        put("충청도", "11C10301");
        put("전라도", "11F10201");
        put("경상도", "11H10501");
        put("제주특별자치도", "11G00201");
    }};
	
	// 중기
	public String getMidTaWeather(String city, String base_date) throws URISyntaxException {

        // RestTemplate과 HttpHeaders를 생성합니다.
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();

        // HttpEntity를 생성합니다.
        HttpEntity<String> entity = new HttpEntity<>("parameters", headers);
        String areaCode = areaCodeMap2.get(city);
        // URL 파라미터를 설정합니다.
        String url = "http://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa?serviceKey=" + WEATHER_API_KEY + "&pageNo=1&numOfRows=10&dataType=JSON&regId=" + areaCode + "&tmFc=" + base_date + "0600";
        URI uri = new URI(url);
        // API를 호출하고 결과를 받습니다.
        ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
        // 결과를 반환합니다.
        return response.getBody();
    }
	
	// 중기 2
	public String getMidWeather(String city, String base_date) throws URISyntaxException {

        // RestTemplate과 HttpHeaders를 생성합니다.
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();

        // HttpEntity를 생성합니다.
        HttpEntity<String> entity = new HttpEntity<>("parameters", headers);
        String areaCode = areaCodeMap.get(city);
        // URL 파라미터를 설정합니다.
        String url = "http://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst?serviceKey=" + WEATHER_API_KEY + "&pageNo=1&numOfRows=10&dataType=JSON&regId=" + areaCode + "&tmFc=" + base_date + "0600";
        URI uri = new URI(url);
        // API를 호출하고 결과를 받습니다.
        ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
        
        // 결과를 반환합니다.
        return response.getBody();
    }	

	// 네이버 지도 도시별 날씨
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

	// 지역 검색
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
