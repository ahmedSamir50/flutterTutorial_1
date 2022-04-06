import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/models/news_api_response.dart';
import 'package:untitled1/models/todo_model.dart';
import 'package:untitled1/shared/bloc/newsapp/news_cubit.dart';
import 'package:untitled1/shared/bloc/todo/todoCubit.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/components/webViewWidegt.dart';

Widget defaultTextInput({
  bool isObscureText = false,
  required TextEditingController fromController,
  Function(String)? onFieldSubmit,
  Function(String)? onChange,
  String? Function(String?)? validationCallBack,
  required TextInputType keyboardType,
  String label = "Text Field",
  required String hint,
  IconData prefixIcon = Icons.edit,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
}) =>
    TextFormField(
      obscureText: isObscureText,
      controller: fromController,
      onFieldSubmitted: onFieldSubmit,
      onChanged: onChange,
      keyboardType: keyboardType,
      validator: validationCallBack,
      onTap: onTap,
      decoration: InputDecoration(
          hintText: label,
          labelText: hint,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon != null
              ? IconButton(icon: Icon(suffixIcon), onPressed: suffixPressed)
              : null,
          border: const OutlineInputBorder()),
    );

Widget todoModelWidgetBuilder(TODOModel model , TODOAppCubit cubitState) {
  return Row(children: [
   Expanded(child:  Container(
     padding: const EdgeInsets.all(7),
     child: CircleAvatar(
         child: Text(
           formatDateToTimeOnly(model.timeOfCreation),
           style: const TextStyle(color: Colors.white),
         ),
         radius: 30,
         backgroundColor: Colors.blueAccent),
   )),
    //const SizedBox(width: 10),
    Expanded(
        child: Column(children: [
          Text(
            model.title,
            textAlign: TextAlign.left,
          ),
          Text(formatDateToFormatedDate(model.timeOfCreation),
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.left , overflow: TextOverflow.ellipsis),
        ]),
        flex: 3),
    //const SizedBox(width: 10),
   Expanded(child:  Container(
     color: Colors.blue[900],
     padding: const EdgeInsets.only(right: 10 , left: 10),
     child: Row(
       children: [
         SizedBox(child: MaterialButton(
           onPressed: () {
              cubitState.setTaskAsDoneOrAnyOtherState(model.id );
           },
           child: const Icon(Icons.check_circle_rounded, color: Colors.green , size: 40),
         ) , width: 40,),
         const SizedBox(
           width: 10,
         ),
         SizedBox(
           child: MaterialButton(
             onPressed: () {
             cubitState.setTaskAsDoneOrAnyOtherState(model.id ,taskNewState: TODOAPPTASKStatuses.ARCHIVED);
             },
             child: const Icon(Icons.archive, color: Colors.white , size: 40,),
           ),
           width: 40,
         )
       ],
     ),
   ),flex: 2,)
  ]);
}

Widget newsModelWidgetBuilder(NewsArticle model , NewsAppCubit cuibit , BuildContext context){
  var img = "assets/images/loading.gif";
  String imgUrl = (model.urlToImage.isNotEmpty ? model.urlToImage : img);
  return InkWell(
    child: Row(
    children: [
      Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child:FadeInImage(image: NetworkImage( imgUrl, scale: 1) , placeholder: AssetImage(img),)
      ),
      const SizedBox(width: 5,),
      Expanded(child: SizedBox(
        height: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child:
            Text(model.title ,
              style: Theme.of(context).textTheme.bodyText1,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            )),
            Text(DateFormat("yyyy-MM-dd").format(model.publishedAt) ,
              style:  TextStyle(color: Colors.grey[900] ),textAlign: TextAlign.left,)
          ],
        ),
      ))
    ],
  ),
    onTap: ()=>navigateTo(context,WebViewWidget(initUrl: model.url)),
  );
}
void navigateTo(BuildContext ctx , Widget toWidget)=> Navigator.push(ctx, MaterialPageRoute(builder: (context) =>  toWidget));
