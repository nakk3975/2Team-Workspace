package com.weather.satellite.controller;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.weather.satellite.dto.SatelliteDto;

@RequestMapping("/satellite/*")
@Controller
public class satelliteController {
	@GetMapping("/getSatelliteImages")
	public String getSatelliteImages(Model model,
			@RequestParam(value = "date", required = false)String receivedDate,
			@RequestParam(value = "mediaType", required = false)String mediaType) {
		
		// 인코딩 인증키
		String API_KEY = "SW%2B5pKGzSgxkkJeryeK9fDYT4XzTiNTgsgOqTRrx3xuxsO4kT7vcDilIqs7VmmkTGVsXAv919McNuZIbnc3uGw%3D%3D";
		
		// API URL 구성
	    String API_URL = "http://apis.data.go.kr/1360000/SatlitImgInfoService/getInsightSatlit?serviceKey="
	            + API_KEY + "&numOfRows=10&pageNo=1&sat=g2&data=" + mediaType + "&area=ea&time=" + receivedDate +"&dataType=JSON";
		
		RestTemplate restTemplate = new RestTemplate();

		//// **** 중요 **** uri
		URI uri = null; // java.net.URI 임포트 하셈
		try {
			uri = new URI(API_URL); // URI 클래스는 URL에 대한 유효성 검사, 구성요소 추출, 보안(특수문자, 공백 처리 등)을 도와줌
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		
		String s = restTemplate.getForObject(uri, String.class);
		
		// 오브젝트 맵퍼 json 정렬화 후 반환문
		ObjectMapper objectMapper = new ObjectMapper();
		      SatelliteDto response = new SatelliteDto();
		      try {
		         response = objectMapper.readValue(s,SatelliteDto.class);
		      } catch (Exception e) {
		         e.printStackTrace();
		      }
		      
		System.out.println(response);
		model.addAttribute("satellite", response);
	
		return "satellite/getSatelliteImages";
	}
}
