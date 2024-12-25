import 'package:events_app/ui/auth/login_screen.dart';
import 'package:events_app/ui/home_screen/home_screen.dart';
import 'package:events_app/ui/home_screen/taps/custom_elevated_button.dart';
import 'package:events_app/ui/home_screen/taps/custom_textfield.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateAccountScreen extends StatelessWidget {
  static const String routeName = 'Create_account_screen';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppStyles.medium20NavyBlack,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
        child: Column(
          spacing: height * 0.02,
          children: [
            Image.asset(
              AssetsManager.logo,
              height: height * 0.25,
            ),
            CustomTextfield(
              hintText: AppLocalizations.of(context)!.name,
              prefixIcon: ImageIcon(
                AssetImage(AssetsManager.userNameIcon),
                color: AppColors.greyColor,
              ),
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
            CustomTextfield(
                hintText: AppLocalizations.of(context)!.confirmPassword,
                obscureText: true,
                prefixIcon: ImageIcon(
                  AssetImage(AssetsManager.passwordIcon),
                  color: AppColors.greyColor,
                ),
                suffixIcon: ImageIcon(
                  AssetImage(AssetsManager.showPasswordIcon),
                  color: AppColors.greyColor,
                )),
            CustomElevatedButton(
              buttonOnClick: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
              buttonTitle: AppLocalizations.of(context)!.createAccount,
              buttonColor: AppColors.primaryLight,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              },
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: AppLocalizations.of(context)!.alreadyHaveAccount,
                    style: AppStyles.medium16Black),
                TextSpan(
                    text: AppLocalizations.of(context)!.login,
                    style: AppStyles.boldItalic16PrimaryLight.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.primaryLight))
              ])),
            ),
          ],
        ),
      ),
    );
  }
}
