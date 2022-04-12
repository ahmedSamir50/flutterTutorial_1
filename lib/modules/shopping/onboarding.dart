import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: AssetImage("assets/images/onboardingInit1.png")),
          SizedBox(height: 20,),
          Text("Screen Title " , style: TextStyle(fontSize: 24.0 , fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Text("Screen Title " , style: TextStyle(fontSize: 24.0 , fontWeight: FontWeight.bold),),
/*
          PageView.builder(itemBuilder: (context , idx ){

          })

 */
        ],
      ),
    );
  }
}
