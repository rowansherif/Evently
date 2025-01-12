import 'package:events_app/model/event.dart';
import 'package:events_app/providers/event_list_provider.dart';
import 'package:events_app/providers/user_provider.dart';
import 'package:events_app/ui/home_screen/add_event/custom_add_event_row.dart';
import 'package:events_app/ui/home_screen/taps/custom_elevated_button.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_theme_provider.dart';
import '../taps/custom_textfield.dart';
import '../taps/home/tap_event_widget.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = 'Edit_event_screen';

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  @override
  Widget build(BuildContext context) {
    Event args = ModalRoute.of(context)!.settings.arguments as Event;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    List<String> eventNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    // List<String> eventImageList = [
    //   AssetsManager.sportImage,
    //   AssetsManager.birthdayImage,
    //   AssetsManager.meetingImage,
    //   AssetsManager.gamingImage,
    //   AssetsManager.workshopImage,
    //   AssetsManager.bookClubImage,
    //   AssetsManager.exhibitionImage,
    //   AssetsManager.holidayImage,
    //   AssetsManager.eatingImage
    // ];
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: AppColors.primaryLight,
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.editEvent,
            style: AppStyles.medium20PrimaryLight),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.02),
        child: SingleChildScrollView(
          child: Column(spacing: height * 0.02, children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                args.image,
                // eventImageList[eventListProvider.selectedIndex],
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: height * 0.04,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        eventListProvider.changeSelectedIndex(
                            index, userProvider.currentUser!.id);
                      },
                      child: TapEventWidget(
                          eventName: eventNameList[index],
                          borderColor: AppColors.primaryLight,
                          boxColor: AppColors.primaryLight,
                          selectedTextStyle: AppStyles.bold16White,
                          unSelectedTextStyle: AppStyles.bold16PrimaryLight,
                          isSelected: eventListProvider.selectedIndex == index
                              ? true
                              : false),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: width * 0.02,
                    );
                  },
                  itemCount: eventNameList.length),
            ),
          ]),
        ),
      ),
    );
  }
}
