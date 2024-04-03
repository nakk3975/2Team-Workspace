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
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.weather.world.dto.CountryDTO;
import com.weather.world.dto.RegionDTO;
import com.weather.world.mapper.WorldMapper;


@Service
public class WorldService {
	
	@Autowired
	private WorldMapper worldMapper;

	private final String API_KEY = "95bf8829bcmsh8e831b1b3c56cc2p1ab63ejsnfaaa248c6b8b";
	
	public List<CountryDTO> getCountryCodes(){
        return worldMapper.getCountry();
    }
	
	@Autowired
	private RestTemplate restTemplate;

	public List<RegionDTO> getRegionsByCountryCode(String countryCode) throws JsonMappingException, JsonProcessingException {
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("X-RapidAPI-Key", API_KEY);
	    HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
	    
	    ResponseEntity<String> response = restTemplate.exchange(
	        "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/" + countryCode + "/regions", 
	        HttpMethod.GET, 
	        entity, 
	        String.class);
	    
	    // JSON 문자열을 DTO 객체 리스트로 변환합니다.
	    ObjectMapper mapper = new ObjectMapper();
	    JsonNode root = mapper.readTree(response.getBody());
	    List<RegionDTO> regions = mapper.convertValue(root.get("data"), new TypeReference<List<RegionDTO>>() {});
	    
	    return regions;
	}

}
