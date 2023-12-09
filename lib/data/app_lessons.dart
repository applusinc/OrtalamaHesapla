import 'package:flutter/material.dart';
import 'package:ortalamahesapla/model/lesson.dart';

class AppLessons {
  static List<Lesson> derslerList = [];

  static dersEkle(Lesson lesson) {
    derslerList.add(lesson);
  }

  static double ortalamaHesapla() {
    double toplamNot = 0;
    double toplamDersSaati = 0;
    derslerList.forEach((element) {
      toplamNot = toplamNot + (element.lessonScore * element.lessonHour);
      toplamDersSaati = toplamDersSaati + element.lessonHour;
    });
    return toplamNot / toplamDersSaati;
  }

  static List<String> lessonsList() {
    return ["Edebiyat", "Matematik", "Kimya", "Biyoloji", "Fizik"];
  }

  static List<String> lessonHoursList() {
    return ["1", "2", "3", "4", "5", "6", "7", "8"];
  }

  static List<DropdownMenuItem<String>> ddListItem() {
    return lessonsList()
        .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
        .toList();
  }

  static List<DropdownMenuItem<String>> dhListItem() {
    return lessonHoursList()
        .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
        .toList();
  }
}
