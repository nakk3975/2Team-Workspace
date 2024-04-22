package com.weather.world.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.weather.world.dto.CountryDTO;
import com.weather.world.dto.WeatherForecastDTO;
import com.weather.world.service.WorldService;

@RestController
@RequestMapping("/weather")
public class WorldRestController {

	@Autowired
	private WorldService worldService;
	
	@GetMapping("/countries")
    public List<CountryDTO> getCountries() {
        // 국가 정보를 가져옵니다.
        return worldService.getCountryCodes();
    }
	
	@GetMapping("/region")
	public String getRegions(@RequestParam("countryCode") String countryCode) throws JsonMappingException, JsonProcessingException {
	    // 국가 코드를 파라미터로 받아 그 나라의 도시 정보 가져오기
		return worldService.getRegionsByCountryCode(countryCode);
	}

	@GetMapping("/forecast")
    public WeatherForecastDTO getForecast(@RequestParam("lat") double lat, @RequestParam("lon") double lon) throws JsonProcessingException {
		return worldService.getWeatherForecastByCoordinates(lat, lon);
    }
}
