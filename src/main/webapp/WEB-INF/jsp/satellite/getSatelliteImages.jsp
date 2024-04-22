<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.LocalTime"%>
<%@ page import="java.util.Optional"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    
   	<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/echarts@latest/dist/echarts.min.js"></script>
	
<link rel="stylesheet" href="/static/css/getSatelliteImages.css" type="text/css">
<title>우리 날씨 - 위성 이미지</title>
</head>
<body>
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

	// 받아온 시간 값 검증 및 파싱
	LocalTime time;
	if (tenTime != null && !tenTime.isEmpty()) {
		time = LocalTime.parse(tenTime, formatter);
	} else {
		// tenTime이 null 또는 빈 문자열인 경우 현재 시간 사용
		time = LocalTime.now();
	}

	// 10분 전과 10분 후 계산
	LocalTime tenMinutesBefore = time.minusMinutes(10);
	String formattedTenMinutesBefore = tenMinutesBefore.format(formatter);
	LocalTime tenMinutesAfter = time.plusMinutes(10);
	String formattedTenMinutesAfter = tenMinutesAfter.format(formatter);

	// 9시간 20분 전의 시간을 계산
	LocalTime nineHoursTenMinutesBefore = now.minusHours(9).minusMinutes(20);

	// 계산한 시간의 분을 10분 단위로 내림
	int minutes = nineHoursTenMinutesBefore.getMinute();
	int roundedDownMinutes = (minutes / 10) * 10;
	LocalTime roundedTime = nineHoursTenMinutesBefore.withMinute(roundedDownMinutes);

	// "HHMM" 형태로 변환
	DateTimeFormatter formatterTime = DateTimeFormatter.ofPattern("HHmm");
	String formatTime = roundedTime.format(formatterTime);

	// 폼 제출로부터 날짜 값을 받습니다.
	String selectedDate = request.getParameter("date");
	String selectedTime = request.getParameter("time");

	// 콘솔에 출력
	System.out.println("현재 선택된 날짜 : " + selectedDate);
	System.out.println("현재 선택된 시간 : " + selectedTime);

	// 영상종류 선언
	String infrared = "ir105";
	String visible = "vi006";
	String vapor = "wv069";
	String shortWave = "sw038";
	String rgbColor = "rgbt";
	String rgbDay = "rgbdn";

	// 선택된 미디어 타입 불러오기
	String selectedMediaType = request.getParameter("media_type");
	%>

	<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<div id="main">
			<div id="mainTitle">
				<h2>위성 영상</h2>
			</div>
			<hr>
			<br>
			<div id="mainForm">
				<div id="selectForm">
					<form action="/satellite/getSatelliteImages" method="get" id="submitForm">
						<!-- 날짜 선택(어제, 오늘) -->
						<select class="select_box" name="date" placeholder="날짜 선택">
							<option value="<%=formatYesterday%>">어제(<%=formatYesterday%>)</option>
							<option value="<%=formatToday%>" selected>오늘(<%=formatToday%>)</option>
						</select>
						<!-- 시간 선택 -->
						<select class="select_box" name="time" placeholder="시간 선택">
							<c:forEach begin="0" end="23" var="hour">
								<c:forEach begin="0" end="5" var="index">
									<c:set var="minute" value="${index * 10}" />
									<option value="${hour < 10 ? '0' : ''}${hour}${minute < 10 ? '0' : ''}${minute}">
										${hour < 10 ? '0' : ''}${hour}:${minute < 10 ? '0' : ''}${minute}
									</option>
								</c:forEach>
							</c:forEach>
						</select>
						<!-- 영상 종류 선택 -->
						<select class="select_box" name="media_type" placeholder="영상 구분">
							<option value="<%=infrared%>">적외영상</option>
							<option value="<%=visible%>">가시영상</option>
							<option value="<%=vapor%>">수증기영상</option>
							<option value="<%=shortWave%>">단파적외영상</option>
							<option value="<%=rgbColor%>">RGB(컬러)영상</option>
							<option value="<%=rgbDay%>">RGB(주야간합성)영상</option>
						</select>
						<input class="button_style" id="searchButton" type="submit" value="조회">
					</form>
				</div>
				<div id="buttonDiv">
					<div id="searchedDate">
						<!-- 사용자가 선택한 날짜와 시간 출력(초기값은 null) -->
						<input type="text" id="searchedText" value="<%=selectedDate%>/<%=selectedTime%>">
					</div>
					<div class="search_button">
						<!-- 어제 버튼 -->
						<div class="button_div">
							<form action="/satellite/getSatelliteImages" method="get" id="yesterdayForm">
								<input type="hidden" name="date" value="<%=formatYesterday%>" />
								<input type="hidden" name="time" value="<%=selectedTime%>">
								<input type="hidden" name="media_type" value="<%=selectedMediaType%>">
								<input class="button_style" type="submit" id="yesterdayButton" value="어제">
							</form>
						</div>
						<!-- 오늘 버튼 -->
						<div class="button_div">
							<form action="/satellite/getSatelliteImages" method="get" id="todayForm">
								<input type="hidden" name="date" value="<%=formatToday%>" />
								<input type="hidden" name="time" value="<%=selectedTime%>">
								<input type="hidden" name="media_type" value="<%=selectedMediaType%>">
								<input class="button_style" type="submit" id="todayButton" value="오늘">
							</form>
						</div>
						<!-- 10분전 버튼 -->
						<div class="button_div">
							<form action="/satellite/getSatelliteImages" method="get" id="tenMinBeforeForm">
								<input type="hidden" name="date" value="<%=selectedDate%>">
								<input type="hidden" name="time" value="<%=formattedTenMinutesBefore%>">
								<input type="hidden" name="media_type" value="<%=selectedMediaType%>">
								<input class="button_style" type="submit" id="tenBeforeButton" value="&lt;&lt;">
							</form>
						</div>
						<!-- 10분후 버튼 -->
						<div class="button_div">
							<form action="/satellite/getSatelliteImages" method="get" id="tenMinAfterForm">
								<input type="hidden" name="date" value="<%=selectedDate%>">
								<input type="hidden" name="time" value="<%=formattedTenMinutesAfter%>">
								<input type="hidden" name="media_type" value="<%=selectedMediaType%>">
								<input class="button_style" type="submit" id="tenAfterButton" value="&gt;&gt;">
							</form>
						</div>
						<!-- 재생/멈춤 버튼 -->
						<div class="button_div">
							<input class="button_style" type="button" id="playButton" value="재생">
							<input class="button_style" type="button" id="stopButton" value="멈춤">
						</div>
					</div>
				</div>
			</div>
			<hr>
			<br>
			<!-- 위성 이미지 출력 div -->
			<div id="satelliteImage" data-setss="${satellite.response.body.items.item.get(0).satImgCFile}">
				<div id="alertMessage">
					조회 버튼을 눌러 조회하고싶은 시간대와 이미지 종류를 선택하십시오.
					<br>
					현재 시간 기준 9시간 10분 전(<%=formatTime %>)까지의 정보만 제공됩니다.
				</div>
				<br>
				<!-- 대문 이미지가 출력될 공간 -->
				<img id="defaultImage" src="/static/image/Satellite.png">
				
				<!-- 위성 이미지가 출력될 공간 -->
				<img id="response" src="">
			</div>
		</div>
	</div>
	<c:import url="/WEB-INF/jsp/include/footer.jsp" />
