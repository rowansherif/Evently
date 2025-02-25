import 'package:events_app/providers/app_language_provider.dart';
import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/providers/event_list_provider.dart';
import 'package:events_app/providers/user_provider.dart';
import 'package:events_app/ui/auth/forget_password_screen.dart';
import 'package:events_app/ui/auth/login/login_screen.dart';
import 'package:events_app/ui/auth/register/register_screen.dart';
import 'package:events_app/ui/home_screen/add_event/add_event_screen.dart';
import 'package:events_app/ui/home_screen/edit_event/edit_event_screen.dart';
import 'package:events_app/ui/home_screen/event_details/event_details_screen.dart';
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
  //await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
    ChangeNotifierProvider(create: (context) => AppThemeProvider()),
    ChangeNotifierProvider(create: (context) => EventListProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider())
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
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
        AddEventScreen.routeName: (context) => AddEventScreen(),
        EventDetailsScreen.routeName: (context) => EventDetailsScreen(),
        EditEventScreen.routeName: (context) => EditEventScreen()
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