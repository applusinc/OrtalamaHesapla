import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ortalamahesapla/constants/app_colors.dart';

class AppFonts {
  static final TextStyle titleFont = GoogleFonts.quicksand(
   fontSize: 24,
   fontWeight: FontWeight.w900, 
   color: AppColors.primaryColor);

   static final TextStyle normalTextFont = GoogleFonts.quicksand(
   fontSize: 16,
   fontWeight: FontWeight.w600, 
   color: AppColors.primaryColor);

   static final TextStyle bigTextFont = GoogleFonts.quicksand(
   fontSize: 55,
   fontWeight: FontWeight.w600, 
   color: AppColors.primaryColor);
}
