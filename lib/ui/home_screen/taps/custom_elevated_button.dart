import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  Function buttonOnClick;
  String buttonTitle;
  Widget? buttonIcon;
  Color buttonColor;

  CustomElevatedButton(
      {required this.buttonOnClick,
      required this.buttonTitle,
      this.buttonIcon,
      this.buttonColor = AppColors.transparentColor});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                // side: BorderSide(
                //
                // )
            )),
        onPressed: () {
          buttonOnClick();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonIcon ?? SizedBox(),
            SizedBox(width: width * 0.02,),
            Text(buttonTitle,
            style: AppStyles.medium20White,),
          ],
        ));
  }
}
