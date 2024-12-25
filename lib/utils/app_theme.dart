import 'package:events_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
      elevation: 0,
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: AppColors.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            color: AppColors.whiteColor,
            width: 4,
          )
        )),
    scaffoldBackgroundColor: AppColors.whiteColor,
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryDark,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
      elevation: 0
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: AppColors.primaryDark,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(
                  color: AppColors.whiteColor,
                  width: 4,
                )
            )),
    scaffoldBackgroundColor: AppColors.primaryDark,
  );
}
