import 'package:flutter/material.dart';
import 'package:untitled1/Models/UserInChatModel.dart';
import 'package:untitled1/Pages/Components/AppBar.Components/MessengerAppBar.dart';
import 'package:untitled1/Pages/Components/AppBar.Components/MyAppBarActions.dart';
import 'package:untitled1/Pages/Components/Bodys/MessengerBody.dart';
import 'package:untitled1/Pages/Components/MyAppBar.dart';

class MessengerHomeScreen extends StatelessWidget{

  const MessengerHomeScreen( {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context)  => Scaffold(
      backgroundColor: Colors.black,
      body: MessengerBody.getMessengerBody( context),
      appBar:MessengerAppBar.getMessengerAppBar()
    );

}