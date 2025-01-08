import 'package:events_app/firebase_utils.dart';
import 'package:events_app/model/event.dart';
import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/providers/event_list_provider.dart';
import 'package:events_app/ui/home_screen/add_event/custom_add_event_row.dart';
import 'package:events_app/ui/home_screen/taps/custom_elevated_button.dart';
import 'package:events_app/ui/home_screen/taps/custom_textfield.dart';
import 'package:events_app/ui/home_screen/taps/home/tap_event_widget.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = 'add_event_screen';

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime? selectedDate;

  String? formatedDate;

  String? selectedTime;

  String selectedEventName = '';
  String selectedImage = '';
  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
    List<String> eventImageList = [
      AssetsManager.sportImage,
      AssetsManager.birthdayImage,
      AssetsManager.meetingImage,
      AssetsManager.gamingImage,
      AssetsManager.workshopImage,
      AssetsManager.bookClubImage,
      AssetsManager.exhibitionImage,
      AssetsManager.holidayImage,
      AssetsManager.eatingImage
    ];
    selectedEventName = eventNameList[selectedIndex];
    selectedImage = eventImageList[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: AppColors.primaryLight,
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.createEvent,
            style: AppStyles.medium20PrimaryLight),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            spacing: height * 0.02,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  eventImageList[selectedIndex],
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
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: TapEventWidget(
                            eventName: eventNameList[index],
                            borderColor: AppColors.primaryLight,
                            boxColor: AppColors.primaryLight,
                            selectedTextStyle: AppStyles.bold16White,
                            unSelectedTextStyle: AppStyles.bold16PrimaryLight,
                            isSelected: selectedIndex == index ? true : false),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: width * 0.02,
                      );
                    },
                    itemCount: eventNameList.length),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    spacing: height * 0.02,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.title,
                        style: themeProvider.appTheme == ThemeMode.light
                            ? AppStyles.medium16Black
                            : AppStyles.medium16White,
                      ),
                      CustomTextfield(
                          controller: titleController,
                          validator: (text) {
                            if (text!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterEventTitle;
                            }
                            return null;
                          },
                          hintText: AppLocalizations.of(context)!.eventTitle,
                          prefixIcon: Image.asset(
                            AssetsManager.eventTitleIcon,
                            color: themeProvider.appTheme == ThemeMode.light
                                ? AppColors.greyColor
                                : AppColors.whiteColor,
                          )),
                      Text(
                        AppLocalizations.of(context)!.description,
                        style: themeProvider.appTheme == ThemeMode.light
                            ? AppStyles.medium16Black
                            : AppStyles.medium16White,
                      ),
                      CustomTextfield(
                        controller: descriptionController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterEventDescription;
                          }
                          return null;
                        },
                        hintText:
                            AppLocalizations.of(context)!.eventDescription,
                        maxLines: 4,
                      ),
                      CustomAddEventRow(
                          eventNameOrTime:
                              AppLocalizations.of(context)!.eventDate,
                          iconName: AssetsManager.calenderIcon,
                          chooseDateOrTime: selectedDate == null
                              ? AppLocalizations.of(context)!.chooseDate
                              : DateFormat('dd/MM/yyyy').format(selectedDate!),
                          onChooseDateOrTime: onChooseDate),
                      CustomAddEventRow(
                          eventNameOrTime:
                              AppLocalizations.of(context)!.eventTime,
                          iconName: AssetsManager.timeIcon,
                          chooseDateOrTime: selectedTime == null
                              ? AppLocalizations.of(context)!.chooseTme
                              : selectedTime!,
                          onChooseDateOrTime: onChooseTime),
                      Text(
                        AppLocalizations.of(context)!.location,
                        style: themeProvider.appTheme == ThemeMode.light
                            ? AppStyles.medium16Black
                            : AppStyles.medium16White,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.01, horizontal: width * 0.02),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: AppColors.primaryLight, width: 1.5)),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.01),
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
                              AppLocalizations.of(context)!.chooseEventLocation,
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
                      CustomElevatedButton(
                          buttonOnClick: onAddEvent,
                          buttonColor: AppColors.primaryLight,
                          buttonTitle: AppLocalizations.of(context)!.addEvent),
                      SizedBox(
                        height: height * 0.02,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void onChooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chooseDate;
    setState(() {});
  }

  void onChooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime!.format(context);
    setState(() {});
  }

  onAddEvent() {
    // if(selectedTime == null || selectedDate == null){
    //   //selectedDate = 'please enter date';
    //   selectedTime = 'please enter Time';
    //   setState(() {
    //   });
    // }
    if (formKey.currentState!.validate() == true) {
      //TODO: Add Event
      Event event = Event(
          eventName: selectedEventName,
          image: selectedImage,
          title: titleController.text,
          description: descriptionController.text,
          dateTime: selectedDate!,
          time: selectedTime!);
      FirebaseUtils.addEventToFireStore(event)
          .timeout(Duration(microseconds: 500), onTimeout: () {
        print("event added successfully");
        //TODO: refresh eventList
        eventListProvider.showAllEvents();
        Navigator.pop(context);
      });
    }
  }
}
