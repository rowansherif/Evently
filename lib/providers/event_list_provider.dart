import 'package:events_app/firebase_utils.dart';
import 'package:events_app/model/event.dart';
import 'package:events_app/utils/flutter_toast.dart';
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

  void showAllEvents(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventCollection(uId).get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filteredEventList = eventList;

    filteredEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void showFilteredEventList(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventCollection(uId).get();
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

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? showAllEvents(uId) : showFilteredEventList(uId);
  }

  void updateIsFavourite(Event event, String uId) {
    FirebaseUtils.getEventCollection(uId)
        .doc(event.id)
        .update({'isFavourite': !event.isFavourite}).then((value) {
      ToastMsg.toastMsg(msg: 'Event Updated Successfully');
      selectedIndex == 0 ? showAllEvents(uId) : showFilteredEventList(uId);
      showFavouriteList(uId);
    }).timeout(Duration(milliseconds: 500), onTimeout: () {
      ToastMsg.toastMsg(msg: 'Event Updated Successfully');
      selectedIndex == 0 ? showAllEvents(uId) : showFilteredEventList(uId);
      showFavouriteList(uId);
    });
  }

  Future<void> showFavouriteList(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventCollection(uId)
        .where('isFavourite', isEqualTo: true)
        .orderBy('dateTime', descending: false)
        .get();

    favouriteList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    notifyListeners();
  }

  Future<void> deleteEvent(String uId, Event event) {
    return FirebaseUtils.getEventCollection(uId)
        .doc(event.id)
        .delete()
        .then((value) {
      print('event deleted successfully');
      ToastMsg.toastMsg(msg: 'Event Deleted Successfully');
      selectedIndex == 0 ? showAllEvents(uId) : showFilteredEventList(uId);
      showFavouriteList(uId);
      notifyListeners();
    });
  }

  Future<void> updateEventDetails(String uId, Event event) {
    return FirebaseUtils.getEventCollection(uId).doc(event.id).update({
      'eventName': event.eventName,
      'image': event.image,
      'title': event.title,
      'description': event.description,
      'dateTime': event.dateTime,
      'time': event.time
    }).then((value) {
      print('Event Updated Successfully');
      ToastMsg.toastMsg(msg: 'Event Updated Successfully');
      selectedIndex == 0 ? showAllEvents(uId) : showFilteredEventList(uId);
      showFavouriteList(uId);
      notifyListeners();
    });
  }
}
