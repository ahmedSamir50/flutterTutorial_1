import 'package:flutter/material.dart';
import 'package:untitled1/models/ChatState.dart';
import 'package:untitled1/modules/modules_navegator/modules_switching.dart';

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
