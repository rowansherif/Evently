import 'package:events_app/firebase_utils.dart';
import 'package:events_app/model/my_user.dart';
import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/providers/event_list_provider.dart';
import 'package:events_app/providers/user_provider.dart';
import 'package:events_app/ui/auth/login_screen.dart';
import 'package:events_app/ui/home_screen/home_screen.dart';
import 'package:events_app/ui/home_screen/taps/custom_elevated_button.dart';
import 'package:events_app/ui/home_screen/taps/custom_textfield.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:events_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  var nameController = TextEditingController(text: 'Rowan');
  var emailController = TextEditingController(text: 'rowan@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var confirmPasswordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  late EventListProvider eventListProvider;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
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
    );
  }

  void createAccount() async {
    if (formKey.currentState?.validate() == true) {
      //TODO: show loading
      DialogUtils.showLoading(context: context, msg: 'Loading...');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUserData(myUser);
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        await FirebaseUtils.addUserToFireStore(myUser);
        //TODO: hide loading
        DialogUtils.hideLoading(context);
        //TODO: show message  (Register successfully)
        DialogUtils.showMessage(
            context: context,
            msg: 'Register successfully',
            posActionName: 'Ok',
            title: 'Register',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          //TODO: hide loading
          DialogUtils.hideLoading(context);
          //TODO: show message  (error message)
          DialogUtils.showMessage(
              context: context,
              title: 'Error',
              msg: 'The password provided is too weak.',
              posActionName: 'Ok');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          //TODO: hide loading
          DialogUtils.hideLoading(context);
          //TODO: show message  (error message)
          DialogUtils.showMessage(
              context: context,
              title: 'Error',
              msg: 'The account already exists for that email.',
              posActionName: 'Ok');
        } else if (e.code == 'network-request-failed') {
          print('No Internet Connection');
          //TODO: hide loading
          DialogUtils.hideLoading(context);
          //TODO: show message  (error message)
          DialogUtils.showMessage(
              context: context,
              msg: 'No Internet Connection',
              title: 'Error',
              posActionName: 'Ok');
        }
      } catch (e) {
        print(e.toString());
        //TODO: hide loading
        DialogUtils.hideLoading(context);
        //TODO: show message  (error message)
        DialogUtils.showMessage(
            context: context,
            title: 'Error',
            msg: e.toString(),
            posActionName: 'Ok');
      }
    }
  }
}
