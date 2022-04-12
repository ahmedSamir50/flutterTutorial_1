import 'package:flutter/material.dart';
import 'package:my_flutter_tutorial_learn1/main.dart';
import 'package:my_flutter_tutorial_learn1/modules/messenger/MessengerHomeScreen.dart';

class ChatAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MessengerHomeScreen(),
    );
  }
}
