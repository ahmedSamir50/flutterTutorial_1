

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/todo_model.dart';
import 'package:untitled1/shared/components/constants.dart';

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
      Container(
        padding: const EdgeInsets.all(7),
        child: CircleAvatar(child:
        Text(formatDateToTimeOnly(model.timeOfCreation),
          style: const TextStyle(color: Colors.white),),
            radius: 30 ,
            backgroundColor: Colors.blueAccent),
      ),
      const SizedBox(width: 10),
      Expanded(child:
      Column(children: [
        Text(model.title,textAlign: TextAlign.left,),
        Text(formatDateToFormatedDate(model.timeOfCreation),
            style: const TextStyle(color: Colors.grey),textAlign: TextAlign.left),
      ],mainAxisSize: MainAxisSize.min,
      ))
    ],
  );
  return x;
}