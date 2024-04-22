package com.weather.world.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Snow {
	@JsonProperty("3h")
	private double h3;

	public double getH3() {
		return h3;
	}

	public void setH3(double h3) {
		this.h3 = h3;
	}

}
