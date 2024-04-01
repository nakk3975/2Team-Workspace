package com.weather.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
//브랜치 생성용으로 한겁니다.
@Controller
public class HelloController {

	@ResponseBody
	@GetMapping("/hello")
	public String Hello() {
		return "hello World";
	}
	
}
