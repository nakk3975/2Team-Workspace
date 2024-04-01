<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/static/css/style.css">
  <title>우리 날씨</title>
  <script src="/static/js/script.js" defer></script>
</head>

<body>

  <header class="navbar">
    <div>
      <!-- 왼쪽 이미지 -->
      <a href="#">
        <img src="/static/images/logo.png" id="Logo" alt="왼쪽 이미지">
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
        <a href="#" class="LoginOption">아이디 찾기</a>
        <a href="#" class="LoginOption">비밀번호 찾기</a>
        <a href="#" class="LoginOption">회원가입</a>
      </div>
    </div>
  </header>

  <div id="box">

    <div id="top">
      <div id="mid_content">
        <span>
          <a href="#" class="Menu">지역 날씨</a>
        </span>
        <span>
          <a href="#" class="Menu">세계 날씨</a>
        </span>
        <span>
          <a href="#" class="Menu">미세먼지</a>
        </span>
        <span>
          <a href="#" class="Menu">위성 영상</a>
        </span>
        <span>
          <a href="#" class="Menu_except">날씨 앱</a>
        </span>
      </div>

      <div id="main">

        <div id="left_main">
          <div id="left_main_top">
            <div class="left-main-top">
              <span id="resultValue"></span>
              <select id="province">
                <option value="서울특별시" selected>서울특별시</option>
                <option value="경기도">경기도</option>
                <!-- 다른 시/도 추가 -->
              </select>
              <select id="city" disabled>
                <option value="" selected disabled>구/군 선택</option>
                <!-- 각 시/도에 따른 구/군 추가 -->
              </select>
              <button id="generateResult">내 위치 검색</button>

            </div>

            <div id="left_main_top_top">
              상세날씨
            </div>
            <div id="left_main_top_mid">
              버튼
            </div>
            <div id="left_main_top_bot">
              버튼 슬라이드
            </div>
          </div>

          <div id="left_main_bot">
            주간 예보
            <div id="container_opt">
              <div class="container">
                <div class="row">
                  <div class="item">주간 예보</div>
                  <div class="item">주간 예보</div>
                </div>
                <div class="row">
                  <div class="item">주간 예보</div>
                  <div class="item">주간 예보</div>
                </div>
                <div class="row">
                  <div class="item">주간 예보</div>
                  <div class="item">주간 예보</div>
                </div>
                <div class="row">
                  <div class="item">주간 예보</div>
                  <div class="item">주간 예보</div>
                </div>
                <div class="row">
                  <div class="item">주간 예보</div>
                  <div class="item">주간 예보</div>
                </div>
              </div>
            </div>
          </div>

        </div>
        <div id="right_banners">
          <p>
            전국 날씨
          </p>
          <div id="right_banners_content_top">

            <div id="right_banners_content_top_div">

              <img src="/static/images/KoreanMap.jpg" alt="지도" id="koreamap">
              <div>
                <button class="mapbutton">현재</button>
                <button class="mapbutton">오전</button>
                <button class="mapbutton">오후</button>
              </div>

              <div>

                <div id="mapdivSeoul">
                  <div class="mapdiv">
                    <p>서울</p>
                    <div class="mapdivimg">
                      <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition">
                    </div>
                    <h6>9.5°C</h6>
                  </div>
                </div>

                  <div id="mapdivIncheon">
                    <div class="mapdiv">
                      <p>인천</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivChuncheon">
                    <div class="mapdiv">
                      <p>춘천</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivGangneung">
                    <div class="mapdiv">
                      <p>강릉</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivUlreungDokdo">
                    <div class="mapdiv">
                      <p>울릉/독도</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivSuwon">
                    <div class="mapdiv">
                      <p>수원</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivCheongju">
                    <div class="mapdiv">
                      <p>청주</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivAndong">
                    <div class="mapdiv">
                      <p>안동</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivPohang">
                    <div class="mapdiv">
                      <p>포항</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivDaejeon">
                    <div class="mapdiv">
                      <p>대전</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivJeonju">
                    <div class="mapdiv">
                      <p>전주</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivDaegu">
                    <div class="mapdiv">
                      <p>대구</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivUlsan">
                    <div class="mapdiv">
                      <p>울산</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivBusan">
                    <div class="mapdiv">
                      <p>부산</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivGwangju">
                    <div class="mapdiv">
                      <p>광주</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivMokpo">
                    <div class="mapdiv">
                      <p>목포</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition2">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivYeosu">
                    <div class="mapdiv">
                      <p>여수</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

                  <div id="mapdivJeju">
                    <div class="mapdiv">
                      <p>제주</p>
                      <div class="mapdivimg">
                        <img src="/static/images/weathericons.png" alt="" class="mapdivimgposition">
                      </div>
                      <h6>9.5°C</h6>
                    </div>
                  </div>

            </div>
          </div>

          <div id="right_banners_content_mid">위치
          </div>

          <div id="right_banners_content_bot">
            <br>
            풍속, 풍향, 일몰, 일출, <Br>
            미세먼지, 초미세먼지
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