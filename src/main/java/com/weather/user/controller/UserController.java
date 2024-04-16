package com.weather.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
	
	// 아이디, 비밀번호 찾기 화면
	@GetMapping("/idSearch/view")
	public String idSearch() {
		return "user/idsearch";
	}
	
	// 비밀번호 변경 화면
	@GetMapping("/passwordChange/view")
	public String passwordChange() {
		return "user/passwordchange";
	}
	
	// 아이디 찾기 결과 화면
	@GetMapping("/idCheck/view")
	public String idCheck() {
		return "user/idcheck";
	}

	// 비밀번호 변경 후 세션 지우기
	@GetMapping("/passwordchange")
	public String passwordChangSuccess(HttpServletRequest request) {

		HttpSession session = request.getSession();
		
		session.removeAttribute("userId");
		
		return "redirect:/user/signin/view";
	}
	
	// 아이디 찾기 성공 후 화면 이동 시 세션 지우기
	@GetMapping("/idCheckSuccess")
	public String idCheckSuccess(HttpServletRequest request) {

		HttpSession session = request.getSession();
		
		session.removeAttribute("userId");
		session.removeAttribute("userName");
		
		return "redirect:/user/signin/view";
	}
	
	// 로그아웃
	@GetMapping("/signout")
	public String signout(HttpServletRequest request) {

		HttpSession session = request.getSession();
		session.removeAttribute("userId");
		session.removeAttribute("userName");
		session.removeAttribute("userEmail");
		
		return "redirect:/user/signin/view";
	}
	// 마이페이지 진입
	@GetMapping("/myPage/view")
	public String myPage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.getAttribute("userId");
		session.getAttribute("userName");
		session.getAttribute("userEmail");
		return "user/mypage";
	}
	// 마이페이지 수정 페이지 진입
	@GetMapping("/myPage/modify")
	public String myPageModify(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.getAttribute("userNo");
		session.getAttribute("userId");
		session.getAttribute("userName");
		session.getAttribute("userEmail");
		
		return "user/mypageModify";
	}
}
