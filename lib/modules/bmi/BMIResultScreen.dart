import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/BIMStateModel.dart';

@immutable
class BMIResultsScreen extends StatelessWidget {
  final BMIStateModel model;

  const BMIResultsScreen(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: const EdgeInsets.all(40),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text(model.clientGender.toString())),
            Expanded(child: Text(model.clientHeight.toString())),
            Expanded(child: Text(model.clientWight.toString())),
            Expanded(child: Text(model.clientBMI().toString())),
            Expanded(child: Text(model.bmiState())),
          ],
        ),
      ),
      appBar: AppBar(
          title: const Text(" RESULTS "),
          leading: IconButton(
            icon: const Icon(Icons.backpack),
            onPressed: () => Navigator.pop(context),
          )),
    );
  }
}
