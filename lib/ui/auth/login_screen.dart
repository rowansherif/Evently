import 'package:events_app/firebase_utils.dart';
import 'package:events_app/model/my_user.dart';
import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/providers/event_list_provider.dart';
import 'package:events_app/providers/user_provider.dart';
import 'package:events_app/ui/auth/create_account_screen.dart';
import 'package:events_app/ui/auth/forget_password_screen.dart';
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
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: 'rowan@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  late EventListProvider eventListProvider;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Form(
          key: formKey,
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
                  buttonOnClick: signInWithGoogle,
                  buttonTitle: AppLocalizations.of(context)!.loginWithGoogle,
                  buttonColor: AppColors.transparentColor,
                  buttonTitleStyle: AppStyles.medium20PrimaryLight,
                  buttonIcon: Image.asset(AssetsManager.googleIcon))
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      //TODO: Show loading
      DialogUtils.showLoading(context: context, msg: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUserData(user);
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        print('login successfully');
        print(credential.user?.uid ?? '');
        //TODO: hide loading
        DialogUtils.hideLoading(context);
        //TODO: show message  (Login successfully)
        DialogUtils.showMessage(
            context: context,
            msg: 'Login successfully',
            title: 'Login',
            posActionName: 'Ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          print('Wrong E-mail or Password');
          //TODO: hide loading
          DialogUtils.hideLoading(context);
          //TODO: show message  (error message)
          DialogUtils.showMessage(
              context: context,
              msg: 'Wrong E-mail or Password',
              title: 'Error',
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
            msg: e.toString(),
            title: 'Error',
            posActionName: 'Ok');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    //TODO: show loading
    DialogUtils.showLoading(context: context, msg: 'Loading...');
    final credentials =
        await FirebaseAuth.instance.signInWithCredential(credential);
    MyUser myUser = MyUser(
        id: credentials.user?.uid ?? '',
        name: credentials.user?.displayName ?? '',
        email: credentials.user?.email ?? '');
    FirebaseUtils.addUserToFireStore(myUser);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.updateUserData(myUser);
    print('signed in successfully');
    //TODO: hide loading
    DialogUtils.hideLoading(context);
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}
