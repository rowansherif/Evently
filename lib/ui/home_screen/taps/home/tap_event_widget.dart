import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class TapEventWidget extends StatelessWidget {
  String eventName;
  Color? borderColor;
  Color? boxColor;
  TextStyle? selectedTextStyle;
  TextStyle? unSelectedTextStyle;
  bool isSelected;

  TapEventWidget(
      {required this.eventName,
      required this.isSelected,
      this.borderColor,
      this.boxColor,
      this.selectedTextStyle,
      this.unSelectedTextStyle});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.005, horizontal: width * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? boxColor ?? AppColors.whiteColor
              : AppColors.transparentColor,
          border: Border.all(
            color: borderColor ?? AppColors.whiteColor,
            width: 1.5,
          )),
      child: Text(
        eventName,
        style: isSelected
            ? selectedTextStyle ?? AppStyles.medium16PrimaryLight
            : unSelectedTextStyle ?? AppStyles.medium16White,
      ),
    );
  }
}
