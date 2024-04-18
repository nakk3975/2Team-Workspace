package com.weather.finedust.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.time.LocalDateTime;
import java.util.concurrent.CompletableFuture;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import com.weather.finedust.dto.FineDustDto;

@RequestMapping("/finedust/*")
@Controller
public class FineDustController {

	@GetMapping("/airPollution")
	public void fineDust(Model model) {
		todayAir(model);
		dustForecast(model);
	}

	// 동적 코딩을 위한 날짜 포맷
	LocalDateTime tomorrow = LocalDateTime.now().plusDays(1);
	LocalDateTime today = LocalDateTime.now();
	LocalDateTime yesterday = LocalDateTime.now().minusDays(1);
	LocalDateTime twoDaysAgo = LocalDateTime.now().minusDays(2);
	LocalDateTime threeDaysAgo = LocalDateTime.now().minusDays(3);

	// 지역별 대기 오염물질 등급 및 수치
	public void todayAir(Model model) {
		String[] cities = { "서울", "제주", "전남", "전북", "광주", "경남", "경북", "울산", "대구", "부산", "충남", "충북", "세종", "대전", "강원",
				"경기", "인천" };

		String[][] todayAirs = new String[17][14];

		// 지역별 작업을 비동기화로 진행하기 위한 completableFuture 사용.
		CompletableFuture<Void>[] futures = new CompletableFuture[17];
		for (int i = 0; i < 17; i++) {
			int cityIndex = i;
			// future 클래스의 async 메서드를 이용한 비동기화
			futures[i] = CompletableFuture.runAsync(() -> {
				try {
					RestTemplate restTemplate = new RestTemplate();
					URI uri = new URI(UrlMaker.todayAirUrl(cities[cityIndex]));
					ResponseEntity<FineDustDto> responseEntity = restTemplate.getForEntity(uri, FineDustDto.class);
					FineDustDto dc = responseEntity.getBody();

					int index = 0;
					while (true) {
						com.weather.finedust.dto.Item item = dc.response.body.items.get(index);

						// api에서 수치와 등급이 주어지지만, 둘이 서로 일치하지 않아 수치로 등급을 다시 계산.
						String so2Grade = "";
						String coGrade = "";
						String no2Grade = "";
						String o3Grade = "";
						String pm10Grade = "";
						String pm25Grade = "";
						String khaiGrade = "";

						// value값이 비어있는 경우, 차선책을 가져오기 위해 grade를 'null'로 넘겨버림
						try {
							so2Grade = AirGradeCalculator.calculateSO2Grade(Double.parseDouble(item.so2Value));
							coGrade = AirGradeCalculator.calculateCOGrade(Double.parseDouble(item.coValue));
							no2Grade = AirGradeCalculator.calculateNO2Grade(Double.parseDouble(item.no2Value));
							o3Grade = AirGradeCalculator.calculateO3Grade(Double.parseDouble(item.o3Value));
							pm10Grade = AirGradeCalculator.calculatePM10Grade(Double.parseDouble(item.pm10Value));
							pm25Grade = AirGradeCalculator.calculatePM25Grade(Double.parseDouble(item.pm25Value));
							khaiGrade = AirGradeCalculator.calculateKHAIGrade(Double.parseDouble(item.khaiValue));
						} catch (NumberFormatException | NullPointerException e) {

						}

						String[] informs = { so2Grade, item.so2Value, coGrade, item.coValue, no2Grade, item.no2Value,
								o3Grade, item.o3Value, pm10Grade, item.pm10Value, pm25Grade, item.pm25Value, khaiGrade,
								item.khaiValue };

						// 각 도시의 중앙지역의 값을 불러오지만, 위 try에서 null로 넘어왔을 경우 차선책을 다시 가져옴.
						boolean isNull = false;
						for (String x : informs) {
							if (x == null || x.equals("-")) {
								isNull = true;
								break;
							}
						}

						if (isNull) {
							index++;
						} else {
							todayAirs[cityIndex] = informs;
							break;
						}
					}
				} catch (HttpStatusCodeException | URISyntaxException e) {
					e.printStackTrace();
				}
			});
		}

		// 비동기로 진행한 지역별 정보를 전부 불러왔을 경우 이를 모델에 추가하고, dustForecast를 실행.
		CompletableFuture<Void> allOf = CompletableFuture.allOf(futures);
		allOf.thenRun(() -> {
			model.addAttribute("todayAirs", todayAirs);
			forecastImage(model);
		}).join();
	}

