package com.weather.satellite.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Item {
	@JsonProperty("satImgC-file")
    public String satImgCFile;

	public String getSatImgCFile() {
		return satImgCFile;
	}

	public void setSatImgCFile(String satImgCFile) {
		this.satImgCFile = satImgCFile;
	}
	
	

}
