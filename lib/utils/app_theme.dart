import 'package:events_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLight,
    ),
    scaffoldBackgroundColor: AppColors.whiteColor,
  );
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryDark,
    ),
    scaffoldBackgroundColor: AppColors.primaryDark,
  );
}