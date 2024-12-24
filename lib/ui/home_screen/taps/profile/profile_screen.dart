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

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    // List<String> languageItems = [
    //   AppLocalizations.of(context)!.english,
    //   AppLocalizations.of(context)!.arabic
    // ];
    // String selectedLanguage = languageItems[0];
    //
    // List<String> themeItems = [
    //   AppLocalizations.of(context)!.light,
    //   AppLocalizations.of(context)!.dark
    // ];
    // String selectedTheme = themeItems[0];
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
            Image.asset(AssetsManager.routeImage),
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
        padding: const EdgeInsets.all(16),
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
                    style: AppStyles.bold20Primary,),
                    Icon(Icons.arrow_drop_down,
                      color: AppColors.primaryLight,
                    size: 30,)
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02,),
            // DropdownButton(
            //     isExpanded: true,
            //     items: languageItems.map((String item){
            //       return DropdownMenuItem(
            //         value: item,
            //           child: Text(item,
            //           style: AppStyles.bold20black,));
            //     }).toList(),
            //     value: selectedLanguage,
            //     onChanged: (value){
            //       setState(() {
            //         selectedLanguage = value!;
            //       });
            //     }),
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
                      style: AppStyles.bold20Primary,),
                    Icon(Icons.arrow_drop_down,
                    color: AppColors.primaryLight,
                    size: 30,)
                  ],
                ),
              ),
            ),

            // DropdownButton(
            //     isExpanded: true,
            //     items: themeItems.map((String item){
            //       return DropdownMenuItem(
            //           value: item,
            //           child: Text(item,
            //             style: AppStyles.bold20black,));
            //     }).toList(),
            //     value: selectedTheme,
            //     onChanged: (String? value){
            //       setState(() {
            //         selectedTheme = value!;
            //       });
            //     }),
          ],
        ),
      ),
    );
  }

}
