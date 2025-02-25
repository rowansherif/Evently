import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/providers/event_list_provider.dart';
import 'package:events_app/ui/auth/login/login_screen.dart';
import 'package:events_app/ui/auth/register/register_navigator.dart';
import 'package:events_app/ui/auth/register/register_view_model.dart';
import 'package:events_app/ui/home_screen/home_screen.dart';
import 'package:events_app/ui/home_screen/taps/custom_elevated_button.dart';
import 'package:events_app/ui/home_screen/taps/custom_textfield.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:events_app/utils/dialog_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Create_account_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  var nameController = TextEditingController(text: 'Rowan');
  var emailController = TextEditingController(text: 'rowan@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var confirmPasswordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  late EventListProvider eventListProvider;

  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
          child: Form(
            key: formKey,
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
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: ImageIcon(
                    AssetImage(AssetsManager.userNameIcon),
                    color: themeProvider.appTheme == ThemeMode.light
                        ? AppColors.greyColor
                        : AppColors.whiteColor,
                  ),
                ),
                CustomTextfield(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter E-mail';
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if (!emailValid) {
                      return 'Please Enter Valid E-mail';
                    }
                    return null;
                  },
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: ImageIcon(
                    AssetImage(AssetsManager.emailIcon),
                    color: themeProvider.appTheme == ThemeMode.light
                        ? AppColors.greyColor
                        : AppColors.whiteColor,
                  ),
                ),
                CustomTextfield(
                    controller: passwordController,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Password';
                      }
                      if (text.length < 6) {
                        return 'Password should be at least 6 chars';
                      }
                      return null;
                    },
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
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Password';
                      }
                      if (text.length < 6) {
                        return 'Password should be at least 6 chars';
                      }
                      if (text != passwordController.text) {
                        return "Confirm Password doesn't the Password";
                      }
                      return null;
                    },
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
        ),
      ),
    );
  }

  void createAccount() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.register(emailController.text, passwordController.text);
    }
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    DialogUtils.hideLoading(context);
  }

  @override
  void showMyLoading(String msg) {
    // TODO: implement showMyLoading
    DialogUtils.showLoading(context: context, msg: msg);
  }

  @override
  void showMyMessage(String msg) {
    // TODO: implement showMyMessage
    DialogUtils.showMessage(
        context: context,
        msg: msg,
        posActionName: msg == 'Register successfully' ? 'ok' : null,
        posAction: posActionFunction,
        title: msg == 'Register successfully' ? 'Register' : 'Error');
  }

  @override
  void posActionFunction() {
    // TODO: implement posActionFunction
    Navigator.pushNamed(context, HomeScreen.routeName);
  }
}
