import 'package:flutter/material.dart';
import 'package:my_flutter_tutorial_learn1/models/ChatState.dart';
import 'package:my_flutter_tutorial_learn1/modules/modules_navegator/modules_switching.dart';

void main() {
  /*
  DI().setup();
  runApp( NewsAppLayout());
   */
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ModulesSwitcher());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChatAppState();
}