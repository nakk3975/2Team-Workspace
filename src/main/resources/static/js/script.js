// script.js 파일에 저장
const provinceSelect = document.getElementById('province');
const citySelect = document.getElementById('city');
const resultDiv = document.getElementById('resultValue');
const generateResultButton = document.getElementById('generateResult');
va
const citiesByProvince = {
    '서울특별시': {
        '종로구': {x: 60, y: 127},
        '중구': {x: 60, y: 127},
        '용산구': {x: 60, y: 126},
        '성동구': {x: 61, y: 127},
        '광진구': {x: 62, y: 126},
        '동대문구': {x: 61, y: 127},
        '중랑구': {x: 62, y: 128},
        '성북구': {x: 61, y: 127},
        '강북구': {x: 61, y: 128},
        '도봉구': {x: 61, y: 129},
        '노원구': {x: 61, y: 129},
        '은평구': {x: 59, y: 127},
        '서대문구': {x: 59, y: 127},
        '마포구': {x: 59, y: 127},
        '양천구': {x: 58, y: 126},
        '강서구': {x: 58, y: 126},
        '구로구': {x: 58, y: 125},
        '금천구': {x: 59, y: 124},
        '영등포구': {x: 58, y: 126},
        '동작구': {x: 59, y: 125},
        '관악구': {x: 59, y: 125},
        '서초구': {x: 61, y: 125},
        '강남구': {x: 61, y: 126},
        '송파구': {x: 62, y: 126},
        '강동구': {x: 62, y: 126}
    }
    // 다른 시/도에 따른 구/군 정보 추가
};

function populateOptions(selectElement, options) {
    selectElement.innerHTML = '';
    options.forEach(option => {
        const optionElement = document.createElement('option');
        optionElement.textContent = option;
        optionElement.value = option;
        selectElement.appendChild(optionElement);
    });
}

function updateCityOptions() {
    const selectedProvince = provinceSelect.value;
    const cities = citiesByProvince[selectedProvince];
    populateOptions(citySelect, cities);
    citySelect.disabled = false;
    updateResult();
}

function updateResult() {
    const province = provinceSelect.value;
    const city = citySelect.value || "";
    resultDiv.textContent = `${province} ${city}`;
}

function printSelectedValuesToConsole() {
    const province = provinceSelect.value;
    const city = citySelect.value || "";
    console.log(`${province} ${city}`);
}



provinceSelect.addEventListener('change', updateCityOptions);
citySelect.addEventListener('change', updateResult);
generateResultButton.addEventListener('click', printSelectedValuesToConsole);

updateCityOptions();
updateResult();

// script.js 파일

//어제 날짜
function getYesterday() {
    var yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);

    var year = yesterday.getFullYear();
    var month = yesterday.getMonth() + 1;
    var day = yesterday.getDate();
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;

    return year + "" + month + "" + day;
}

// 오늘 날짜를 가져오는 함수
function getToday() {
    var today = new Date();
    var year = today.getFullYear();
    var month = today.getMonth() + 1;
    var day = today.getDate();
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;
    return year + "" + month + "" + day;
}

// 오늘 날짜 다른 함수
function getTodayFormatted() {
    var today = new Date();
    var tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate());

    var month = tomorrow.getMonth() + 1;
    var day = tomorrow.getDate();
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;

    return month + "." + day;
}

//내일 날짜를 가져오는 함수
function getTomorrow() {
    var today = new Date();
    var tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    var year = tomorrow.getFullYear();
    var month = tomorrow.getMonth() + 1;
    var day = tomorrow.getDate();
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;

    return year + "" + month + "" + day;
}

// 내일 날짜 다른 함수
function getTomorrowFormatted() {
    var today = new Date();
    var tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    var month = tomorrow.getMonth() + 1;
    var day = tomorrow.getDate();
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;

    return month + "." + day;
}

// 모레 날짜를 가져오는 함수
function getDayAfterTomorrow() {
    var today = new Date();
    var dayAfterTomorrow = new Date(today);
    dayAfterTomorrow.setDate(dayAfterTomorrow.getDate() + 2);

    var year = dayAfterTomorrow.getFullYear();
    var month = dayAfterTomorrow.getMonth() + 1;
    var day = dayAfterTomorrow.getDate();
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;

    return year + "" + month + "" + day;
}

// 모레 날짜 다른 함수
function getAfterTomorrowFormatted() {
    var today = new Date();
    var tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 2);

    var month = tomorrow.getMonth() + 1;
    var day = tomorrow.getDate();
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;

    return month + "." + day;
}

var baseDateYesterday = getYesterday(); // 어제 날짜

var baseDateToday = getTodayFormatted() // 오늘 날짜 00.00 버전

