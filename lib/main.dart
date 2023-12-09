import 'package:flutter/material.dart';
import 'package:ortalamahesapla/constants/app_colors.dart';
import 'package:ortalamahesapla/views/calculate_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ortalama Hesapla",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColors.primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: CalculateView(),
    );
  }
}
