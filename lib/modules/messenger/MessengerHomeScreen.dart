import 'package:flutter/material.dart';
import 'package:untitled1/modules/messenger/MessengerAppBar.dart';
import 'package:untitled1/modules/messenger/MessengerBody.dart';

class MessengerHomeScreen extends StatelessWidget{

  const MessengerHomeScreen( {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context)  => Scaffold(
      backgroundColor: Colors.black,
      body: MessengerBody.getMessengerBody( context),
      appBar:MessengerAppBar.getMessengerAppBar()
    );

}