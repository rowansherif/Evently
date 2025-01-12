import 'package:events_app/model/event.dart';
import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/providers/event_list_provider.dart';
import 'package:events_app/providers/user_provider.dart';
import 'package:events_app/ui/home_screen/edit_event/edit_event_screen.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = 'event_details_screen';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    Event args = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text(
          AppLocalizations.of(context)!.eventDetails,
          style: AppStyles.medium20PrimaryLight,
        ),
        centerTitle: true,
        actions: [
          Row(
            spacing: width * 0.03,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(EditEventScreen.routeName, arguments: args);
                  },
                  child: ImageIcon(
                    AssetImage(AssetsManager.editingIcon),
                    color: AppColors.primaryLight,
                  )),
              InkWell(
                  onTap: () {
                    eventListProvider.deleteEvent(
                        userProvider.currentUser!.id, args);
                    Navigator.pop(context);
                  },
                  child: ImageIcon(
                    AssetImage(AssetsManager.deleteIcon),
                    color: AppColors.redColor,
                  ))
            ],
          ),
          SizedBox(
            width: width * 0.02,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: height * 0.015,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  args.image,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                args.title,
                style: AppStyles.medium24PrimaryLight,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.01, horizontal: width * 0.02),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primaryLight, width: 1.5)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02, vertical: height * 0.01),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ImageIcon(
                        AssetImage(AssetsManager.calenderIcon),
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${args.dateTime.day} ${DateFormat('MMMM').format(args.dateTime)} ${args.dateTime.year}',
                          style: AppStyles.medium16PrimaryLight,
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                          args.time,
                          style: themeProvider.appTheme == ThemeMode.light
                              ? AppStyles.medium16Black
                              : AppStyles.medium16White,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.01, horizontal: width * 0.02),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primaryLight, width: 1.5)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02, vertical: height * 0.01),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ImageIcon(
                        AssetImage(AssetsManager.locationIcon),
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      'Cairo, Egypt',
                      style: AppStyles.medium16PrimaryLight,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primaryLight,
                    )
                  ],
                ),
              ),
              Text(
                AppLocalizations.of(context)!.description,
                style: themeProvider.appTheme == ThemeMode.light
                    ? AppStyles.medium16Black
                    : AppStyles.medium16White,
              ),
              Text(
                args.description,
                style: themeProvider.appTheme == ThemeMode.light
                    ? AppStyles.medium16Black
                    : AppStyles.medium16White,
              )
            ],
          ),
        ),
      ),
    );
  }
}
