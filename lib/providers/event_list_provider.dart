import 'package:events_app/firebase_utils.dart';
import 'package:events_app/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<String> eventNameList = [];
  List<Event> filteredEventList = [];
  List<Event> favouriteList = [];
  int selectedIndex = 0;

  void getEventNameList(BuildContext context) {
    eventNameList = [
      AppLocalizations.of(context)!.all,
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
  }

  void showAllEvents() async {
    var querySnapshot = await FirebaseUtils.getEventCollection().get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filteredEventList = eventList;

    filteredEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void showFilteredEventList() async {
    var querySnapshot = await FirebaseUtils.getEventCollection().get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    filteredEventList = eventList.where((event) {
      return event.eventName == eventNameList[selectedIndex];
    }).toList();

    filteredEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  // void showFilteredEventList1()async{
  //   var querySnapshot = await FirebaseUtils.getEventCollection().
  //       where('eventName',isEqualTo: eventNameList[selectedIndex]).
  //   orderBy('dateTime',descending: false).get();
  //   filteredEventList = querySnapshot.docs.map((doc){
  //     return doc.data();
  //   }).toList();
  //
  //   notifyListeners();
  // }

  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? showAllEvents() : showFilteredEventList();
  }

  void updateIsFavourite(Event event) {
    if (event.isFavourite == false) {
      FirebaseUtils.getEventCollection()
          .doc(event.id)
          .update({'isFavourite': true});
    } else {
      FirebaseUtils.getEventCollection()
          .doc(event.id)
          .update({'isFavourite': false});
    }
    selectedIndex == 0 ? showAllEvents() : showFilteredEventList();
    showFavouriteList();
  }

  Future<void> showFavouriteList() async {
    var querySnapshot = await FirebaseUtils.getEventCollection()
        .where('isFavourite', isEqualTo: true)
        .orderBy('dateTime', descending: false)
        .get();

    favouriteList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    notifyListeners();
  }
}
