// script.js 파일에 저장
const provinceSelect = document.getElementById('province');
const citySelect = document.getElementById('city');
const resultDiv = document.getElementById('resultValue');
const generateResultButton = document.getElementById('generateResult');

const citiesByProvince = {
    '서울특별시': ['강남구', '강서구', '관악구'],
    '경기도': ['수원시', '성남시', '용인시']
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
                    tmn_today[date] = value;
                }
                // 카테고리가 'TMX' (최고 기온)인 경우
                else if (item.category == "TMX") {
                    tmx_today[date] = value;
                }
            } else if (date === getDayAfterTomorrow()) {
                // 카테고리가 'TMN' (최저 기온)인 경우
                if (item.category == "TMN") {
                    tmn_dayAfterTomorrow[date] = value;
                }
                // 카테고리가 'TMX' (최고 기온)인 경우
                else if (item.category == "TMX") {
                    tmx_dayAfterTomorrow[date] = value;
                }
            }
        });

        // tmn_today과 tmx_today에 저장된 값을 결과에 표시
        $.each(tmn_today, function (date, value) {
            let content = "내일 " + baseDateTomorrow + "<br>" + " 최저 기온: " + value + " 최고 기온: " + tmx_today[date];
            $('#results1').append('<p>' + content + '</p>');
        });

        // tmn_dayAfterTomorrow과 tmx_dayAfterTomorrow에 저장된 값을 결과에 표시
        $.each(tmn_dayAfterTomorrow, function (date, value) {
            let content = baseDateAfterTomorrow + "<br>" + value + "°C / " + tmx_dayAfterTomorrow[date] + "°C";
            $('#results2').append('<p>' + content + '</p>');
        });



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

        $.getJSON("https://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa?serviceKey=SK%2BPRcZcmwLI1Ay0iY4upnwt8YM36JwLQ9lNFQebeaz7yXOCb0BmR6HdvFQgBR7YrCPgf%2FDfscztrpYzGxoc1g%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&regId=11B10101&tmFc=202404020600",
            function (data) {
                console.log(data);

                let item = data.response.body.items.item[0];

                let content = baseDateThreeDay + "  " + item.taMin3 + "°/" + item.taMax3 + "°";
                $('#results3').text(content);

                let content2 = baseDateFourDay + "  " + item.taMin4 + "°/" + item.taMax4 + "°";
                $('#results4').text(content2);
                let content3 = baseDateFiveDay + "  " + item.taMin5 + "°/" + item.taMax5 + "°";
                $('#results5').text(content3);
                let content4 = baseDateSixDay + "  " + item.taMin6 + "°/" + item.taMax6 + "°";
                $('#results6').text(content4);
                let content5 = baseDateSevenDay + "  " + item.taMin7 + "°/" + item.taMax7 + "°";
                $('#results7').text(content5);
                let content6 = baseDateEightDay + " " + item.taMin8 + "°/" + item.taMax8 + "°";
                $('#results8').text(content6);
                let content7 = baseDateNineDay + "  " + item.taMin9 + "°/" + item.taMax9 + "°";
                $('#results9').text(content7);
                let content8 = baseDateTenDay + "  " + item.taMin10 + "°/" + item.taMax10 + "°";
                $('#results10').text(content8);

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




    });
