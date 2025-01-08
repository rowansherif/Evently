import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/ui/home_screen/taps/custom_textfield.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../home_screen/taps/custom_elevated_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = 'forget_password_screen';

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: themeProvider.appTheme == ThemeMode.light
              ? AppColors.navyBlackColor
              : AppColors.whiteColor,
        ),
        title: Text(
          AppLocalizations.of(context)!.forgetPassword,
          style: themeProvider.appTheme == ThemeMode.light
              ? AppStyles.medium20NavyBlack
              : AppStyles.medium20White,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.02),
        child: Column(
          spacing: height * 0.03,
          children: [
            Image.asset(AssetsManager.forgetPasswordScreenImage),
            CustomTextfield(
              hintText: AppLocalizations.of(context)!.email,
              prefixIcon: ImageIcon(
                AssetImage(AssetsManager.emailIcon),
                color: themeProvider.appTheme == ThemeMode.light
                    ? AppColors.greyColor
                    : AppColors.whiteColor,
              ),
            ),
            CustomElevatedButton(
              buttonOnClick: () {},
              buttonTitle: AppLocalizations.of(context)!.resetPassword,
              buttonColor: AppColors.primaryLight,
            ),
          ],
        ),
      ),
    );
  }
}
