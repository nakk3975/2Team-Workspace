package com.weather.user.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.weather.user.dto.UserDTO;
import com.weather.user.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserService userService;
	
	// 회원가입
	@PostMapping("/signup")
	public Map<String, String> signup(
			@RequestParam("id") String id
			, @RequestParam("password") String password
			, @RequestParam("name") String name
			, @RequestParam("email") String email) {
		// insert의 결과 값을 count에 저장
		// 성공 1, 실패 0
		int count = userService.addUser(id, password, name, email);
		
		Map<String, String> result = new HashMap<>();
		
		// count가 1이면 result에 success 저장
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	// 로그인
	@PostMapping("/signin")
	public Map<String, String> signin(
			@RequestParam("id") String id
			, @RequestParam("password") String password
			, HttpSession session) {
		// select의 결과 값을 user에 저장
		// 실패 null, 성공하면 회원가입 당시 유저 정보
		UserDTO user = userService.searchUser(id, password);
		
		Map<String, String> result = new HashMap<>();
		
		// user의 정보가 null이 아니면 result에 success 저장
		// session에 user 정보 저장
		if(user != null) {
			
			session.setAttribute("userId", user.getId());
			session.setAttribute("userName", user.getName());
			session.setAttribute("userEmail", user.getEmail());
			
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	// id 중복체크
	@GetMapping("/signup/duplication")
	public Map<String, Boolean> signupDuplication(@RequestParam("id") String id) {
		
		// select 한 결과를 count에 저장 (count로 select)
		int count = userService.selectLoginId(id);
		
		Map<String, Boolean> result = new HashMap<>();
		
		// Boolean 형식으로 count가 1이면 true, 0이면 false
		result.put("result", count == 1);

		return result;
	}
	
	// 비밀번호 찾기 시 입력 정보
	@PostMapping("/passwordsearch")
	public Map<String, String> passwordsearch(
			@RequestParam("id") String id
			, @RequestParam("email") String email
			, HttpServletRequest request) {
		
		UserDTO user = userService.passwordSearch(id, email);
		
		Map<String, String> result = new HashMap<>();
		
		if(user != null) {
			HttpSession session = request.getSession();
			
			session.setAttribute("userId", user.getNo());
			
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
	
	// 비밀번호 변경
	@PostMapping("/passwordchange")
	public Map<String, String> passwordChange(
			@RequestParam("no") int no
			, @RequestParam("password") String password){
		
		int count = userService.updatePassword(no, password);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
	
	// 아이디 찾기 결과
	@GetMapping("/idcheck")
	public Map<String, String> idCheck(
			@RequestParam("name") String name
			, @RequestParam("email") String email
			, HttpServletRequest request) {
		
		UserDTO user = userService.selectId(name, email);
		
		Map<String, String> result = new HashMap<>();

		if(user != null) {
			HttpSession session = request.getSession();
			
			session.setAttribute("userName", user.getName());
			session.setAttribute("userId", user.getId());
			
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
		
	}
	
}
