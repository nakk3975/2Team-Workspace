package com.weather.finedust.controller;
public class AirGradeCalculator {

    public static String calculateSO2Grade(double value) {
        if (value <= 0.020) {
            return "좋음";
        } else if (value <= 0.050) {
            return "보통";
        } else if (value <= 0.150) {
            return "나쁨";
        } else {
            return "매우나쁨";
        }
    }

    public static String calculateCOGrade(double value) {
        if (value <= 2.00) {
            return "좋음";
        } else if (value <= 9.00) {
            return "보통";
        } else if (value <= 15.00) {
            return "나쁨";
        } else {
            return "매우나쁨";
        }
    }

    public static String calculateNO2Grade(double value) {
        if (value <= 0.030) {
            return "좋음";
        } else if (value <= 0.060) {
            return "보통";
        } else if (value <= 0.200) {
            return "나쁨";
        } else {
            return "매우나쁨";
        }
    }

    public static String calculateO3Grade(double value) {
        if (value <= 0.030) {
            return "좋음";
        } else if (value <= 0.090) {
            return "보통";
        } else if (value <= 0.150) {
            return "나쁨";
        } else {
            return "매우나쁨";
        }
    }

    public static String calculatePM10Grade(double value) {
        if (value <= 30) {
            return "좋음";
        } else if (value <= 80) {
            return "보통";
        } else if (value <= 150) {
            return "나쁨";
        } else {
            return "매우나쁨";
        }
    }

    public static String calculatePM25Grade(double value) {
        if (value <= 15) {
            return "좋음";
        } else if (value <= 35) {
            return "보통";
        } else if (value <= 75) {
            return "나쁨";
        } else {
            return "매우나쁨";
        }
    }

    public static String calculateKHAIGrade(double value) {
        if (value <= 50) {
            return "좋음";
        } else if (value <= 100) {
            return "보통";
        } else if (value <= 250) {
            return "나쁨";
        } else {
            return "매우나쁨";
        }
    }
}