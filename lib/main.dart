import 'package:flutter/material.dart';
import 'package:untitled1/layout/news_app/news_app_layout.dart';
import 'package:untitled1/models/ChatState.dart';
import 'package:untitled1/modules/modules_navegator/modules_switching.dart';
import 'package:untitled1/shared/dependency_injection.dart';


void main() {
  /*
  DI().setup();
  runApp( NewsAppLayout());
   */
  runApp(const ModulesSwitcher());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChatAppState();
}
