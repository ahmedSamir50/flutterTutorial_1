

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/todo_model.dart';

Widget defaultTextInput({
  bool isObscureText = false,
  required TextEditingController fromController ,
  Function(String)? onFieldSubmit,
  Function(String)? onChange ,
  String? Function(String?)? validationCallBack,
  required TextInputType keyboardType,
  String label ="Text Field",
  required String hint ,
  IconData prefixIcon = Icons.edit,
  IconData? suffixIcon,
  VoidCallback? suffixPressed ,
  VoidCallback? onTap,
})=> TextFormField(
  obscureText: isObscureText,
  controller: fromController,
  onFieldSubmitted:onFieldSubmit,
  onChanged: onChange,
  keyboardType: keyboardType,
  validator: validationCallBack,
  onTap: onTap,
  decoration: InputDecoration(
      hintText: label,
      labelText:hint,
      prefixIcon:  Icon( prefixIcon),
      suffixIcon:  suffixIcon!=null?
                   IconButton(icon:Icon(suffixIcon) , onPressed: suffixPressed)
                    :null,
      border: const OutlineInputBorder()
  ),
);

Widget todoModelWidgetBuilder(TODOModel model) {
  var x = Row(
    children: [
      CircleAvatar(child:
      Text(model.timeOfCreation,style: TextStyle(color: Colors.white),),
          radius: 40 ,
          backgroundColor: Colors.blueAccent),
      const SizedBox(width: 10),
      Expanded(child:
      Column(children: [
        Text(model.title,textAlign: TextAlign.left,),
        Text(model.timeOfCreation,style: TextStyle(color: Colors.grey),textAlign: TextAlign.left),
      ],mainAxisSize: MainAxisSize.min,
      ))
    ],
  );
  return x;
}