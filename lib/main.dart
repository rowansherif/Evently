import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/providers/app_language_provider.dart';
import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/providers/event_list_provider.dart';
import 'package:events_app/ui/auth/create_account_screen.dart';
import 'package:events_app/ui/auth/forget_password_screen.dart';
import 'package:events_app/ui/auth/login_screen.dart';
import 'package:events_app/ui/home_screen/add_event/add_event_screen.dart';
import 'package:events_app/ui/home_screen/home_screen.dart';
import 'package:events_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context)=> AppLanguageProvider()),
      ChangeNotifierProvider(create: (context) => AppThemeProvider()),
    ChangeNotifierProvider(create: (context) => EventListProvider())
  ],
      child: MyApp()));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName : (context) => HomeScreen(),
        CreateAccountScreen.routeName: (context) => CreateAccountScreen(),
        ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
        AddEventScreen.routeName: (context) => AddEventScreen()
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      locale: Locale(languageProvider.appLanguage),
    );
  }
}