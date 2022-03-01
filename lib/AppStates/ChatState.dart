import 'package:flutter/material.dart';
import 'package:untitled1/Pages/MessengerTask/MessengerHomeScreen.dart';
import 'package:untitled1/main.dart';

class ChatAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MessengerHomeScreen(),
    );
  }
}