$.getJSON("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=1000&dataType=JSON&base_date=" + baseDateYesterday + "&base_time=0500&nx=55&ny=127",
    function (data) {
        console.log(data);

        let tmn_today = {},
            tmx_today = {};

        // 각 항목을 반복하면서
        $.each(data.response.body.items.item, function (index, item) {
            let date = item.fcstDate;
            let value = item.fcstValue;

            if (date === getTomorrow()) {
                // 카테고리가 'TMN' (최저 기온)인 경우
                if (item.category == "TMN") {
                    tmn_today[date] = parseInt(value); // 정수로 변환
                }
                // 카테고리가 'TMX' (최고 기온)인 경우
                else if (item.category == "TMX") {
                    tmx_today[date] = parseInt(value); // 정수로 변환
                }
            }
        });

        // tmn_today과 tmx_today에 저장된 값을 결과에 표시
        $.each(tmn_today, function (date, value) {
            let content = "오늘 " + baseDateToday + "<br>" + value + "° / " + tmx_today[date] + "°";
            $('#results0').append('<p>' + content + '</p>');
        });

    });


var baseDate = getToday(); // 오늘 날짜

var baseDateTomorrow = getTomorrowFormatted() // 내일 날짜 00.00 버전

var baseDateAfterTomorrow = getAfterTomorrowFormatted() // 모레 날짜 00.00 버전

