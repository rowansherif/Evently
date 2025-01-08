import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAddEventRow extends StatelessWidget {
  String eventNameOrTime;
  String iconName;
  String chooseDateOrTime;
  Function onChooseDateOrTime;

  CustomAddEventRow(
      {required this.eventNameOrTime,
      required this.iconName,
      required this.chooseDateOrTime,
      required this.onChooseDateOrTime});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Row(
      children: [
        ImageIcon(
          AssetImage(iconName),
          color: themeProvider.appTheme == ThemeMode.light
              ? AppColors.blackColor
              : AppColors.whiteColor,
        ),
        SizedBox(
          width: width * 0.02,
        ),
        Text(
          eventNameOrTime,
          style: themeProvider.appTheme == ThemeMode.light
              ? AppStyles.medium16Black
              : AppStyles.medium16White,
        ),
        Spacer(),
        TextButton(
            onPressed: () {
              onChooseDateOrTime();
            },
            child: Text(
              chooseDateOrTime,
              style: AppStyles.medium20PrimaryLight,
            ))
      ],
    );
  }
}
