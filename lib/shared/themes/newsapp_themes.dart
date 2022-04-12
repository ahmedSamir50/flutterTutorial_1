import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

var darkThemeMainColor = HexColor('333739');

ThemeData getAppNormalTheme() {
  return ThemeData(
      // used by Theme.of(context).textTheme.bodyText1
      textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87)),
      primarySwatch: Colors.deepOrange,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black87, size: 40),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              systemNavigationBarColor: Colors.black,
              systemNavigationBarDividerColor: Colors.red),
          backgroundColor: Colors.white70,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 40,
          showSelectedLabels: true,
          selectedIconTheme: IconThemeData(color: Colors.deepOrange),
          selectedItemColor: Colors.deepOrange,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.white));
}

ThemeData getAppDarkThem() {
  return ThemeData(
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
    scaffoldBackgroundColor: HexColor('333739'),
    primarySwatch: Colors.deepOrange,
    backgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white, size: 40),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: darkThemeMainColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            systemNavigationBarDividerColor: Colors.red),
        backgroundColor: Colors.black54,
        elevation: 0,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black87,
        elevation: 40,
        showSelectedLabels: true,
        selectedIconTheme: IconThemeData(color: Colors.deepOrange),
        selectedItemColor: Colors.deepOrange,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white),
  );
}
