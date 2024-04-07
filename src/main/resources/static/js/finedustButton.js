function changeContent(option) {
    var imgSrc, newText;

    if (option === 'yesterdayAm10') {
    newText = '어제 오전 미세먼지'; 
    imgSrc = yesterdayAm10; 
} else if (option === 'todayAm10'){
    newText = '오늘 오전 미세먼지'; // 오늘에 해당하는 텍스트
    imgSrc = todayAm10; // 오늘 이미지를 받아올 API URL
} else if (option === 'tomorrowAm10'){
    newText = '내일 오전 미세먼지';
    imgSrc = tomorrowAm10;
} else if (option === 'yesterdayPm10') {
    newText = '어제 오후 미세먼지'; 
    imgSrc = yesterdayPm10; 
} else if (option === 'todayPm10'){
    newText = '오늘 오후 미세먼지'; 
    imgSrc = todayPm10;
} else if (option === 'tomorrowPm10'){
    newText = '내일 오후 미세먼지';
    imgSrc = tomorrowPm10;
} else if (option === 'yesterdayAm25') {
    newText = '어제 오전 초미세먼지'; 
    imgSrc = yesterdayAm25; 
} else if (option === 'todayAm25'){
    newText = '오늘 오전 초미세먼지';
    imgSrc = todayAm25;
} else if (option === 'tomorrowAm25'){
    newText = '내일 오전 초미세먼지';
    imgSrc = tomorrowAm25;
} else if (option === 'yesterdayPm25') {
    newText = '어제 오후 초미세먼지'; 
    imgSrc = yesterdayPm25; 
} else if (option === 'todayPm25'){
    newText = '오늘 오후 초미세먼지';
    imgSrc = todayPm25;
} else if (option === 'tomorrowPm25'){
    newText = '내일 오후 초미세먼지';
    imgSrc = tomorrowPm25;
}

    var img = new Image();
    img.onload = function() {
        document.getElementById("outputImage").src = imgSrc;
    };
    img.src = imgSrc;

    document.getElementById("outputText").innerHTML = newText;
}