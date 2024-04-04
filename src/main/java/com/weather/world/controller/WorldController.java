package com.weather.world.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/weather")
public class WorldController {
	
	// 세계날씨 화면
	@GetMapping("/world/view")
	public String worldView() {
		return "/world/worldweather";
	}
}
