package com.weather.finedust.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDateTime;

import org.springframework.web.client.HttpStatusCodeException;

public class UrlMaker {

	// 공공 api 인코딩키.
	private static final String apiKey1 = "Uwp4QYhvVPmz5JKq4n1b%2F7UQItAGr1WvcxKJGjE0bOsFCoj0THM9sjT%2FDCmlYh8UFQ6pyLBaDJYmO%2Bv7wKcP5w%3D%3D";
	private static final String apiKey2 = "Ss9lLqI9PsPCi4rzCRwYeaj4oMctehbAVqZVTEPQSYO2xKFWVHPuxlgNrehIPeg5BXcyxo2MlrJgMh%2FTYY600A%3D%3D";
	private static final String apiKey3 = "UGMG0OSIeWxQ1X%2BjWae1nntSGDOQMDQLxoTJH9ppsIj2NxAhdsHEmkfVfcBlTjjqaDMYbepO59LHJ%2FjIGbxS1A%3D%3D";
	private static final String apiKey4 = "dBf%2Bdeb3mNnd5GdxjqMCdUQfKRD6wQYs45nMGoKEQipCifl8%2Bv2ubkbrXCGw8IHKPnvtYlxNfqLfAV0bgaKyVw%3D%3D";
	private static final String apiKey5 = "bwOV00fAbCauXCeo0zQpP3ukRJpHBg0GM63FmQOWweU2bcC3zOtGwLxwnTc4aSCo0HRqV1QwgOS20wID8dvIOQ%3D%3D";
	
	// 금일 대기 정보 url
	public static String todayAirUrl(String city) {
		String encodingCity;
		StringBuilder todayAirUrl = new StringBuilder();
		try {
			
			//apiKey별 하루 이용량이 500회로 적어서 분할하여 할당.
			String apiKey="";
			if(city.equals("서울")|| city.equals("제주") || city.equals("전남")|| city.equals("전북")) {
				apiKey=apiKey1;
			}else if(city.equals("광주")|| city.equals("경남") || city.equals("경북")|| city.equals("울산")) {
				apiKey=apiKey2;
			}else if(city.equals("대구")|| city.equals("부산") || city.equals("충남")|| city.equals("충북")) {
				apiKey=apiKey3;
			}else {
				apiKey=apiKey4;
			}
			
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
				.append(TimeFormat.dateWithBar(date)).append("&returnType=JSON&serviceKey=").append(apiKey5).append("&numOfRows=100&pageNo=1");
			
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
