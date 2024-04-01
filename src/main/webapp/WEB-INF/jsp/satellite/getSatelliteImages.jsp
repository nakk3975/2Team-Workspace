<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.LocalTime"%>
<%@ page import="java.util.Optional"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- <link rel="stylesheet" href="/resources/getSatelliteImages.css"> -->
<title>우리 날씨 - 위성 이미지</title>
<script>
	function autoSubmit() {
    	// sessionStorage를 체크하여 페이지가 처음 로드됐는지 확인
    	if (!sessionStorage.getItem("formSubmitted")) {
        	// 폼을 자동으로 제출하고, 'formSubmitted'를 설정
        	document.forms['satelliteImageForm'].submit();
        	sessionStorage.setItem("formSubmitted", "true");
    	}
	}

	// 페이지 로드 시 autoSubmit 함수를 호출
	document.addEventListener("DOMContentLoaded", autoSubmit);
	
	// 재생버튼 로직
    function startAutoSubmit() {
		let hour = 0;
		let minute = 0;
		const interval = 1000; // 시간 업데이트 간격을 조정하려면 이 값을 변경하세요. 실제로는 600000 (10분)이 적절합니다.

		const intervalId = setInterval(() => {
			// 시간 문자열 생성
			let timeValue = `${hour.toString().padStart(2, '0')}:${minute.toString().padStart(2, '0')}`;

			// 폼의 hidden input 값을 업데이트
			document.getElementById('timeValue').value = timeValue;
                
			// 폼 제출
			// document.getElementById('timeForm').submit();

			console.log("제출 시간: " + timeValue); // 실제 제출 대신 콘솔에 로그 출력

			// 10분 증가
			minute += 10;
			if (minute >= 60) {
				minute = 0;
				hour++;
			}
                
			// 24시간이 지나면 중지(임시로 현재시간보다 크면 중지)
			if (hour >= selectedTime) {
				clearInterval(intervalId);
			}
		}, interval);
	}
    
    
