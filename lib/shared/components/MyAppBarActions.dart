import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyAppBarActions {
  static List<Widget> getAppBarActions() => [
        const IconButton(
            icon: Icon(Icons.notification_important),
            onPressed: _onNotificationBtnCallBack),
        const IconButton(
            icon: Icon(Icons.search), onPressed: _onSearchBtnCallBack),
      ];

  static _onNotificationBtnCallBack() {
    if (kDebugMode) {
      print("notification BTN Clicked .....");
    }
  }

  static _onSearchBtnCallBack() async {
    if (kDebugMode) {
      print("Search BTN Clicked .....");
    }
  }
}
