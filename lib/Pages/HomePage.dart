import 'package:flutter/material.dart';
import 'package:untitled1/Pages/Components/AppBar.Components/MyAppBarActions.dart';
import 'package:untitled1/Pages/Components/Bodys/MessengerBody.dart';
import 'package:untitled1/Pages/Components/MyAppBar.dart';
import 'package:untitled1/Pages/MyAppBody.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(
            leading:  const Icon(Icons.menu),
            title:  const Text("App Title ....."),

            barActions:  MyAppBarActions.getAppBarActions()),
        body: MessengerBody.getMessengerBody(context)
      );
}
