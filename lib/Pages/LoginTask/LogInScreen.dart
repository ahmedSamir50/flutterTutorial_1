import 'package:flutter/material.dart';
import 'package:untitled1/Pages/Components/AppBar.Components/MyAppBarActions.dart';
import 'package:untitled1/Pages/Components/Bodys/LoginScreenBody.dart';
import 'package:untitled1/Pages/Components/MyAppBar.dart';

class LogInScreen extends StatelessWidget{
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: MyAppBar(
         leading:  const Icon(Icons.menu),
         title: const Text("App Login Simple ....."),
         barActions: MyAppBarActions.getAppBarActions()),
     body: LoginScreenBody.getLoginScreenBody(),
   );
  }

}