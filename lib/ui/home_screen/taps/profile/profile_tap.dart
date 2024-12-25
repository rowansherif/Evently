import 'package:events_app/providers/app_language_provider.dart';
import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/ui/home_screen/language_bottom_sheet.dart';
import 'package:events_app/ui/home_screen/theme_bottom_sheet.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfileTap extends StatefulWidget {
  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height*0.20,
        shape: RoundedRectangleBorder(
          borderRadius: languageProvider.appLanguage == 'en'?
          BorderRadius.only(bottomLeft: Radius.circular(80))
              :
          BorderRadius.only(bottomRight:  Radius.circular(80))
        ),
        title: Row(
          children: [
            Transform.flip(
              child: Image.asset(
                AssetsManager.routeImage,
              ),
            ),
            SizedBox(width: width*0.02,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Route Academy',
                style: AppStyles.bold24White,),
                SizedBox(width: width*0.02,),
                Text('route@gmail.com',style: AppStyles.medium16White,)
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: themeProvider.appTheme == ThemeMode.dark?
              AppStyles.bold20White:
              AppStyles.bold20black,
            ),
            SizedBox(height: height * 0.02,),
            InkWell(
              onTap: (){
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context){
                      return LanguageBottomSheet();
                    });
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primaryLight,
                    width: 2
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(languageProvider.appLanguage == 'en'?
                      AppLocalizations.of(context)!.english
                    :
                    AppLocalizations.of(context)!.arabic,
                    style: AppStyles.bold20PrimaryLight,),
                    Icon(Icons.arrow_drop_down,
                      color: AppColors.primaryLight,
                    size: 30,)
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02,),

            Text(
              AppLocalizations.of(context)!.theme,
              style:  themeProvider.appTheme == ThemeMode.dark?
              AppStyles.bold20White:
              AppStyles.bold20black,
            ),
            SizedBox(height: height * 0.02,),
            InkWell(
              onTap: (){
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context){
                      return ThemeBottomSheet();
                    });
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppColors.primaryLight,
                        width: 2
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(themeProvider.appTheme == ThemeMode.dark?
                      AppLocalizations.of(context)!.dark
                      :
                      AppLocalizations.of(context)!.light,
                      style: AppStyles.bold20PrimaryLight,),
                    Icon(Icons.arrow_drop_down,
                    color: AppColors.primaryLight,
                    size: 30,)
                  ],
                ),
              ),
            ),
            SizedBox(height: height* 0.26,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              onPressed: (){},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: height * 0.015),
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Row(
                  spacing: width * 0.02,
                  children: [
                    ImageIcon(AssetImage(AssetsManager.logoutIcon),
                    size: 24,
                    color: AppColors.whiteColor,),
                    Text(AppLocalizations.of(context)!.logout,
                    style: AppStyles.regular20White,)
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

}
