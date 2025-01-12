import 'package:events_app/model/my_user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  updateUserData(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
