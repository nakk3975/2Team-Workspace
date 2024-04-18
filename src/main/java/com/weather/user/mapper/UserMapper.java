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
	public UserDTO selectUser(@Param("id") String id, @Param("pw") String password);
	
	// 중복체크
	public int selectId(@Param("id") String id);
	
	// 비밀번호 찾기
	public UserDTO selectPasswordSearch(
			@Param("id") String id
			, @Param("email") String email);
	
	// 비밀번호 변경
	public int updatePassword(
			@Param("no") int no
			, @Param("password") String password);
	
	// 아이디 찾기
	public UserDTO selectIdByUser(
			@Param("name") String name
			, @Param("email") String email);
	
	// 정보 변경
	public int mypageModify(
			@Param("no") int no
			, @Param("name") String name
			, @Param("email")String email);
	
}
