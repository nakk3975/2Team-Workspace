package com.weather.satellite.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.weather.satellite.dto.SatelliteDto;

@RequestMapping("/satellite/*")
@Controller
public class satelliteController {
	@GetMapping("/getSatelliteImages")
	public String getSatelliteImages(Model model,
			@RequestParam(value = "date", required = false)String receivedDate,
			@RequestParam(value = "time", required = false)String receivedTime,
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
		System.out.println("받아온 JSON : " + s);

//		int movieSize = movie.boxOfficeResult.dailyBoxOfficeList.size();
//		model.addAttribute("movieSize", movieSize);
//		String searchDate = movie.boxOfficeResult.showRange;
//		model.addAttribute("searchDate", searchDate);
//		List<String> movieName = new ArrayList<>();
//		List<String> movieNum = new ArrayList<>();
//		List<String> movieRank = new ArrayList<>();
//		List<String> movieSales = new ArrayList<>();
//		List<String> movieOpen = new ArrayList<>();
//		for(int i = 0; i < movieSize; i++) {
//			movieName.add(movie.boxOfficeResult.dailyBoxOfficeList.get(i).movieNm);
//		    movieNum .add(movie.boxOfficeResult.dailyBoxOfficeList.get(i).rnum);
//		    movieRank.add(movie.boxOfficeResult.dailyBoxOfficeList.get(i).rank);
//		    movieSales.add(movie.boxOfficeResult.dailyBoxOfficeList.get(i).salesAcc);
//		    movieOpen.add(movie.boxOfficeResult.dailyBoxOfficeList.get(i).openDt);
//		}
//		    // 영화 정보를 Model에 추가
//		    model.addAttribute("movieName", movieName);
//		    model.addAttribute("movieNum", movieNum);
//		    model.addAttribute("movieRank", movieRank);
//		    model.addAttribute("movieSales", movieSales);
//		    model.addAttribute("movieOpen", movieOpen);
//
//		    String ddara = String.format("\n조회한 날짜 : %s\n"
//		            + "영화 번호 : %s\n" + "영화 이름 : %s\n" + "영화 순위 : %s\n" + "영화 누적 매출액 : %s\n"
//		            , searchDate, movieNum, movieName, movieRank, movieSales);
//		    log.info("콘솔 확인용\n" + ddara);
	
		return "satellite/getSatelliteImages";
	}
}
