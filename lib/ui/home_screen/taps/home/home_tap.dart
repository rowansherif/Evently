import 'package:events_app/providers/app_language_provider.dart';
import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/providers/event_list_provider.dart';
import 'package:events_app/providers/user_provider.dart';
import 'package:events_app/ui/home_screen/taps/home/event_item_widget.dart';
import 'package:events_app/ui/home_screen/taps/home/tap_event_widget.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeTap extends StatefulWidget {
  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    eventListProvider.getEventNameList(context);

    if (eventListProvider.eventList.isEmpty) {
      eventListProvider.showAllEvents(userProvider.currentUser!.id);
    }
    return Scaffold(
      appBar: AppBar(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(50)
        // ),
        //toolbarHeight: height * 0.2,

        backgroundColor: AppColors.primaryLight,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.welcomeBack,
              style: AppStyles.regular14White,
            ),
            Text(
              'user name',
              //userProvider.currentUser!.name,
              style: AppStyles.bold24White,
            )
          ],
        ),
        actions: [
          Icon(
            Icons.sunny,
            color: AppColors.whiteColor,
            size: 24,
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.01, horizontal: width * 0.02),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              appLanguageProvider.appLanguage.toUpperCase(),
              style: AppStyles.bold14PrimaryLight,
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.01),
            height: height * 0.13,
            decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: Column(
              children: [
                Row(
                  spacing: width * 0.01,
                  children: [
                    ImageIcon(
                      AssetImage(AssetsManager.mapIconUnselected),
                      color: AppColors.whiteColor,
                    ),
                    Text(
                      'Cairo , Egypt',
                      style: AppStyles.medium14White,
                    )
                  ],
                ),
                DefaultTabController(
                    length: eventListProvider.eventNameList.length,
                    child: TabBar(
                      onTap: (index) {
                        eventListProvider.changeSelectedIndex(
                            index, userProvider.currentUser!.id);
                      },
                      isScrollable: true,
                      indicatorColor: AppColors.transparentColor,
                      dividerColor: AppColors.transparentColor,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.symmetric(
                          horizontal: width * 0.01, vertical: height * 0.02),
                      tabs: eventListProvider.eventNameList.map((eventName) {
                        return TapEventWidget(
                            eventName: eventName,
                            isSelected: eventListProvider.selectedIndex ==
                                eventListProvider.eventNameList
                                    .indexOf(eventName));
                      }).toList(),
                    )),
              ],
            ),
          ),
          Expanded(
            child: eventListProvider.filteredEventList.isEmpty
                ? Center(
                    child: Text(
                    AppLocalizations.of(context)!.noEvents,
                    style: themeProvider.appTheme == ThemeMode.light
                        ? AppStyles.medium16Black
                        : AppStyles.medium16White,
                  ))
                : ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: height * 0.02,horizontal: width * 0.02),
                itemBuilder: (context, index){
                      return EventItemWidget(
                        event: eventListProvider.filteredEventList[index],
                      );
                    },
                separatorBuilder: (context, index){
                  return SizedBox(height: height * 0.02,);
                },
                    itemCount: eventListProvider.filteredEventList.length),
          )
        ],
      ),

    );
  }
}
