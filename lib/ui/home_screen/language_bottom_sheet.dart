import 'package:events_app/providers/app_language_provider.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
              languageProvider.changeLanguage('en');
            },
            child: languageProvider.appLanguage == 'en'?
            Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.english,
                style: AppStyles.bold20PrimaryLight,),
                Icon(Icons.check,
                color: AppColors.primaryLight,),
              ],
            ):
            Text(AppLocalizations.of(context)!.english,
              style: AppStyles.bold20black,)
    ),

          SizedBox(height: height * 0.02,),
          InkWell(
            onTap: (){
              languageProvider.changeLanguage('ar');
            },
            child: languageProvider.appLanguage == 'ar'?
            Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.arabic,
                  style: AppStyles.bold20PrimaryLight,),
                Icon(Icons.check,
                  color: AppColors.primaryLight,),
              ],
            ):
               Text(AppLocalizations.of(context)!.arabic,
            style: AppStyles.bold20black,),
          ),
        ],
      ),
    );
  }
}
