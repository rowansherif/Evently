import 'package:events_app/model/event.dart';
import 'package:events_app/providers/event_list_provider.dart';
import 'package:events_app/providers/user_provider.dart';
import 'package:events_app/ui/home_screen/event_details/event_details_screen.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItemWidget extends StatefulWidget {
  Event event;

  EventItemWidget({required this.event});

  @override
  State<EventItemWidget> createState() => _EventItemWidgetState();
}

class _EventItemWidgetState extends State<EventItemWidget> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var userProvider = Provider.of<UserProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(EventDetailsScreen.routeName, arguments: widget.event);
      },
      child: Container(
        height: height * 0.3,
        padding: EdgeInsets.symmetric(
            vertical: height * 0.015, horizontal: width * 0.03),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primaryLight,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(widget.event.image), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.001, horizontal: width * 0.014),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Text(
                    widget.event.dateTime.day.toString(),
                    style: AppStyles.bold20PrimaryLight,
                  ),
                  Text(
                    DateFormat('MMM').format(widget.event.dateTime),
                    style: AppStyles.bold20PrimaryLight,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.01, horizontal: width * 0.01),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    widget.event.title,
                    style: AppStyles.bold14black,
                  )),
                  InkWell(
                    onTap: () {
                      eventListProvider.updateIsFavourite(
                          widget.event, userProvider.currentUser!.id);
                      //eventListProvider.changeIsFavourite(widget.event);
                    },
                    child: widget.event.isFavourite == true
                        ? ImageIcon(
                            AssetImage(AssetsManager.favouriteIconSelected),
                            color: AppColors.primaryLight,
                          )
                        : ImageIcon(
                            AssetImage(AssetsManager.favouriteIconUnselected),
                            color: AppColors.primaryLight,
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
