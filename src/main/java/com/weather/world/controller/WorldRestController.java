package com.weather.world.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.weather.world.dto.CountryDTO;
import com.weather.world.dto.RegionDTO;
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
	public List<RegionDTO> getRegions(@RequestParam("countryCode") String countryCode) throws JsonMappingException, JsonProcessingException {
	    return worldService.getRegionsByCountryCode(countryCode);
	}

}
