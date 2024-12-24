import 'package:events_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle bold24White = GoogleFonts.inter(
      fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.whiteColor);
  static TextStyle medium16White = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w500, color:  AppColors.whiteColor);
  static TextStyle bold20black = GoogleFonts.inter(
    fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blackColor);
  static TextStyle bold20White = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.whiteColor);
  static TextStyle bold20Primary = GoogleFonts.inter(
    fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryLight);
  static TextStyle bold12White = GoogleFonts.inter(
    fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.whiteColor
  );
}
