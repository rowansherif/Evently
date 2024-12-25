import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  Function buttonOnClick;
  String buttonTitle;
  Widget? buttonIcon;
  Color buttonColor;
  TextStyle? buttonTitleStyle;

  CustomElevatedButton(
      {required this.buttonOnClick,
      required this.buttonTitle,
      this.buttonTitleStyle,
      this.buttonIcon,
      this.buttonColor = AppColors.transparentColor});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: AppColors.primaryLight, width: 1.5))),
        onPressed: () {
          buttonOnClick();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonIcon ?? SizedBox(),
              SizedBox(
                width: width * 0.02,
              ),
              Text(
                buttonTitle,
                style: buttonTitleStyle ?? AppStyles.medium20White,
              ),
            ],
          ),
        ));
  }
}
