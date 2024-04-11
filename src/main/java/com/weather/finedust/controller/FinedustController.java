package com.weather.finedust.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.time.LocalDateTime;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.weather.finedust.dto.FineDustDto;

import lombok.AllArgsConstructor;

@RequestMapping("/finedust/*")
@AllArgsConstructor
@Controller
public class FinedustController {

	// 각종 오염물질 등급을 숫자에서 단어로 변경.
	private String grade(String x) {
		if (x == null) {
			return null;
		} else if (x.equals("1")) {
			return "좋음";
		} else if (x.equals("2")) {
			return "보통";
		} else if (x.equals("3")) {
			return "나쁨";
		} else {
			return "매우나쁨";
		}
	}

	@GetMapping("/airPollution")
	public void fineDust(Model model) {
		RestTemplate restTemplate = new RestTemplate();
		try {

			// 동적 코딩을 위한 날짜 포맷
			LocalDateTime tomorrow = LocalDateTime.now().plusDays(1);
			LocalDateTime today = LocalDateTime.now();
			LocalDateTime yesterday = LocalDateTime.now().minusDays(1);
			LocalDateTime twoDaysAgo = LocalDateTime.now().minusDays(2);

			// [1] 금일 정보 api 부분. 이차원 배열 형태로 보냄.
			// 0:서울, 1:제주, 2:전남, 3:전북, 4:광주, 5:경남, 6:경북, 7:울산, 8:대구, 9:부산, 10:충남, 11:충북,
			// 12:세종, 13:대전, 14:강원, 15:경기, 16:인천
			String[] cities = { "서울", "제주", "전남", "전북", "광주", "경남", "경북", "울산", "대구", "부산", "충남", "충북", "세종", "대전",
					"강원", "경기", "인천" };

			String[][] todayAirs = new String[17][14];

			for (int i = 0; i < 17; i++) {
				URI uri = new URI(UrlMaker.todayAirUrl(cities[i]));
				FineDustDto dc = restTemplate.getForObject(uri, FineDustDto.class);

				// 그 도시별 중앙에 가까운 곳의 정보를 가져오나, 만약 불가능 할 경우 차선책을 가져옴.
				int index = 0;

				while (true) {
					com.weather.finedust.dto.Item item = dc.response.body.items.get(index);

					// 이차원 배열에 넣을 준비.
					// 0,1 : 아황산가스 등급 및 농도, 2,3 : 일산화탄소 등급 및 농도, 4,5 : 이산화질소 등급 및 농도
					// 6,7 : 오존 등급 및 농도, 8,9 : 미세먼지 등급 및 농도, 10,11 : 초미세먼지 등급 및 농도
					// 12,13 : 통합환경 환경지수 및 수치
					String[] informs = { grade(item.so2Grade), item.so2Value, grade(item.coGrade), item.coValue,
							grade(item.no2Grade), item.no2Value, grade(item.o3Grade), item.o3Value,
							grade(item.pm10Grade), item.pm10Value, grade(item.pm25Grade), item.pm25Value,
							grade(item.khaiGrade), item.khaiValue };

					boolean isNull = false;
					for (String x : informs) {
						if (x == null) {
							isNull = true;
							break;
						}
					}

					if (isNull) {
						index++;
					} else {
						todayAirs[i] = informs;
						break;
					}
				}
			}
			// 금일 데이터를 모델에 추가
			model.addAttribute("todayAirs", todayAirs);

			
			// [2] 지역별 어제~내일 미세먼지, 초미세먼지 예보.
			URI uri = new URI(UrlMaker.dustForecastUrl(yesterday));
			FineDustDto dp = restTemplate.getForObject(uri, FineDustDto.class);

			// api 내 순서대로 오늘 미세먼지, 내일 미세먼지, 모래 미세먼지, 오늘 초미세먼지, 내일 초미세먼지, 모래 초미세먼지 정보가 주어짐.
			com.weather.finedust.dto.Item yesterday10 = dp.response.body.items.get(0);
			com.weather.finedust.dto.Item today10 = dp.response.body.items.get(1);
			com.weather.finedust.dto.Item tomorrow10 = dp.response.body.items.get(2);
			com.weather.finedust.dto.Item yesterday25 = dp.response.body.items.get(3);
			com.weather.finedust.dto.Item today25 = dp.response.body.items.get(4);
			com.weather.finedust.dto.Item tomorrow25 = dp.response.body.items.get(5);

			// index 0부터 지역,등급 번갈아나옴. : 서울, 제주, 전남, 전북, 광주, 경남, 경북, 울산, 대구, 부산, 충남, 충북, 세종,
			// 대전, 영동, 영서, 경기남부, 경기북부, 인천 순. (예 : index1 : 서울의 등급) 파싱하여 배열로 넘김.
			String[][] dustGrades = new String[6][];
			dustGrades[0] = yesterday10.informGrade.split("\\s*(,|\\:)\\s*");
			dustGrades[1] = today10.informGrade.split("\\s*(,|\\:)\\s*");
			dustGrades[2] = tomorrow10.informGrade.split("\\s*(,|\\:)\\s*");
			dustGrades[3] = yesterday25.informGrade.split("\\s*(,|\\:)\\s*");
			dustGrades[4] = today25.informGrade.split("\\s*(,|\\:)\\s*");
			dustGrades[5] = tomorrow25.informGrade.split("\\s*(,|\\:)\\s*");
			model.addAttribute("dustGrades", dustGrades);
			
			

			// [3] 사진 api 부분. > 17시 기준으로 데이터를 제공해줌. > 어제, 오늘, 내일 데이터를 받아오게 변경함.
			// 10:미세먼지, 25:초미세먼지.
			String yesterdayAm10Image = UrlMaker.dustPictureUrl(twoDaysAgo, twoDaysAgo, twoDaysAgo, "am", 10);
			String yesterdayPm10Image = UrlMaker.dustPictureUrl(twoDaysAgo, twoDaysAgo, yesterday, "pm", 10);
			String yesterdayAm25Image = UrlMaker.dustPictureUrl(twoDaysAgo, twoDaysAgo, twoDaysAgo, "am", 25);
			String yesterdayPm25Image = UrlMaker.dustPictureUrl(twoDaysAgo, twoDaysAgo, yesterday, "pm", 25);
			String todayAm10Image = UrlMaker.dustPictureUrl(yesterday, yesterday, yesterday, "am", 10);
			String todayPm10Image = UrlMaker.dustPictureUrl(yesterday, yesterday, today, "pm", 10);
			String todayAm25Image = UrlMaker.dustPictureUrl(yesterday, yesterday, yesterday, "am", 25);
			String todayPm25Image = UrlMaker.dustPictureUrl(yesterday, yesterday, today, "pm", 25);
			String tomorrowAm10Image = UrlMaker.dustPictureUrl(yesterday, yesterday, today, "am", 10);
			String tomorrowPm10Image = UrlMaker.dustPictureUrl(yesterday, yesterday, tomorrow, "pm", 10);
			String tomorrowAm25Image = UrlMaker.dustPictureUrl(yesterday, yesterday, today, "am", 25);
			String tomorrowPm25Image = UrlMaker.dustPictureUrl(yesterday, yesterday, tomorrow, "pm", 25);

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

		} catch (URISyntaxException e) {

		}
	}
}
