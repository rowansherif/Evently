import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/providers/event_list_provider.dart';
import 'package:events_app/ui/home_screen/taps/custom_textfield.dart';
import 'package:events_app/ui/home_screen/taps/home/event_item_widget.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoveTap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // if(eventListProvider.favouriteList.isEmpty){
    //   eventListProvider.showFavouriteList();
    //   }
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Column(
          children: [
            CustomTextfield(hintText: AppLocalizations.of(context)!.searchForEvent,
            prefixIcon: ImageIcon(AssetImage(AssetsManager.searchIcon),color: AppColors.primaryLight,),
            borderColor: AppColors.primaryLight,
            hintStyle: AppStyles.medium16PrimaryLight,),
            Expanded(
              child: eventListProvider.favouriteList.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.noFavouriteEvent,
                        style: themeProvider.appTheme == ThemeMode.light
                            ? AppStyles.medium16Black
                            : AppStyles.medium16White,
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      itemBuilder: (context, index) {
                        return EventItemWidget(
                          event: eventListProvider.favouriteList[index],
                        );
                      },
                  separatorBuilder: (context, index){
                    return SizedBox(height: height * 0.02,);
                  },
                      itemCount: eventListProvider.favouriteList.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
