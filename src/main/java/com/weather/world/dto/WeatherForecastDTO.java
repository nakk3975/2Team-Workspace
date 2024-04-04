package com.weather.world.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class WeatherForecastDTO {
    private String cod;
    private int message;
    private int cnt;
    private List<Forecast> list;

    public String getCod() {
		return cod;
	}


	public void setCod(String cod) {
		this.cod = cod;
	}


	public int getMessage() {
		return message;
	}


	public void setMessage(int message) {
		this.message = message;
	}


	public int getCnt() {
		return cnt;
	}


	public void setCnt(int cnt) {
		this.cnt = cnt;
	}


	public List<Forecast> getList() {
		return list;
	}


	public void setList(List<Forecast> list) {
		this.list = list;
	}
}