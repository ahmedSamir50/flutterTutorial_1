import 'package:flutter/material.dart';
import 'package:untitled1/shared/components/MyAppBarActions.dart';
import 'package:untitled1/modules/messenger/MessengerBody.dart';
import 'package:untitled1/shared/components/MyAppBar.dart';

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
