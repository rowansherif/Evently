import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class EventItemWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.3,
      padding: EdgeInsets.symmetric(vertical: height * 0.015, horizontal:  width * 0.03),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryLight,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(AssetsManager.birthdayEventBg),fit: BoxFit.fill)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: height * 0.001, horizontal: width* 0.014),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              children: [
                Text('22', style:  AppStyles.bold20PrimaryLight,),
                Text('NOV', style:  AppStyles.bold20PrimaryLight,),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width *0.01),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('This is a Birthday Party ',style: AppStyles.bold14black,)),
                ImageIcon(AssetImage(AssetsManager.favouriteIconSelected),
                color:  AppColors.primaryLight,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
