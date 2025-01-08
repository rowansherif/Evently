import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/ui/auth/login_screen.dart';
import 'package:events_app/ui/home_screen/home_screen.dart';
import 'package:events_app/ui/home_screen/taps/custom_elevated_button.dart';
import 'package:events_app/ui/home_screen/taps/custom_textfield.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String routeName = 'Create_account_screen';

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: themeProvider.appTheme == ThemeMode.light
              ? AppColors.navyBlackColor
              : AppColors.whiteColor,
        ),
        title: Text(
          AppLocalizations.of(context)!.register,
          style: themeProvider.appTheme == ThemeMode.light
              ? AppStyles.medium20NavyBlack
              : AppStyles.medium20White,
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
              themeProvider.appTheme == ThemeMode.light
                  ? AssetsManager.lightLogo
                  : AssetsManager.darkLogo,
              height: height * 0.25,
            ),
            CustomTextfield(
              hintText: AppLocalizations.of(context)!.name,
              prefixIcon: ImageIcon(
                AssetImage(AssetsManager.userNameIcon),
                color: themeProvider.appTheme == ThemeMode.light
                    ? AppColors.greyColor
                    : AppColors.whiteColor,
              ),
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
            CustomTextfield(
                hintText: AppLocalizations.of(context)!.confirmPassword,
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
            CustomElevatedButton(
              buttonOnClick: createAccount,
              buttonTitle: AppLocalizations.of(context)!.createAccount,
              buttonColor: AppColors.primaryLight,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: AppLocalizations.of(context)!.alreadyHaveAccount,
                  style: themeProvider.appTheme == ThemeMode.light
                      ? AppStyles.medium16Black
                      : AppStyles.medium16White),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                  text: AppLocalizations.of(context)!.login,
                  style: AppStyles.boldItalic16PrimaryLight.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryLight,
                      color: AppColors.primaryLight))
            ])),
          ],
        ),
      ),
    );
  }

  void createAccount() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routeName, (Route<dynamic> route) => false);
  }
}
