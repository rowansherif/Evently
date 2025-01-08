import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/ui/auth/create_account_screen.dart';
import 'package:events_app/ui/auth/forget_password_screen.dart';
import 'package:events_app/ui/home_screen/taps/custom_elevated_button.dart';
import 'package:events_app/ui/home_screen/taps/custom_textfield.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
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
              themeProvider.appTheme == ThemeMode.light
                  ? AssetsManager.lightLogo
                  : AssetsManager.darkLogo,
              height: height * 0.25,
            ),
            CustomTextfield(
              hintText: AppLocalizations.of(context)!.email,
              prefixIcon: ImageIcon(
                AssetImage(AssetsManager.emailIcon),
                color: themeProvider.appTheme == ThemeMode.light
                    ? AppColors.greyColor
                    : AppColors.whiteColor,
              ),
            ),
            CustomTextfield(
                hintText: AppLocalizations.of(context)!.password,
                obscureText: true,
                prefixIcon: ImageIcon(
                  AssetImage(AssetsManager.passwordIcon),
                  color: themeProvider.appTheme == ThemeMode.light
                      ? AppColors.greyColor
                      : AppColors.whiteColor,
                ),
                suffixIcon: ImageIcon(
                  AssetImage(AssetsManager.showPasswordIcon),
                  color: themeProvider.appTheme == ThemeMode.light
                      ? AppColors.greyColor
                      : AppColors.whiteColor,
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ForgetPasswordScreen.routeName);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassword,
                    textAlign: TextAlign.end,
                    style: AppStyles.boldItalic16PrimaryLight.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryLight,
                        color: AppColors.primaryLight),
                  ),
                )),
            CustomElevatedButton(
              buttonOnClick: login,
              buttonTitle: AppLocalizations.of(context)!.login,
              buttonColor: AppColors.primaryLight,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: AppLocalizations.of(context)!.doNotHaveAccount,
                  style: themeProvider.appTheme == ThemeMode.light
                      ? AppStyles.medium16Black
                      : AppStyles.medium16White),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context)
                          .pushNamed(CreateAccountScreen.routeName);
                    },
                  text: AppLocalizations.of(context)!.createAccount,
                  style: AppStyles.boldItalic16PrimaryLight.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryLight,
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

  void login() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routeName, (Route<dynamic> route) => false);
  }
}
