package com.weather.finedust.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TimeFormat {

	// yyyyMMdd 형식의 날짜 문자열을 반환하는 메서드
	public static String dateNormal(LocalDateTime dateTime) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		return dateTime.format(formatter);
	}
	
	// yyyy/MM/dd 형식의 날짜 문자열을 반환하는 메서드
	public static String dateWithSlash(LocalDateTime dateTime) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		return dateTime.format(formatter);
	}

	// yyyy-MM-dd 형식의 날짜 문자열을 반환하는 메서드
	public static String dateWithBar(LocalDateTime dateTime) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		return dateTime.format(formatter);
	}

	// yyyyMMddHH 형식의 날짜 문자열을 반환하는 메서드
	public static String dateWithHour(LocalDateTime dateTime) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHH");
		return dateTime.format(formatter);
	}
}
