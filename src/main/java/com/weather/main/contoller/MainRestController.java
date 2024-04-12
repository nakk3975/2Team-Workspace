package com.weather.main.contoller;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.weather.main.sevice.MainService;

@RestController
@RequestMapping("/weather")
public class MainRestController {

	@Autowired
    private MainService mainService;

	// 지역별 정보
    @GetMapping("/getCityLocation")
    public String getCityLocation(@RequestParam("city") String city) {
        return mainService.getCityLocation(city);
    }

    // 내가 선택한 도시 날씨 정보
    @GetMapping("/getWeatherByCity")
    public String getWeatherByCity(@RequestParam("city") String city, @RequestParam("base_date") String base_date, @RequestParam("base_time") String base_time) throws UnsupportedEncodingException, URISyntaxException {
        return mainService.getWeatherByCity(city, base_date, base_time);
    }
}
