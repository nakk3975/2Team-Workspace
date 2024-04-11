package com.weather.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {
	
	// 회원가입 화면
	@GetMapping("/signup/view")
	public String signup() {
		return "/user/signup";
	}
	
	// 로그인 화면
	@GetMapping("/signin/view")
	public String signin() {
		return "/user/signin";
	}
	
	
}
