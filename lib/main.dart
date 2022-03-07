import 'package:flutter/material.dart';
import 'package:untitled1/AppStates/ChatState.dart';
import 'package:untitled1/Pages/Components/BMITask/BMIApp.dart';
import 'package:untitled1/Pages/HomePage.dart';
import 'package:untitled1/Pages/LoginTask/LogInScreen.dart';
import 'package:untitled1/Pages/MessengerTask/MessengerHomeScreen.dart';

void main() => runApp(const BMIApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChatAppState();
}
