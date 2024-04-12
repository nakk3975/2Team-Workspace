package com.weather.finedust.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDateTime;

public class UrlMaker {

	// 공공 api 인코딩키. (500 에러뜨면 변경해서 사용. 트래픽 제한 500회.)
//	private static final String apiKey = "Uwp4QYhvVPmz5JKq4n1b%2F7UQItAGr1WvcxKJGjE0bOsFCoj0THM9sjT%2FDCmlYh8UFQ6pyLBaDJYmO%2Bv7wKcP5w%3D%3D";
//	private static final String apiKey = "Ss9lLqI9PsPCi4rzCRwYeaj4oMctehbAVqZVTEPQSYO2xKFWVHPuxlgNrehIPeg5BXcyxo2MlrJgMh%2FTYY600A%3D%3D";
//	private static final String apiKey = "bwOV00fAbCauXCeo0zQpP3ukRJpHBg0GM63FmQOWweU2bcC3zOtGwLxwnTc4aSCo0HRqV1QwgOS20wID8dvIOQ%3D%3D";
//	private static final String apiKey = "dBf%2Bdeb3mNnd5GdxjqMCdUQfKRD6wQYs45nMGoKEQipCifl8%2Bv2ubkbrXCGw8IHKPnvtYlxNfqLfAV0bgaKyVw%3D%3D";
	private static final String apiKey = "UGMG0OSIeWxQ1X%2BjWae1nntSGDOQMDQLxoTJH9ppsIj2NxAhdsHEmkfVfcBlTjjqaDMYbepO59LHJ%2FjIGbxS1A%3D%3D";
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

	// 미세먼지&초미세먼지 예측 사진 url
	public static String dustPictureUrl(LocalDateTime date1, LocalDateTime date2, LocalDateTime date3, String amOrPm,
			int size) {
		StringBuilder makingUrl = new StringBuilder();
		makingUrl.append("https://www.airkorea.or.kr/file/proxyImage?fileName=").append(TimeFormat.dateWithSlash(date1))
				.append("/AQF.").append(TimeFormat.dateNormal(date2));

		if (size == 10) {
			makingUrl.append(".NIER_09_01.PM10.1hsp.");
		} else {
			makingUrl.append(".NIER_09_01.PM2P5.1hsp.");
		}

		makingUrl.append(TimeFormat.dateNormal(date3));

		if (amOrPm.equals("am")) {
			makingUrl.append("21.png");
		} else {
			makingUrl.append("09.png");
		}
		return makingUrl.toString();
	}

//	 미세먼지&초미세먼지 예보 url
	public static String dustForecastUrl(LocalDateTime date) {
		StringBuilder makingUrl = new StringBuilder();
		makingUrl.append("https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMinuDustFrcstDspth?searchDate=")
				.append(TimeFormat.dateWithBar(date)).append("&returnType=JSON&serviceKey=").append(apiKey)
				.append("&numOfRows=100&pageNo=1");
		return makingUrl.toString();
	}
}