$.getJSON("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=1000&dataType=JSON&base_date=" + baseDate + "&base_time=0500&nx=55&ny=127",
    function (data) {
        console.log(data);

        let tmn_today = {},
            tmx_today = {},
            tmn_dayAfterTomorrow = {},
            tmx_dayAfterTomorrow = {};

        // 각 항목을 반복하면서
        $.each(data.response.body.items.item, function (index, item) {
            let date = item.fcstDate;
            let value = item.fcstValue;

            if (date === getTomorrow()) {
                // 카테고리가 'TMN' (최저 기온)인 경우
                if (item.category == "TMN") {
                    tmn_today[date] = parseInt(value);
                }
                // 카테고리가 'TMX' (최고 기온)인 경우
                else if (item.category == "TMX") {
                    tmx_today[date] = parseInt(value);
                }
            } else if (date === getDayAfterTomorrow()) {
                // 카테고리가 'TMN' (최저 기온)인 경우
                if (item.category == "TMN") {
                    tmn_dayAfterTomorrow[date] = parseInt(value);
                }
                // 카테고리가 'TMX' (최고 기온)인 경우
                else if (item.category == "TMX") {
                    tmx_dayAfterTomorrow[date] = parseInt(value);
                }
            }
        });

        // tmn_today과 tmx_today에 저장된 값을 결과에 표시
        $.each(tmn_today, function (date, value) {
            let content = "내일 " + baseDateTomorrow + "<br>" + value + "° / " + tmx_today[date] + "°";
            $('#results1').append('<p>' + content + '</p>');
        });

        // tmn_dayAfterTomorrow과 tmx_dayAfterTomorrow에 저장된 값을 결과에 표시
        $.each(tmn_dayAfterTomorrow, function (date, value) {
            let content = baseDateAfterTomorrow + "<br>" + value + "° / " + tmx_dayAfterTomorrow[date] + "°";
            $('#results2').append('<p>' + content + '</p>');
        });


        // 버튼 슬라이드
               // 캐시 객체 생성
var cache = {};

// 기온 및 날씨 정보를 가져오는 함수
function getWeatherData() {
    // 캐시 확인
    if (cache.weatherData) {
        // 캐시된 데이터가 있는 경우, 캐시된 데이터를 사용하여 페이지 업데이트
        updatePage(cache.weatherData);
    } else {
        // 캐시된 데이터가 없는 경우, API 요청 보내기
        $.getJSON("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=1000&dataType=JSON&base_date=" + baseDate + "&base_time=0500&nx=60&ny=127",
            function (data) {
                var category = "TMP"; // 기온을 나타내는 category

                // 데이터에서 원하는 category 값인 TMP를 필터링
                var forecastData = data.response.body.items.item.filter(item => item.category === category);

                // 캐시에 데이터 저장
                cache.weatherData = forecastData;

                // 페이지 업데이트
                updatePage(forecastData);
            });
    }
}
        $(document).ready(function () {
            const container = $('#weatherDataContainer');
            const scrollLeft = $('#scrollLeft');
            const scrollRight = $('#scrollRight');

            scrollLeft.click(function () {
                container.scrollLeft(container.scrollLeft() - 100);
            });

            scrollRight.click(function () {
                container.scrollLeft(container.scrollLeft() + 100);
            });

            // 기온 및 날씨 정보를 모두 가져오는 함수 호출
            getWeatherData();
        });

        // 기온 및 날씨 정보를 가져오는 함수
        function getWeatherData() {
            $.getJSON("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=1000&dataType=JSON&base_date=" + baseDate + "&base_time=0500&nx=60&ny=127",
                function (data) {
                    var category = "TMP"; // 기온을 나타내는 category

                    // 데이터에서 원하는 category 값인 TMP를 필터링
                    var forecastData = data.response.body.items.item.filter(item => item.category === category);

                    // 내일, 모레, 글피 날짜 설정
                    var tomorrowIndex = 18;
                    var dayAfterTomorrowIndex = 42;
                    var dayAfterDayAfterTomorrowIndex = 66;

                    // 필터링된 데이터를 화면에 표시
                    forecastData.forEach(function (item, index) {
                        var hour = item.fcstTime.substr(0, 2);
                        var time = hour + "시";
                        var temperature = item.fcstValue;

                        // 날짜 변경
                        var date = "";
                        if (index === tomorrowIndex) {
                            date = "내일";
                        } else if (index === dayAfterTomorrowIndex) {
                            date = "모레";
                        } else if (index === dayAfterDayAfterTomorrowIndex) {
                            date = "글피";
                        }

                        // span 요소 생성하여 데이터 추가
                        var span = $("<span class='weatherItem'></span>");
                        var temperatureSpan = $("<span class='temperature'></span>").text(temperature + "℃");
                        var timeSpan = $("<span class='time'></span>").text(time);
                        var dateSpan = $("<span class='date'></span>").text(date);

                        // span에 온도, 시간, 날짜 순으로 추가
                        span.append(temperatureSpan);
                        span.append(timeSpan);
                        $("#weatherData").append(span);
                        span.append(dateSpan);

                        // 그래프를 그리고 날씨 이미지를 표시하는 함수 호출
                        drawGraphAndShowWeatherImage(span, item.fcstTime, temperature);
                    });
                });
        }

        // 그래프를 그리고 날씨 이미지를 표시하는 함수
        function drawGraphAndShowWeatherImage(span, fcstTime, temperature) {
            // 그래프를 그리는 함수 호출
            drawGraph([parseInt(temperature)], span.get(0), span);
            // 날씨 이미지를 표시하는 함수 호출
            showWeatherImage(span, fcstTime);
        }

        // 그래프를 그리는 함수
        function drawGraph(temperature, container, span) {
            var graphContainer = document.createElement('div');
            graphContainer.classList.add('graph');

            temperature.forEach(function (temp) {
                var line = document.createElement('div');
                line.classList.add('graph-line');
                line.style.height = temp + 'px';
                graphContainer.appendChild(line);
            });

            container.insertBefore(graphContainer, container.childNodes[1]); // 그래프를 온도 뒤에 삽입
        }

        // 날씨 이미지를 표시하는 함수
        function showWeatherImage(span, fcstTime) {
            $.getJSON("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&base_date=" + baseDate + "&base_time=0500&nx=60&ny=127",
                function (data) {
                    var items = data.response.body.items.item;
                    var skyValue = null;
                    var ptyValue = null;

                    for (var i = 0; i < items.length; i++) {
                        var item = items[i];
                        if (item.fcstTime === fcstTime) {
                            if (item.category === 'SKY') {
                                switch (item.fcstValue) {
                                    case '1':
                                        skyValue = '맑음';
                                        break;
                                    case '3':
                                        skyValue = '구름많음';
                                        break;
                                    case '4':
                                        skyValue = '흐림';
                                        break;
                                }
                            } else if (item.category === 'PTY') {
                                switch (item.fcstValue) {
                                    case '0':
                                        // PTY 값이 '없음'인 경우에는 skyValue를 사용
                                        ptyValue = '없음';
                                        break;
                                    case '1':
                                        ptyValue = '비';
                                        break;
                                    case '2':
                                        ptyValue = '비/눈';
                                        break;
                                    case '3':
                                        ptyValue = '눈';
                                        break;
                                    case '5':
                                        ptyValue = '빗방울';
                                        break;
                                    case '6':
                                        ptyValue = '빗방울눈날림';
                                        break;
                                    case '7':
                                        ptyValue = '눈날림';
                                        break;
                                }
                            }
                        }
                    }

                    let weatherInfo = ptyValue === '없음' ? skyValue : ptyValue;

                    // 이미지 URL 매핑
                    let imageUrl = '';
                    switch (weatherInfo) {
                        case '맑음':
                            imageUrl = '/static/image/맑은하늘.png';
                            break;
                        case '구름많음':
                            imageUrl = '/static/image/구름_많음.png';
                            break;
                        case '흐림':
                            imageUrl = '/static/image/대체로_맑음.png';
                            break;
                        case '비':
                            imageUrl = '/static/image/밤에_눈.png';
                            break;
                        case '비/눈':
                            imageUrl = '/static/image/폭우.png';
                            break;
                        case '눈':
                            imageUrl = '/static/image/폭설.png';
                            break;
                        case '빗방울':
                            imageUrl = '/static/image/물방울.png';
                            break;
                        case '빗방울눈날림':
                            imageUrl = '/static/image/물방울.png';
                            break;
                        case '눈날림':
                            imageUrl = '/static/image/눈송이.png';
                            break;
                        default:
                            imageUrl = '/static/image/맑은하늘.png';
                            break;
                    }

                    // 이미지를 추가하여 표시
                    var image = document.createElement('img');
                    image.classList.add('weatherImage');
                    image.src = imageUrl;
                    span.append(image);
                });
        }



        // 오늘~2일 강수량

        function formatDate(date) {
            var year = date.getFullYear();
            var month = (date.getMonth() + 1).toString().padStart(2, '0');
            var day = date.getDate().toString().padStart(2, '0');
            return year + month + day;
        }

        function fetchData(url) {
            return fetch(url)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    return data.response.body.items.item;
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                    return []; // 빈 배열 반환하여 오류 발생 시 데이터 처리할 수 있도록 함
                });
        }

        async function processData() {
            const today = new Date();
            const tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            const afterTomorrow = new Date();
            afterTomorrow.setDate(afterTomorrow.getDate() + 2);

            const url = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=1000&dataType=JSON&base_date=" + formatDate(today) + "&base_time=0500&nx=60&ny=127";

            try {
                const data = await fetchData(url);

                const forecasts = [
                    { date: today, time: "0600", period: "0 오전", divId: "#forecastData1" },
                    { date: today, time: "1200", period: "0 오후", divId: "#forecastData2" },
                    { date: tomorrow, time: "0500", period: "1 오전", divId: "#forecastData3" },
                    { date: tomorrow, time: "1200", period: "1 오후", divId: "#forecastData4" },
                    { date: afterTomorrow, time: "0500", period: "2 오전", divId: "#forecastData5" },
                    { date: afterTomorrow, time: "1200", period: "2 오후", divId: "#forecastData6" }
                ];

                forecasts.forEach(forecast => {
                    const selectedData = data.find(item =>
                        item.fcstDate === formatDate(forecast.date) &&
                        item.category === "POP" &&
                        item.fcstTime === forecast.time
                    );

                    if (selectedData) {
                        const fcstValue = selectedData.fcstValue;
                        const html = "<div>" + forecast.period + "<br>" + fcstValue + "%</div>";
                        $(forecast.divId).html(html);
                    } else {
                        $(forecast.divId).html("<div>No data found for the specified conditions</div>");
                    }
                });
            } catch (error) {
                console.error('Error processing data:', error);
            }
        }

        processData();


        ///3일~10일
        // 3일부터 10일까지의 날짜 반환하는 함수
        function getLaterDate(daysLater) {
            var today = new Date();
            var futureDate = new Date(today);
            futureDate.setDate(futureDate.getDate() + daysLater);

            var month = futureDate.getMonth() + 1;
            var day = futureDate.getDate();
            month = month < 10 ? '0' + month : month;
            day = day < 10 ? '0' + day : day;

            return month + "." + day;
        }

        var baseDateThreeDay = getLaterDate(3); // 3일 후 날짜
        var baseDateFourDay = getLaterDate(4); // 4일 후 날짜
        var baseDateFiveDay = getLaterDate(5); // 5일 후 날짜
        var baseDateSixDay = getLaterDate(6); // 6일 후 날짜
        var baseDateSevenDay = getLaterDate(7); // 7일 후 날짜
        var baseDateEightDay = getLaterDate(8); // 8일 후 날짜
        var baseDateNineDay = getLaterDate(9); // 9일 후 날짜
        var baseDateTenDay = getLaterDate(10); // 10일 후 날짜

        $.getJSON("https://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&regId=11B10101&tmFc=" + baseDate + "0600",
            function (data) {
                console.log(data);

                let item = data.response.body.items.item[0];

                let content = baseDateThreeDay + "<br>" + item.taMin3 + "° / " + item.taMax3 + "°";
                $('#results3').html(content);

                let content2 = baseDateFourDay + "<br>" + item.taMin4 + "° / " + item.taMax4 + "°";
                $('#results4').html(content2);

                let content3 = baseDateFiveDay + "<br>" + item.taMin5 + "° / " + item.taMax5 + "°";
                $('#results5').html(content3);

                let content4 = baseDateSixDay + "<br>" + item.taMin6 + "° / " + item.taMax6 + "°";
                $('#results6').html(content4);

                let content5 = baseDateSevenDay + "<br>" + item.taMin7 + "° / " + item.taMax7 + "°";
                $('#results7').html(content5);

                let content6 = baseDateEightDay + "<br>" + item.taMin8 + "° / " + item.taMax8 + "°";
                $('#results8').html(content6);

                let content7 = baseDateNineDay + "<br>" + item.taMin9 + "° / " + item.taMax9 + "°";
                $('#results9').html(content7);

                let content8 = baseDateTenDay + "<br>" + item.taMin10 + "° / " + item.taMax10 + "°";
                $('#results10').html(content8);

            });

        // 3~7일 강수량

        $.getJSON("https://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&regId=11B00000&tmFc=" + baseDate + "0600",
            function (data) {

                let item = data.response.body.items.item[0];
                let content3a = "3 오전 <br>" + item.rnSt3Am + "%";
                let content3p = "3 오후 <br>" + item.rnSt3Pm + "%";
                let content4a = "4 오전 <br>" + item.rnSt4Am + "%";
                let content4p = "4 오후 <br>" + item.rnSt4Pm + "%";
                let content5a = "5 오전 <br>" + item.rnSt5Am + "%";
                let content5p = "5 오후 <br>" + item.rnSt5Pm + "%";
                let content6a = "6 오전 <br>" + item.rnSt6Am + "%";
                let content6p = "6 오후 <br>" + item.rnSt6Pm + "%";
                let content7a = "7 오전 <br>" + item.rnSt7Am + "%";
                let content7p = "7 오후 <br>" + item.rnSt7Pm + "%";
                let content8a = "8 오전 <br>" + item.rnSt8 + "%";
                let content8p = "8 오후 <br>" + item.rnSt8 + "%";
                let content9a = "9 오전 <br>" + item.rnSt9 + "%";
                let content9p = "9 오후 <br>" + item.rnSt9 + "%";
                let content10a = "10 오전 <br>" + item.rnSt10 + "%";
                let content10p = "10 오후 <br>" + item.rnSt10 + "%";

                $('#rnSt3Am').html(content3a);
                $('#rnSt3Pm').html(content3p);
                $('#rnSt4Am').html(content4a);
                $('#rnSt4Pm').html(content4p);
                $('#rnSt5Am').html(content5a);
                $('#rnSt5Pm').html(content5p);
                $('#rnSt6Am').html(content6a);
                $('#rnSt6Pm').html(content6p);
                $('#rnSt7Am').html(content7a);
                $('#rnSt7Pm').html(content7p);
                $('#rnSt8Am').html(content8a);
                $('#rnSt8Pm').html(content8p);
                $('#rnSt9Am').html(content9a);
                $('#rnSt9Pm').html(content9p);
                $('#rnSt10Am').html(content10a);
                $('#rnSt10Pm').html(content10p);
            });

        // 실시간 기온
        $.getJSON("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=1000&dataType=JSON&base_date=" + baseDate + "&base_time=0600&nx=60&ny=127",
            function (data) {
                console.log(data);
                // 데이터에서 T1H 값을 찾아서 출력
                var items = data.response.body.items.item;
                var t1hValue;
                for (var i = 0; i < items.length; i++) {
                    if (items[i].category === "T1H") {
                        t1hValue = items[i].obsrValue;
                        console.log("실황기온: " + t1hValue);
                        $(".result-t1h").text(`${t1hValue}°`);
                        // 어제의 평균 기온을 가져오는 AJAX 호출 실행
                        getYesterdayAvgTa(t1hValue);
                        break;
                    }
                }
            });

        // 어제의 평균 기온을 가져오는 AJAX 호출
        function getYesterdayAvgTa(t1hValue) {
            $.getJSON("https://apis.data.go.kr/1360000/AsosDalyInfoService/getWthrDataList?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&dataCd=ASOS&dateCd=DAY&startDt=" + baseDateYesterday + "&endDt=" + baseDateYesterday + "&stnIds=108",
                function (data) {
                    console.log(data);
                    var yesterdayAvgTa = parseFloat(data.response.body.items.item[0].avgTa); // 어제의 평균 기온
                    console.log("어제 평균 기온: " + yesterdayAvgTa);
                    // 실황기온과 어제의 평균 기온을 비교하여 증감을 계산
                    var temperatureChange = parseFloat(t1hValue) - yesterdayAvgTa;
                    var temperatureChangeText = temperatureChange >= 0 ? "어제보다 " + temperatureChange.toFixed(1) + "°↑" : "어제보다 " + Math.abs(temperatureChange).toFixed(1) + "°↓";
                    $(".temperature-change").text(temperatureChangeText);
                });
        }

        // 날씨 흐림 비 맑음 등
        $.getJSON("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&base_date=" + baseDate + "&base_time=0500&nx=60&ny=127",
            function (data) {
                var items = data.response.body.items.item;
                var skyValue = null;
                var ptyValue = null;

                for (var i = 0; i < items.length; i++) {
                    var item = items[i];
                    if (item.category === 'SKY') {
                        switch (item.fcstValue) {
                            case '1':
                                skyValue = '맑음';
                                break;
                            case '3':
                                skyValue = '구름많음';
                                break;
                            case '4':
                                skyValue = '흐림';
                                break;
                        }
                    } else if (item.category === 'PTY') {
                        switch (item.fcstValue) {
                            case '0':
                                // PTY 값이 '없음'인 경우에는 skyValue를 사용
                                ptyValue = '없음';
                                break;
                            case '1':
                                ptyValue = '비';
                                break;
                            case '2':
                                ptyValue = '비/눈';
                                break;
                            case '3':
                                ptyValue = '눈';
                                break;
                            case '5':
                                ptyValue = '빗방울';
                                break;
                            case '6':
                                ptyValue = '빗방울눈날림';
                                break;
                            case '7':
                                ptyValue = '눈날림';
                                break;
                        }
                    }
                }

                let weatherInfo = ptyValue === '없음' ? skyValue : ptyValue;
                // /를 추가하여 표시
                $('.weather-info').text(weatherInfo);
            });


        //체감 온도
        const apiKey2 = "35751a4ab55af8aaee858624e4a8d31e";

        // 도시 정보
        const cities2 = [
            { name: "서울", latitude: "37.5665", longitude: "126.9780", containerId: "seoulWeather" },
            { name: "서울", latitude: "37.5665", longitude: "126.9780", containerId: "seoulWeather2" },
            { name: "부산", latitude: "35.1796", longitude: "129.0756", containerId: "busanWeather" },
            { name: "인천", latitude: "37.4563", longitude: "126.7052", containerId: "incheonWeather" },
            { name: "대구", latitude: "35.8714", longitude: "128.6014", containerId: "daeguWeather" },
            { name: "대전", latitude: "36.3504", longitude: "127.3845", containerId: "daejeonWeather" },
            { name: "광주", latitude: "35.1595", longitude: "126.8526", containerId: "gwangjuWeather" },
            { name: "울산", latitude: "35.5384", longitude: "129.3114", containerId: "ulsanWeather" },
            { name: "수원", latitude: "37.2636", longitude: "127.0286", containerId: "suwonWeather" },
            { name: "강릉", latitude: "37.7519", longitude: "128.8760", containerId: "gangneungWeather" },
            { name: "춘천", latitude: "37.8810", longitude: "127.7298", containerId: "chuncheonWeather" },
            { name: "울릉", latitude: "37.4847", longitude: "130.8988", containerId: "ulleungWeather" },
            { name: "청주", latitude: "36.6394", longitude: "127.4897", containerId: "cheongjuWeather" },
            { name: "안동", latitude: "36.5686", longitude: "128.7294", containerId: "andongWeather" },
            { name: "포항", latitude: "36.0198", longitude: "129.3700", containerId: "pohangWeather" },
            { name: "전주", latitude: "35.8242", longitude: "127.1470", containerId: "jeonjuWeather" },
            { name: "목포", latitude: "34.8128", longitude: "126.3945", containerId: "mokpoWeather" },
            { name: "여수", latitude: "34.7445", longitude: "127.7385", containerId: "yeosuWeather" },
            { name: "제주", latitude: "33.4996", longitude: "126.5312", containerId: "jejuWeather" }
        ];

        // 각 도시의 현재 날씨 정보를 가져오는 Promise를 만듦
        const currentWeatherPromises = cities2.map(city => {
            const apiUrl = `https://api.openweathermap.org/data/2.5/weather?lat=${city.latitude}&lon=${city.longitude}&appid=${apiKey2}&units=metric&lang=kr`;

            return fetch(apiUrl)
                .then(response => response.json())
                .then(data => {
                    const feelsLike = data.main.feels_like.toFixed(1); // 체감온도를 소수점 한 자리로 제한
                    const container = document.getElementById(city.containerId);
                    if (container) {
                        container.textContent = `${city.name}: 체감 ${feelsLike}°`;
                    }
                })
                .catch(error => {
                    console.error('Error fetching weather data:', error);
                    const container = document.getElementById(city.containerId);
                    if (container) {
                        container.textContent = `${city.name}: N/A`;
                    }
                });
        });

        // 결과를 HTML에 표시
        Promise.all(currentWeatherPromises)
            .then(() => {
                console.log('Weather data fetched and displayed.');
            });


        // 강수 습도
        $.getJSON("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=1000&dataType=JSON&base_date=" + baseDate + "&base_time=0600&nx=60&ny=127",
            function (data) {
                // 습도와 1시간 강수량 데이터 찾기
                var rehValue, rn1Value;
                data.response.body.items.item.forEach(function (item) {
                    if (item.category === "REH") {
                        rehValue = item.obsrValue + "%"; // 습도 값에 "%" 추가
                    } else if (item.category === "RN1") {
                        rn1Value = item.obsrValue + "mm"; // 강수량 값에 "mm" 추가
                    }
                });

                // 결과를 화면에 표시
                $(".result-reh").text("습도: " + rehValue);
                $(".result-rn1").text("강수: " + rn1Value);
            });


        //미세먼지 초미세먼지
        // 등급을 숫자에서 문자열로 변환하는 함수
        function convertUltrafineDustGrade(grade) {
            if (grade <= 25) return "좋음";
            else if (grade <= 50) return "보통";
            else if (grade <= 75) return "나쁨";
            else return "매우 나쁨";
        }

        function convertFineDustGrade(grade) {
            if (grade = 1) return "좋음";
            else if (grade = 2) return "보통";
            else if (grade = 3) return "나쁨";
            else return "매우 나쁨";
        }

        $.getJSON("https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&returnType=json&numOfRows=100&pageNo=1&sidoName=%EC%84%9C%EC%9A%B8&ver=1.7.2",
            function (data) {
                let item = data.response.body.items[0];

                // 등급 변환
                let ultrafineDustGrade = convertUltrafineDustGrade(parseInt(item.pm10Value));
                let fineDustGrade = convertFineDustGrade(item.pm10Grade1h);

                let content = "초미세먼지: " + ultrafineDustGrade;
                $('.resultUltrafineDust').text(content);

                let content2 = "미세먼지: " + fineDustGrade;
                $('.resultFineDust').text(content2);
            });

        // 오전 오후 기온
        $.getJSON("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=1000&dataType=JSON&base_date=" + baseDate+"&base_time=0630&nx=60&ny=127",
        function (data) {
            console.log(data);
            let morningTemp, afternoonTemp;

            // Loop through each item in the response
            data.response.body.items.item.forEach(function (item) {
                if (item.category === "T1H") {
                    if (item.fcstTime === "0700") {
                        morningTemp = item.fcstValue;
                    } else if (item.fcstTime === "1200") {
                        afternoonTemp = item.fcstValue;
                    }
                }
            });

            // Display the morning and afternoon temperatures
            $('#morningTemp').text("오전 기온: " + morningTemp + "℃");
            $('#afternoonTemp').text("오후 기온: " + afternoonTemp + "℃");
        });

        // 자외선
        // 등급을 숫자에서 문자열로 변환하는 함수
        function ultravioletRays(ultraviolet) {
            if (ultraviolet >= 0 && ultraviolet < 3) return "낮음";
            else if (ultraviolet >= 3 && ultraviolet < 6) return "보통";
            else if (ultraviolet >= 6 && ultraviolet < 8) return "높음";
            else if (ultraviolet >= 8 && ultraviolet < 10) return "매우높음";
            else if (ultraviolet >= 11) return "매우높음";
        }

        $.getJSON("https://apis.data.go.kr/1360000/LivingWthrIdxServiceV4/getUVIdxV4?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&areaNo=1100000000&time=" + baseDate,
            function (data) {
                console.log(data);

                console.log(data.response.header.resultCode);

                //                 단계	지수범위
                // 위험	11 이상
                // 매우높음	8~10
                // 높음	6~7
                // 보통	3~5
                // 낮음	0~2
                let item = data.response.header.resultCode;

                let ultraviolet = ultravioletRays(item);

                let content = "자외선: " + ultraviolet;
                $('.ultraviolet').text(content);
            });

        //일출 일몰
        class City {
            constructor(name, latitude, longitude, containerId) {
                this.name = name;
                this.latitude = latitude;
                this.longitude = longitude;
                this.containerId = containerId;
            }

            fetchAndPrintSunriseSunset(apiKey) {
                const apiUrl = `https://api.openweathermap.org/data/2.5/forecast?lat=${this.latitude}&lon=${this.longitude}&appid=${apiKey}&units=metric&lang=kr`;

                fetch(apiUrl)
                    .then(response => response.json())
                    .then(data => {
                        const sunriseTime = new Date(data.city.sunrise * 1000);
                        const sunsetTime = new Date(data.city.sunset * 1000);
                        const formatTime = time => {
                            const hours = time.getHours().toString().padStart(2, '0');
                            const minutes = time.getMinutes().toString().padStart(2, '0');
                            return `${hours}:${minutes}`;
                        };

                        const cityInfoContainer = document.getElementById(this.containerId);
                        const cityInfo = document.createElement("div");
                        cityInfo.classList.add("city-info");
                        cityInfo.innerHTML = `<p>${this.name} 일출 시간: ${formatTime(sunriseTime)}</p><p>${this.name} 일몰 시간: ${formatTime(sunsetTime)}</p>`;
                        cityInfoContainer.appendChild(cityInfo);
                    })
                    .catch(error => console.error(`${this.name}의 데이터를 불러오는 중 오류가 발생했습니다:`, error));
            }
        }

        const cities = [
            { name: "서울", latitude: "37.5665", longitude: "126.9780", containerId: "seoulInfo1" },
            { name: "서울", latitude: "37.5665", longitude: "126.9780", containerId: "seoulInfo2" },
            { name: "부산", latitude: "35.1796", longitude: "129.0756", containerId: "busanInfo1" },
            { name: "인천", latitude: "37.4563", longitude: "126.7052", containerId: "incheonInfo1" },
            { name: "대구", latitude: "35.8714", longitude: "128.6014", containerId: "daeguInfo1" },
            { name: "대전", latitude: "36.3504", longitude: "127.3845", containerId: "daejeonInfo1" },
            { name: "광주", latitude: "35.1595", longitude: "126.8526", containerId: "gwangjuInfo1" },
            { name: "울산", latitude: "35.5384", longitude: "129.3114", containerId: "ulsanInfo1" },
            { name: "수원", latitude: "37.2636", longitude: "127.0286", containerId: "suwonInfo1" },
            { name: "강릉", latitude: "37.7519", longitude: "128.8760", containerId: "gangneungInfo1" },
            { name: "춘천", latitude: "37.8810", longitude: "127.7298", containerId: "chuncheonInfo1" },
            { name: "울릉", latitude: "37.4847", longitude: "130.8988", containerId: "uljinInfo1" },
            { name: "청주", latitude: "36.6394", longitude: "127.4897", containerId: "cheongjuInfo1" },
            { name: "안동", latitude: "36.5686", longitude: "128.7294", containerId: "andongInfo1" },
            { name: "포항", latitude: "36.0198", longitude: "129.3700", containerId: "pohangInfo1" },
            { name: "전주", latitude: "35.8242", longitude: "127.1470", containerId: "jeonjuInfo1" },
            { name: "목포", latitude: "34.8128", longitude: "126.3945", containerId: "mokpoInfo1" },
            { name: "여수", latitude: "34.7445", longitude: "127.7385", containerId: "yeosuInfo1" },
            { name: "제주", latitude: "33.4996", longitude: "126.5312", containerId: "jejuInfo1" },
            { name: "부산", latitude: "35.1796", longitude: "129.0756", containerId: "busanInfo2" },
            { name: "인천", latitude: "37.4563", longitude: "126.7052", containerId: "incheonInfo2" },
            { name: "대구", latitude: "35.8714", longitude: "128.6014", containerId: "daeguInfo2" },
            { name: "대전", latitude: "36.3504", longitude: "127.3845", containerId: "daejeonInfo2" },
            { name: "광주", latitude: "35.1595", longitude: "126.8526", containerId: "gwangjuInfo2" },
            { name: "울산", latitude: "35.5384", longitude: "129.3114", containerId: "ulsanInfo2" },
            { name: "수원", latitude: "37.2636", longitude: "127.0286", containerId: "suwonInfo2" },
            { name: "강릉", latitude: "37.7519", longitude: "128.8760", containerId: "gangneungInfo2" },
            { name: "춘천", latitude: "37.8810", longitude: "127.7298", containerId: "chuncheonInfo2" },
            { name: "울릉", latitude: "37.4847", longitude: "130.8988", containerId: "uljinInfo2" },
            { name: "청주", latitude: "36.6394", longitude: "127.4897", containerId: "cheongjuInfo2" },
            { name: "안동", latitude: "36.5686", longitude: "128.7294", containerId: "andongInfo2" },
            { name: "포항", latitude: "36.0198", longitude: "129.3700", containerId: "pohangInfo2" },
            { name: "전주", latitude: "35.8242", longitude: "127.1470", containerId: "jeonjuInfo2" },
            { name: "목포", latitude: "34.8128", longitude: "126.3945", containerId: "mokpoInfo2" },
            { name: "여수", latitude: "34.7445", longitude: "127.7385", containerId: "yeosuInfo2" },
            { name: "제주", latitude: "33.4996", longitude: "126.5312", containerId: "jejuInfo2" }
            // 다른 도시들도 같은 방식으로 추가
        ];

        const apiKey = "35751a4ab55af8aaee858624e4a8d31e";

        cities.forEach(city => {
            const newCity = new City(city.name, city.latitude, city.longitude, city.containerId);
            newCity.fetchAndPrintSunriseSunset(apiKey);
        });




        //풍속 풍향
        $.getJSON("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&base_date=" + baseDate + "&base_time=0500&nx=60&ny=127",
            function (data) {
                console.log(data);

                const items = data.response.body.items.item;
                let vecValue, wsdValue;

                items.forEach(item => {
                    if (item.category === 'VEC') {
                        // 풍향 값 변환 함수
                        function convertWindDirection(deg) {
                            if (deg >= 0 && deg <= 45) return '북북동';
                            else if (deg > 45 && deg <= 90) return '북동';
                            else if (deg > 90 && deg <= 135) return '동동남';
                            else if (deg > 135 && deg <= 180) return '동남';
                            else if (deg > 180 && deg <= 225) return '남남서';
                            else if (deg > 225 && deg <= 270) return '남서';
                            else if (deg > 270 && deg <= 315) return '서서북';
                            else if (deg > 315 && deg <= 360) return '서북';
                            else return '알 수 없음';
                        }

                        vecValue = convertWindDirection(item.fcstValue);
                    } else if (item.category === 'WSD') {
                        wsdValue = item.fcstValue;
                    }
                });

                $(".result-vec").text(`풍향: ${vecValue}`);
                $(".result-wsd").text(`풍속: ${wsdValue} m/s`);
            });





    });
