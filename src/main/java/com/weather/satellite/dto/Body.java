package com.weather.satellite.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Body {

    public String dataType;
    public Items items;
    public Integer pageNo;
    public Integer numOfRows;
    public Integer totalCount;

}
