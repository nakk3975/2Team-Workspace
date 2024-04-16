package com.weather.finedust.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDateTime;

import org.springframework.web.client.HttpStatusCodeException;

public class UrlMaker {

	// 공공 api 인코딩키.
	private static final String apiKey = "bwOV00fAbCauXCeo0zQpP3ukRJpHBg0GM63FmQOWweU2bcC3zOtGwLxwnTc4aSCo0HRqV1QwgOS20wID8dvIOQ%3D%3D";
	
	// 금일 대기 정보 url
	public static String todayAirUrl(String city) {
		String encodingCity;
		StringBuilder todayAirUrl = new StringBuilder();
		try {
			encodingCity = URLEncoder.encode(city, "UTF-8");
			todayAirUrl.append("http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?sidoName=")
					.append(encodingCity).append("&pageNo=1&numOfRows=100&returnType=JSON&serviceKey=").append(apiKey)
					.append("&ver=1.0");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return todayAirUrl.toString();
	}
	
	//미세먼지&초미세먼지 어제, 오늘, 내일 예보 url
	public static String dustForecastUrl(LocalDateTime date) {
		StringBuilder dustForecastUrl = new StringBuilder();
		dustForecastUrl.append("https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMinuDustFrcstDspth?searchDate=")
				.append(TimeFormat.dateWithBar(date)).append("&returnType=JSON&serviceKey=").append(apiKey).append("&numOfRows=100&pageNo=1");
			
		return dustForecastUrl.toString();
	}

	// 미세먼지&초미세먼지 예측도 url
	public static String dustPictureUrl(LocalDateTime date1, LocalDateTime date2, LocalDateTime date3, String time,
			int size) {
		StringBuilder makingUrl = new StringBuilder();
		makingUrl.append("https://www.airkorea.or.kr/file/proxyImage?fileName=").append(TimeFormat.dateWithSlash(date1))
				.append("/AQF.").append(TimeFormat.dateNormal(date2));

		if (size == 10) {
			makingUrl.append(".NIER_09_01.PM10.1hsp.");
		} else {
			makingUrl.append(".NIER_09_01.PM2P5.1hsp.");
		}

		makingUrl.append(TimeFormat.dateNormal(date3)).append(time+".png");

		return makingUrl.toString();
	}

}
