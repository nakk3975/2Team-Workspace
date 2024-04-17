package com.weather.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.weather.user.dto.UserDTO;
import com.weather.user.mapper.UserMapper;

@Service
public class UserService {

	@Autowired
	private UserMapper userMapper;
//	private final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

	// 회원가입
	public int addUser(String id, String password, String name, String email) {
		// 비밀번호 암호화
//		String encodePassword = encoder.encode(password);
		return userMapper.insertUser(id, password, name, email);
	}
	
	// 로그인
	public UserDTO searchUser(String id, String password) {
		// id로 유저정보 불러오기
		UserDTO user = userMapper.selectUser(id, password);
		// 유저의 정보가 null이 아니거나, 비밀번호가 암호화한 비밀번호와 일치 한지 확인
        return user;

	}
	
	// 아이디 중복체크
	public int selectLoginId(String id) {
		return userMapper.selectId(id);
	}
	
	// 비밀번호 찾기
	public UserDTO passwordSearch(String loginId, String email) {
		return userMapper.selectPasswordSearch(loginId, email);
	}
	
	// 비밀번호 변경
	public int updatePassword(int id, String password) {
		// 비밀번호 암호화
//		String encodePassword = encoder.encode(password);
		return userMapper.updatePassword(id, password);
	}
	
	// 아이디 찾기
	public UserDTO selectId(String name, String email) {
		return userMapper.selectIdByUser(name, email);
	}
}