</script>
</head>
<body onload="autoSubmit();">
	<!-- 날짜와 시간 구하기 -->
	<%
	// 오늘 날짜와 어제 날짜 구하기
	LocalDate today = LocalDate.now();
	LocalDate yesterday = today.minusDays(1);

	// 날짜 형식을 "yyyyMMdd"로 지정
    DateTimeFormatter formatterDate = DateTimeFormatter.ofPattern("yyyyMMdd");
    String formatToday = today.format(formatterDate);
    String formatYesterday = yesterday.format(formatterDate);
	
	// 현재 시간 구하기
	LocalTime now = LocalTime.now();
	
	// 10분전 10분후의 기준이 될 시간값 폼 제출로부터 받아오기
    String tenTime = request.getParameter("time");
	
	// 받아온 시간 값을 LocalTime으로 파싱
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HHmm");
    LocalTime time = LocalTime.parse(tenTime, formatter);
    
    // 10분 전 시간 계산
    LocalTime tenMinutesBefore = time.minusMinutes(10);
    String formattedTenMinutesBefore = tenMinutesBefore.format(formatter);

    // 10분 후 시간 계산
    LocalTime tenMinutesAfter = time.plusMinutes(10);
    String formattedTenMinutesAfter = tenMinutesAfter.format(formatter);
	
	// 현재 분을 10으로 나눈 후 다시 10을 곱하여 10분 단위로 내림
    int roundedDownMinute = (now.getMinute() / 10) * 10;
    LocalTime roundedTime = now.withMinute(roundedDownMinute).withSecond(0).withNano(0);
 	
 	// 현재 시간 "HHMM" 형태로 변환
    DateTimeFormatter formatterTime = DateTimeFormatter.ofPattern("HHmm");
    String formatTime = roundedTime.format(formatterTime);
    
	// 폼 제출로부터 날짜 값을 받습니다.
	String selectedDate = request.getParameter("date");
	String selectedTime = request.getParameter("time");
	
	// 받은 값들 테스트 결과 출력
    System.out.println("오늘 날짜 : " + formatToday);
    System.out.println("어제 날짜 : " + formatYesterday);
    System.out.println("현재 시간 : " + formatTime);
    System.out.println("현재 선택된 날짜 : " + selectedDate);
    System.out.println("현재 선택된 시간 : " + selectedTime);
	
    
	%>
	
	<div class="navbar">
		<div>
			<!-- <a href="index.html"><img src="/images/logo.png" id="Logo" alt="왼쪽 이미지"></a> -->
		</div>
		<div>
			<h1>우리 날씨</h1>
		</div>
		<div class="login-container">
			<div>
				<a href="/WEB-INF/views/user/signin"><button
						class="login-button">로그인</button></a>
			</div>
			<div>
				<a href="#" class="LoginOption">아이디 찾기</a> <a href="/"
					class="LoginOption">비밀번호 찾기</a> <a href="/user/signup"
					class="LoginOption">회원가입</a>
			</div>
		</div>
	</div>

	<div id="box">
		<div id="top">
			<div id="mid_content">
				<span><a href="index.html" class="Menu">지역 날씨</a></span>
				<span><a href="/" class="Menu">세계 날씨</a></span>
				<span><a href="/" class="Menu">미세먼지</a></span>
				<span><a href="/get" class="Menu">위성영상</a></span>
				<span><a href="/" class="Menu_except">날씨 앱</a></span>
			</div>

			<div id="main">
				<div id="main_title">
					<h2>위성 영상</h2>
				</div>
				<hr>
				<div>
					<form action="/satellite/getSatelliteImages" method="get" name="satelliteImageForm">
    					<!-- 날짜 선택 : 기본값으로 오늘 날짜 설정 -->
    					<input type="hidden" name="date" value="<%=formatToday%>">
    					
    					<!-- 날짜 선택 : 기본값으로 현태 시간 설정 -->
    					<input type="hidden" name="time" value="<%=formatTime%>">
    					
    					<!-- 미디어 타입 선택 : 기본값으로 ir105 설정-->
    					<input type="hidden" name="mediaType" value="ir105">
					</form>
					
					<form action="/satellite/getSatelliteImages" method="get">
						<select name="date" placeholder="날짜 선택">
							<option value="<%=formatYesterday%>">어제 (<%=formatYesterday%>)
							</option>
							<option value="<%=formatToday%>" selected>오늘 (<%=formatToday%>)
							</option>
						</select>
						<select name="time" placeholder="시간 선택">
							<c:forEach begin="0" end="23" var="hour">
        						<c:forEach begin="0" end="5" var="index">
            						<c:set var="minute" value="${index * 10}" />
            						<option value="${hour < 10 ? '0' : ''}${hour}${minute < 10 ? '0' : ''}${minute}">
                						${hour < 10 ? '0' : ''}${hour}:${minute < 10 ? '0' : ''}${minute}
            						</option>
        						</c:forEach>
    						</c:forEach>
						</select>
						<select name="mediaType" placeholder="영상 구분">
							<option value="ir105">적외영상</option>
							<option value="vi006">가시영상</option>
							<option value="wv069">수증기영상</option>
							<option value="sw038">단파적외영상</option>
							<option value="rgbt">RGB(컬러)영상</option>
							<option value="rgbdn">RGB(주야간합성)영상</option>
						</select> <input type="submit" value="조회">
					</form>
				</div>
				<div>
					<div id="searchedDate">
						선택된 날짜 : <%=selectedDate %>/<%=selectedTime%>
					</div>
					<div class="searchButton">
						<!-- 어제 버튼 -->
						<form action="/satellite/getSatelliteImages" method="get">
							<input type="hidden" name="date" value="<%=yesterday%>" />
							<button class="">어제</button>
						</form>
						
						<!-- 오늘 버튼 -->
						<form action="/satellite/getSatelliteImages" method="get">
							<input type="hidden" name="date" value="<%=today%>" />
							<button class="">오늘</button>
						</form>
						
						<!-- 10분 전 버튼 -->
						<form action="/satellite/getSatelliteImages" method="get">
							<input type="hidden" name="date" value="<%= selectedDate %>">
    						<input type="hidden" name="time" value="<%= formattedTenMinutesBefore %>">
    						<input type="submit" value="10분 전">
						</form>
						
						<!-- 10분 후 버튼 -->
						<form action="/satellite/getSatelliteImages" method="get">
							<input type="hidden" name="date" value="<%= selectedDate %>">
    						<input type="hidden" name="time" value="<%= formattedTenMinutesAfter %>">
    						<input type="submit" value="10분 후">
						</form>
						
						<!-- 재생 버튼 -->
						<form id="timeForm" action="YourServerSideEndpoint" method="get">
							<input type="hidden" id="timeValue" name="time" />
							<button type="button" onclick="startAutoSubmit();">재생</button>
						</form>
						
						<!-- 위성 이미지 출력 div -->
						<div id="satelliteImages">
							임시 이미지!!!
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="bot">
		<pre>@Error404: Team Not Found Corp.</pre>
	</div>
</body>
</html>