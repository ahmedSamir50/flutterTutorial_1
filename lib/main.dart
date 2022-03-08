import 'package:flutter/material.dart';
import 'package:untitled1/models/ChatState.dart';
import 'package:untitled1/modules/bmi/BMIApp.dart';

void main() => runApp(const BMIApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChatAppState();
}
