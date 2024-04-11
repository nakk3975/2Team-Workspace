package com.weather.user.mapper;

import org.apache.ibatis.annotations.Param;

import com.weather.user.dto.UserDTO;

public interface UserMapper {

	// 회원가입
	public int insertUser(@Param("id") String id
			, @Param("password") String password
			, @Param("name") String name
			, @Param("email") String email);
	
	// 로그인
	public UserDTO selectUser(@Param("id") String id);
	
	// 중복체크
	public int selectId(@Param("id") String id);
	
}
