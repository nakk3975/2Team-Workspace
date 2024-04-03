package com.weather.world.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.weather.world.dto.CountryDTO;

@Repository
public interface WorldMapper {

	public List<CountryDTO> getCountry();
}
