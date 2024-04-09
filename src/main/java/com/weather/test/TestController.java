package com.weather.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/weather")
public class TestController {

	@GetMapping("/main")
	public String home() {
		return "lesson01/index";
	}
}
