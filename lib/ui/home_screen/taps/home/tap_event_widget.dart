import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class TapEventWidget extends StatelessWidget {
  String eventName;
  bool isSelected;
  TapEventWidget({required this.eventName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: height * 0.005, horizontal: width * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? AppColors.whiteColor : AppColors.transparentColor,
      ),
      child: Text(eventName,
      style: isSelected ? AppStyles.medium16PrimaryLight : AppStyles.medium16White,),
    );
  }
}
