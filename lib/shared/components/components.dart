

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
})=> TextFormField(
  obscureText: isObscureText,
  controller: fromController,
  onFieldSubmitted:onFieldSubmit,
  onChanged: onChange,
  keyboardType: keyboardType,
  validator: validationCallBack,
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