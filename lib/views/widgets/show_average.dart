import 'package:flutter/material.dart';
import 'package:ortalamahesapla/constants/app_fonts.dart';

class ShowAverage extends StatelessWidget {
  final double ortalama;
  final int lessonNum;
  const ShowAverage({required this.lessonNum, required this.ortalama, key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          lessonNum > 0 ? "$lessonNum Ders" : "Ders Seçiniz",
          style: AppFonts.normalTextFont,
        ),
        Text(
          ortalama > 0 ? "${ortalama.toStringAsFixed(1)}" : "0.0",
          style: AppFonts.bigTextFont,
        ),
        Text(
          "Ortalama",
          style: AppFonts.normalTextFont,
        )
      ],
    );
  }
}
