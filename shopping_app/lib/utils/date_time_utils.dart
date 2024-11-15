import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeUtils {
  static const String format_DD_MM_YYYY = 'dd-MM-yyyy';
  static const String format_YYYY_MM_dd = 'yyyy-MM-dd';
  static const String format_HHmm = 'HH:mm';
  static List monthsTh = ["ม.ค.", "ก.พ.", "มี.ค.", "เม.ย.", "พ.ค.", "มิ.ย.", "ก.ค.", "ส.ค.", "ก.ย.", "ต.ค.", "พ.ย.", "ธ.ค."];
  static List monthsEn = ["Jan", "Feb", "Mar", "Apr", "May ", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  static String parseDateToString(DateTime? dateTime, String format) {
    String date = "";
    if (dateTime != null) {
      try {
        // Set locale using Easy Localization context
        date = DateFormat(format, Get.context?.locale.languageCode).format(dateTime);
      } on FormatException {}
    }
    return date;
  }

  static String parseDateToStringEn(DateTime? dateTime, String format) {
    String date = "";
    if (dateTime != null) {
      try {
        // Set locale using Easy Localization context
        date = DateFormat(format, 'en').format(dateTime);
      } on FormatException {}
    }
    return date;
  }

  static String parseDateToStringTh(DateTime? dateTime, String format) {
    String date = "";
    if (dateTime != null) {
      try {
        // Set locale using Easy Localization context
        date = DateFormat(format, 'th').format(dateTime);

        List<String> dateList = date.split(" ");
        date = "${dateList[0]} ${dateList[1]} ${int.parse(dateList[2]) + 543}";
      } on FormatException {}
    }

    return date;
  }

  static DateTime parseStringToDate(String date, String format) {
    DateTime dateTime = DateTime.now();
    try {
      // Set locale using Easy Localization context
      dateTime = DateFormat(format, Get.context?.locale.languageCode).parse(date);
    } on FormatException {}
    return dateTime;
  }

  static bool isToday(DateTime dateTime) {
    var now = DateTime.now();
    return dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day;
  }

  static String getLastDateOfYear({required BuildContext context}) {
    DateTime now = DateTime.now();
    DateTime lastDate = DateTime(now.year + 1, 1, 0);

    return dateToDateThai(context: context, dateTime: lastDate);
  }

  static String dateToDateThai({required BuildContext context, required DateTime dateTime}) {
    int date = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;

    List<dynamic> months = context.locale.languageCode == 'en' ? monthsEn : monthsTh;
    int years = context.locale.languageCode == 'en' ? year : year + 543;

    return "$date ${months[month - 1]} $years";
  }
}
