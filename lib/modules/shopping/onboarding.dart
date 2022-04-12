import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_tutorial_learn1/shared/helpers/helpers.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageView.builder(itemBuilder: (context , idx ){
            return buildBoardingItem(idx);
          },itemCount: 3,)
        ],
      ),
    );
  }
  Widget buildBoardingItem(int idx){
    String imgPath = "images/onboardingInit${idx}.png";
    printOnyOnDebugMode([imgPath]);
    var column = Column(
        children: [
          Expanded(child: Image(image: AssetImage("images/onboardingInit${idx}.png"),fit:BoxFit.cover ),),
          SizedBox(height: 20,),
          Text("Screen Title " , style: TextStyle(fontSize: 24.0 , fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Text("Screen Title " , style: TextStyle(fontSize: 24.0 , fontWeight: FontWeight.bold),),
        ]
    );
    return column;
  }
}
