import 'package:flutter/material.dart';
import 'package:untitled1/layout/todoapp_bottom_nav/todo_app_home_layout.dart';
import 'package:untitled1/models/ChatState.dart';

void main() => runApp(TodoHomeLayOut());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChatAppState();
}
