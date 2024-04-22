package com.weather.world.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.weather.world.dto.CountryDTO;
import com.weather.world.dto.WeatherForecastDTO;
import com.weather.world.mapper.WorldMapper;

@Service
public class WorldService {

	@Autowired
	private WorldMapper worldMapper;

	private final String API_KEY = "43kXAvhnuhZmMXOT/U03zA==sQauZ0ETFnkkiqmS";
	private final String weatherKey = "fbe37a5d88c661f82bf1ad80f1081226";

	// 나라 정보
	public List<CountryDTO> getCountryCodes() {
		return worldMapper.getCountry();
	}

	// 도시 정보
	public String getRegionsByCountryCode(String countryCode)
			throws JsonMappingException, JsonProcessingException {
		HttpHeaders headers = new HttpHeaders();
		headers.set("X-Api-Key", API_KEY);
		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);

		RestTemplate restTemplate = new RestTemplate();

		ResponseEntity<String> response = restTemplate.exchange(
				"https://api.api-ninjas.com/v1/city?country=" + countryCode + "&limit=20", HttpMethod.GET, entity,
				String.class);

		return response.getBody();
	}

	// 날씨 정보
	public WeatherForecastDTO getWeatherForecastByCoordinates(double latitude, double longitude)
			throws JsonProcessingException {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);

		RestTemplate restTemplate = new RestTemplate();

		String url = String.format("https://api.openweathermap.org/data/2.5/forecast?lat=%f&lon=%f&appid=%s", latitude,
				longitude, weatherKey);

		ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

		ObjectMapper mapper = new ObjectMapper();
		JsonNode root = mapper.readTree(response.getBody());
		return mapper.convertValue(root, WeatherForecastDTO.class);
	}
}
