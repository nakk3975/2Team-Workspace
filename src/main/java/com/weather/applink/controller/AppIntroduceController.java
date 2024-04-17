package com.weather.applink.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/app")
public class AppIntroduceController {
	
	@GetMapping("/introduce")
	public String appIntroduce() {
		return "applink/appintroduce";
	}

}
