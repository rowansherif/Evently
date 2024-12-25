import 'package:events_app/ui/home_screen/taps/custom_elevated_button.dart';
import 'package:events_app/ui/home_screen/taps/custom_textfield.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login_screen';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: height * 0.02,
          children: [
            Image.asset(
              AssetsManager.logo,
              height: height * 0.25,
            ),
            CustomTextfield(
              hintText: AppLocalizations.of(context)!.email,
              prefixIcon: ImageIcon(
                AssetImage(AssetsManager.emailIcon),
                color: AppColors.greyColor,
              ),
            ),
            CustomTextfield(
                hintText: AppLocalizations.of(context)!.password,
                obscureText: true,
                prefixIcon: ImageIcon(
                  AssetImage(AssetsManager.passwordIcon),
                  color: AppColors.greyColor,
                ),
                suffixIcon: ImageIcon(
                  AssetImage(AssetsManager.showPasswordIcon),
                  color: AppColors.greyColor,
                )),
            TextButton(
                onPressed: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassword,
                    textAlign: TextAlign.end,
                    style: AppStyles.boldItalic16PrimaryLight.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.primaryLight),
                  ),
                )),
            CustomElevatedButton(
              buttonOnClick: () {
                //Navigator.of(context).pushReplacement(HomeScreen.routeName);
              },
              buttonTitle: AppLocalizations.of(context)!.login,
              buttonColor: AppColors.primaryLight,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: AppLocalizations.of(context)!.doNotHaveAccount,
                  style: AppStyles.medium16Black),
              TextSpan(
                  text: AppLocalizations.of(context)!.createAccount,
                  style: AppStyles.boldItalic16PrimaryLight.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryLight))
            ])),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    indent: 20,
                    endIndent: 20,
                    color: AppColors.primaryLight,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.or,
                  style: AppStyles.medium16PrimaryLight,
                ),
                Expanded(
                  child: Divider(
                    indent: 20,
                    endIndent: 20,
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
            CustomElevatedButton(
                buttonOnClick: () {},
                buttonTitle: AppLocalizations.of(context)!.loginWithGoogle,
                buttonColor: AppColors.transparentColor,
                buttonTitleStyle: AppStyles.medium20PrimaryLight,
                buttonIcon: Image.asset(AssetsManager.googleIcon))
          ],
        ),
      ),
    );
  }
}
