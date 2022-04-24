import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar(
      {required Widget leading,
      Widget? title,
      required List<Widget> barActions,
      double? elevation,
      Color? barColor,
      double? titleSpacing,
      Key? key})
      : super(
            titleSpacing: titleSpacing,
            key: key,
            leading: leading,
            title: title,
            centerTitle: true,
            backgroundColor: barColor ?? Colors.blue,
            elevation: elevation ?? 5.0,
            actions: barActions);
}
