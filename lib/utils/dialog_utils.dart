import 'package:events_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context, required String msg}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 8,
                ),
                Text(msg)
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showMessage(
      {required BuildContext context,
        required String msg,
        String title = '',
        String? posActionName,
        String? negActionName,
        Function? posAction,
        Function? negAction}) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: AppStyles.medium16Black,
          )));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: AppStyles.medium16Black,
          )));
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: AppStyles.medium16Black,
            ),
            content: Text(
              msg,
            ),
            actions: actions,
          );
        });
  }
}