<script>	
	$(document).ready(function() {
		// 조회 버튼 클릭 시 이미지 URL 업데이트
	   	$('#searchButton').on('click', function(event) {
	   		// 기본 이벤트(폼 제출 등) 방지
	   	    event.preventDefault();
	   	
	   		// 폼 제출
	   	 	$('#submitForm').submit();
	   	 	
	    });
		
	 	// 어제 버튼 클릭 시 이미지 URL 업데이트
	    $("#yesterdayButton").click(function(event) {
	    	// 기본 이벤트(폼 제출 등) 방지
	   	    event.preventDefault();
	   	
	   		// 폼 제출
	   	 	$('#yesterdayForm').submit();
	    });
	 	
	 	// 오늘 버튼 클릭 시 이미지 URL 업데이트
	    $("#todayButton").click(function(event) {
	    	// 기본 이벤트(폼 제출 등) 방지
	   	    event.preventDefault();
	   	
	   		// 폼 제출
	   	 	$('#todayForm').submit();
	    });
	 
	 	// 10분 전 버튼 클릭 시 이미지 URL 업데이트
	    $("#tenBeforeButton").click(function(event) {
	    	// 기본 이벤트(폼 제출 등) 방지
	   	    event.preventDefault();
	   		
	    	// 폼 제출
	   	 	$('#tenMinBeforeForm').submit();
	    });
	 	
	 	// 10분 후 버튼 클릭 시 이미지 URL 업데이트
	    $("#tenAfterButton").click(function(event) {
	    	// 기본 이벤트(폼 제출 등) 방지
	   	    event.preventDefault();
	   	
	   		// 폼 제출
	   	 	$('#tenMinAfterForm').submit();
	    });

	    // "재생" 버튼 클릭 시 이미지 URL 자동 갱신
	    $("#playButton").click(function(event) {
	        var satImgCFile = $('#satelliteImage').data("setss");
	        var urls = satImgCFile.split(",");
	        var currentIndex = 0;
	        var intervalId;
			
	     	// 불러온 여러 이미지 URL들을 날짜별로 분리
	        function updateImage() {
	            var trimmedUrl = urls[currentIndex].trim().replace(/\[|\]/g, '');
	            $('#response').attr('src', trimmedUrl);
	            currentIndex = (currentIndex + 1) % urls.length; // 다음 URL 인덱스로 이동
	        }

	        updateImage(); // 최초 실행

	        // 10초마다 이미지 URL 업데이트
	        intervalId = setInterval(updateImage, 1000);

	        // "멈춤" 버튼 클릭 시 setInterval 중지
	        $("#stopButton").click(function() {
	            clearInterval(intervalId);
	        });
	    });
	    
	});
	
	// 사용자가 선택한 시간과 날짜에 맞게 이미지 URL 뽑아오는 로직
	function loadImageAfterSubmit() {
	    // 불러온 여러 이미지 URL들을 날짜별로 분리
	    var satImgCFile = $('#satelliteImage').data("setss");
	    
	    // "," 기준으로 분리 후 대괄호 제거
	    var urls = satImgCFile.split(",").map(function(url) {
	        return url.trim().replace(/\[|\]/g, '');
	    });
		
	 	// 폼에서 직접 시간 값을 가져옵니다.
   		var selectedDate = "<%=selectedDate%>"; // 사용자가 선택한 날짜
   		var selectedTime = "<%=selectedTime%>"; // 사용자가 선택한 시간

   		// 선택한 날짜와 시간이 포함된 url을 반환해서 변수에 저장
		var matchedUrl = urls.find(function(url) {
			return url.includes(selectedDate + selectedTime);
		});

   		// 일치한 url이 있다면 img태그의 src에 matchedUrl을 설정
	    if (matchedUrl) {
	        $('#response').attr('src', matchedUrl + "?timestamp=" + new Date().getTime());
	        $('#defaultImage').hide();
	        $('#alertMessage').hide(); // 이미지가 있으므로 경고 메시지 숨김
	    } else if(!selectedDate || !selectedTime){ // 사용자가 날짜와 시간을 선택하지 않은 경우라면
	        // 날짜와 시간이 설정되지 않았을 경우, 초기 경고창과 메시지를 표시하지 않음
		    $('#response').hide();
	    	// img 태그 숨김
	    }
	}

	document.addEventListener("DOMContentLoaded", function() {
		loadImageAfterSubmit();
	});
</script>
</body>
</html>