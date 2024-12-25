import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLanguageProvider extends ChangeNotifier{
  String appLanguage = 'en';

  void changeLanguage(String newLanguage){
    if (appLanguage == newLanguage){
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
}