	// 에어코리아에서 자체 제공하는 미세먼지, 초미세먼지 예측도(어제~내일의 오전(06시)/오후(18시)). 12번 호출이기 때문에 비동기화처리.
	private CompletableFuture<Void> forecastImage(Model model) {
		return CompletableFuture.runAsync(() -> {
			try {
				// 10:미세먼지, 25:초미세먼지.
				String yesterdayAm10Image = UrlMaker.dustPictureUrl(twoDaysAgo, threeDaysAgo, twoDaysAgo, "21", 10);
				String yesterdayPm10Image = UrlMaker.dustPictureUrl(twoDaysAgo, threeDaysAgo, yesterday, "09", 10);
				String yesterdayAm25Image = UrlMaker.dustPictureUrl(twoDaysAgo, threeDaysAgo, twoDaysAgo, "21", 25);
				String yesterdayPm25Image = UrlMaker.dustPictureUrl(twoDaysAgo, threeDaysAgo, yesterday, "09", 25);
				String todayAm10Image = UrlMaker.dustPictureUrl(yesterday, twoDaysAgo, yesterday, "21", 10);
				String todayPm10Image = UrlMaker.dustPictureUrl(yesterday, twoDaysAgo, today, "09", 10);
				String todayAm25Image = UrlMaker.dustPictureUrl(yesterday, twoDaysAgo, yesterday, "21", 25);
				String todayPm25Image = UrlMaker.dustPictureUrl(yesterday, twoDaysAgo, today, "09", 25);
				String tomorrowAm10Image = UrlMaker.dustPictureUrl(today, twoDaysAgo, today, "21", 10);
				String tomorrowPm10Image = UrlMaker.dustPictureUrl(today, twoDaysAgo, tomorrow, "09", 10);
				String tomorrowAm25Image = UrlMaker.dustPictureUrl(today, twoDaysAgo, today, "21", 25);
				String tomorrowPm25Image = UrlMaker.dustPictureUrl(today, twoDaysAgo, tomorrow, "09", 25);

				// 모델에 이미지 URL 추가
				model.addAttribute("yesterdayAm10Image", yesterdayAm10Image);
				model.addAttribute("yesterdayPm10Image", yesterdayPm10Image);
				model.addAttribute("yesterdayAm25Image", yesterdayAm25Image);
				model.addAttribute("yesterdayPm25Image", yesterdayPm25Image);
				model.addAttribute("todayAm10Image", todayAm10Image);
				model.addAttribute("todayPm10Image", todayPm10Image);
				model.addAttribute("todayAm25Image", todayAm25Image);
				model.addAttribute("todayPm25Image", todayPm25Image);
				model.addAttribute("tomorrowAm10Image", tomorrowAm10Image);
				model.addAttribute("tomorrowPm10Image", tomorrowPm10Image);
				model.addAttribute("tomorrowAm25Image", tomorrowAm25Image);
				model.addAttribute("tomorrowPm25Image", tomorrowPm25Image);
				
			} catch (HttpStatusCodeException e) {
				e.printStackTrace();
			}
		});
	}

	// 어제~내일의 미세먼지, 초미세먼지 정보 api. 위와 달리 1회만 호출하기 때문에 future 클래스 미사용.
	private void dustForecast(Model model) {
		RestTemplate restTemplate = new RestTemplate();
		try {
			URI uri = new URI(UrlMaker.dustForecastUrl(yesterday));
			FineDustDto dp = restTemplate.getForObject(uri, FineDustDto.class);

			com.weather.finedust.dto.Item yesterday10 = dp.response.body.items.get(0);
			com.weather.finedust.dto.Item today10 = dp.response.body.items.get(1);
			com.weather.finedust.dto.Item tomorrow10 = dp.response.body.items.get(2);
			com.weather.finedust.dto.Item yesterday25 = dp.response.body.items.get(3);
			com.weather.finedust.dto.Item today25 = dp.response.body.items.get(4);
			com.weather.finedust.dto.Item tomorrow25 = dp.response.body.items.get(5);

			String[][] dustGrades = new String[6][];
			dustGrades[0] = yesterday10.informGrade.split("\\s*(,|\\:)\\s*");
			dustGrades[1] = today10.informGrade.split("\\s*(,|\\:)\\s*");
			dustGrades[2] = tomorrow10.informGrade.split("\\s*(,|\\:)\\s*");
			dustGrades[3] = yesterday25.informGrade.split("\\s*(,|\\:)\\s*");
			dustGrades[4] = today25.informGrade.split("\\s*(,|\\:)\\s*");
			dustGrades[5] = tomorrow25.informGrade.split("\\s*(,|\\:)\\s*");
			model.addAttribute("dustGrades", dustGrades);
		} catch (HttpStatusCodeException | URISyntaxException e) {
			e.printStackTrace();
		}
	}

}