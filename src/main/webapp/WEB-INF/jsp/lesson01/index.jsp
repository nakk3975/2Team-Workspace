<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/static/css/style.css">
  <title>우리 날씨</title>
  <script src="/static/js/script.js" defer></script>
  <!-- jQuery CDN -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"
    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>

<body>

  <header class="navbar">

    <div>
      <!-- 왼쪽 이미지 -->
      <a href="#">
        <img src="/static/image/logo.png" id="logo" alt="왼쪽 이미지">
      </a>
    </div>

    <div>
      <h1>우리 날씨</h1>
    </div>

    <div class="login-container">
      <div>
        <a href="#">
          <button class="login-button">로그인</button>
        </a>
      </div>
      <div>
        <a href="#" class="login-option">아이디 찾기</a>
        <a href="#" class="login-option">비밀번호 찾기</a>
        <a href="#" class="login-option">회원가입</a>
      </div>
    </div>

  </header>


  <div id="box">

    <div id="top">
      <div id="midContent">
        <span class="mid-content-span">
          <a href="#" class="menu-bar" id="midContentLink">지역 날씨</a>
        </span>
        <span class="mid-content-span">
          <a href="#" class="menu-bar" id="midContentLink">세계 날씨</a>
        </span>
        <span class="mid-content-span">
          <a href="#" class="menu-bar" id="midContentLink">미세먼지</a>
        </span>
        <span class="mid-content-span">
          <a href="#" class="menu-bar" id="midContentLink">위성 영상</a>
        </span>
        <span class="mid-content-span">
          <a href="#" id="menuExcept" class="mid-content-link">날씨 앱</a>
        </span>
      </div>

      <div id="main">

        <div id="leftMain">
          <div id="leftMainTopNav">

            <div class="left_main_top_nav_menu">
              <span id="resultValue"></span>
              <select id="province">
                <option value="서울특별시" selected>서울특별시</option>
                <option value="부산광역시">부산광역시</option>
                <option value="대구광역시">대구광역시</option>
                <option value="인천광역시">인천광역시</option>
                <option value="광주광역시">광주광역시</option>
                <option value="대전광역시">대전광역시</option>
                <option value="울산광역시">울산광역시</option>
                <option value="세종특별자치시">세종특별자치시</option>
                <option value="경기도">경기도</option>
                <option value="충청북도">충청북도</option>
                <option value="충청남도">충청남도</option>
                <option value="전라북도">전라북도</option>
                <option value="전라남도">전라남도</option>
                <option value="경상북도">경상북도</option>
                <option value="경상남도">경상남도</option>
                <option value="제주특별자치도">제주특별자치도</option>
                <option value="강원특별자치도">강원특별자치도</option>
                
                <!-- 다른 시/도 추가 -->
              </select>
              <select id="city" disabled>
    			<option value="" selected disabled>구/군 선택</option>
    			<!-- 각 시/도에 따른 구/군 추가는 자바스크립트로 처리 -->
			  </select>
              <button id="generateResult">내 위치 검색</button>

            </div>

            <div id="leftMainTopTop">

              <!-- 상세날씨 -->
              <div class="left-main-top-top-img">
                <img src="/static/image/weathericons.png" alt="" class="main-img-position1">
              </div>


              <!-- 현재기온 어제기온비교 -->
              <div class="left-main-top-top-text">
                <!-- 현재 온도 -->
                <div class="result-t1h"></div>

                <div id="flex1">
                  <!-- 어제 온도 비교 -->
                  <div class="temperature-change"></div>
                  <!-- 날씨상태 맑음 흐림 구름  -->
                  <div class="weather-info"></div>
                </div>

              </div>



              <div class="temporary">
                <!-- 체감온도 -->
                <div id="seoulWeather"></div>
                <!-- 강수량 -->
                <div class="result-rn1"></div>
                <!-- 습도 -->
                <div class="result-reh"></div>

                <!-- 초미세먼지 -->
                <span class="resultUltrafineDust"></span>

                <Br>
                  <!-- 미세먼지 -->
                <span class="resultFineDust"></span>
                <Br>

                <span class="ultraviolet"></span>

              </div>

              <div id="seoulInfo1"></div>

            </div>


            <div id="leftMainTopMid">
              <span class="mid-content-span">
                <a href="#" class="menu-bar" id="midContentLink">날씨</a>
              </span>
              <span class="mid-content-span">
                <a href="#" class="menu-bar" id="midContentLink">강수</a>
              </span>
              <span class="mid-content-span">
                <a href="#" class="menu-bar" id="midContentLink">바람</a>
              </span>
              <span class="mid-content-span">
                <a href="#" class="menu-bar" id="midContentLink">습도</a>
              </span>
            </div>


            <div id="leftMainTopBot">
              <div id="scrollButtons">
              </div>
              <button id="scrollLeft">◀</button>
              <div id="weatherDataContainer">
                <div id="weatherData">
                    <!-- 여기에 날씨 데이터가 표시됩니다 -->
                </div>
                
            </div>
            <button id="scrollRight">▶</button>
            </div>
          </div>

          <div id="leftMainBot">
            주간 예보
            <div id="containerOpt">

              <div class="container">

                <div class="row">
                  <div class="item">
                    <span class="results" id="results0"></span>
                    <div class="flex-container0">
                      <div id="forecastData1"></div>
                      <div id="forecastData2"></div>
                    </div>
                  </div>
                  <div class="item">
                    <span class="results" id="results1"></span>
                    <div class="flex-container1">
                      <div id="forecastData3"></div>
                      <div id="forecastData4"></div>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="item">
                    <span class="results" id="results2"></span>
                    <div class="flex-container2">
                      <div id="forecastData5"></div>
                      <div id="forecastData6"></div>
                    </div>
                  </div>
                  <div class="item">
                    <span id="results3"></span>
                    <div class="flex-container3">
                      <p id="rnSt3Am"></p>
                      <p id="rnSt3Pm"></p>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="item">
                    <span id="results4"></span>
                    <div class="flex-container4">
                      <p id="rnSt4Am"></p>
                      <p id="rnSt4Pm"></p>
                  </div>
                  </div>
                  <div class="item">
                    <span id="results5"></span>
                    <div class="flex-container5">
                      <p id="rnSt5Am"></p>
                      <p id="rnSt5Pm"></p>
                  </div>
                  </div>
                </div>

                <div class="row">
                  <div class="item">
                    <span id="results6"></span>
                    <div class="flex-container6">
                      <p id="rnSt6Am"></p>
                      <p id="rnSt6Pm"></p>
                  </div>
                  </div>
                  <div class="item">
                    <span id="results7"></span>
                    <div class="flex-container7">
                      <p id="rnSt7Am"></p>
                      <p id="rnSt7Pm"></p>
                  </div>
                  </div>
                </div>

                <div class="row">
                  <div class="item">
                    <span id="results8"></span>
                    <div class="flex-container8">
                      <p id="rnSt8Am"></p>
                      <p id="rnSt8Pm"></p>
                  </div>
                  </div>
                  <div class="item">
                    <span id="results9"></span>
                    <div class="flex-container9">
                      <p id="rnSt9Am"></p>
                      <p id="rnSt9Pm"></p>
                  </div>
                  </div>
                </div>

              </div>
            </div>
          </div>
        </div>

        <div id="rightBanners">

          <p id="rightBannersP">
            전국 날씨
          </p>

          <div id="rightBannersContentTop">

            <div id="rightBannersContentTopDiv">

              <img src="/static/image/KoreanMap.jpg" alt="지도" id="koreaMap">
              <div>
                <button class="map-button">현재</button>
                <button class="map-button">오전</button>
                <button class="map-button">오후</button>
              </div>

              <div>

                <div id="mapSeoul">
                  <div>
                    <p class="map-div-p">서울</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">
                      <div class="result-t1h"></div>
                    </h6>
                  </div>
                </div>

                <div id="mapIncheon">
                  <div>
                    <p class="map-div-p">인천</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapChuncheon">
                  <div>
                    <p class="map-div-p">춘천</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapGangneung">
                  <div>
                    <p class="map-div-p">강릉</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapUlreungDokdo">
                  <div>
                    <p class="map-div-p">울릉/독도</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapSuwon">
                  <div>
                    <p class="map-div-p">수원</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapCheongju">
                  <div>
                    <p class="map-div-p">청주</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position1">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapAndong">
                  <div>
                    <p class="map-div-p">안동</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapPohang">
                  <div>
                    <p class="map-div-p">포항</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapDaejeon">
                  <div>
                    <p class="map-div-p">대전</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapJeonju">
                  <div>
                    <p class="map-div-p">전주</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapDaegu">
                  <div>
                    <p class="map-div-p">대구</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapUlsan">
                  <div>
                    <p class="map-div-p">울산</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapBusan">
                  <div>
                    <p class="map-div-p">부산</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapGwangju">
                  <div>
                    <p class="map-div-p">광주</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapMokpo">
                  <div>
                    <p class="map-div-p">목포</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position2">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapYeosu">
                  <div>
                    <p class="map-div-p">여수</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position1">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

                <div id="mapJeju">
                  <div>
                    <p class="map-div-p">제주</p>
                    <div class="map-div-img">
                      <img src="/static/image/weathericons.png" alt="" class="map-div-img-position1">
                    </div>
                    <h6 class="map-div-h6">9.5°C</h6>
                  </div>
                </div>

              </div>
            </div>

            <div id="rightBannersContentMid">서울 | 현재
              <!-- 현재 온도 -->
              <div class="result-t1h"></div>
              <!-- 날씨 흐림 맑음 -->
              <div class="weather-info"></div>
              <!-- 강수량 -->
              <div class="result-rn1"></div>
              <!-- 체감온도 -->
              <div id="seoulWeather2"></div>
              <!-- 오전 오후 온도 -->
              <p id="morningTemp"></p>
              <p id="afternoonTemp"></p>
            </div>

            <div id="rightBannersContentBot">
              <br>
              <div class="ultraviolet"></div>

              <div id="seoulInfo2"></div>

              <div class="resultUltrafineDust"></div>

              <div class="resultFineDust"></div>

              <div class="result-wsd"></div>

              <div class="result-vec"></div>

            </div>

          </div>

        </div>

      </div>





    </div>

    <footer id="bot">
      <pre>
     @Error404: Team Not Found Corp. </pre>
    </footer>

</body>


</html>