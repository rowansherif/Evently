import 'package:events_app/utils/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMsg {
  static Future<bool?> toastMsg({required String msg}) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.greenColor,
        textColor: AppColors.blackColor,
        fontSize: 16.0);
  }
}
