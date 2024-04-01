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
