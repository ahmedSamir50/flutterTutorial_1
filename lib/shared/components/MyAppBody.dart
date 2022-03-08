import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBody {
  static const peopelImg =
      "https://media.istockphoto.com/photos/illustration-of-smiling-people-close-up-portraits-set-cute-cartoon-picture-id1316292596?s=612x612";

  static getAppBody() => Container(
        color: Colors.teal,
        width: double.infinity,
        // Single Child Scroll View Has scrollDirection Prop which is vertical by default
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // max is default
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(40)
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children:  [
                    Image(
                      image: NetworkImage(peopelImg),
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: double.infinity,
                      //  EdgeInsetsDirectional.only(end: 12,bottom: 12,top: 12)
                        // EdgeInsets.all()
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                      child:  Text("data on the stack " ,
                        textAlign: TextAlign.center,
                        style: TextStyle(backgroundColor: Colors.black.withOpacity(0.7),
                            color: Colors.white)
                        ,)
                    ),
                  ],
                ),
              ),
              Container(
                child: const Text(
                  "First Text Of Column",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      backgroundColor: Colors.blue),
                ) //text 1
                ,
                color: Colors.grey,
              ), //text1)
              Container(
                child: const Text(
                  "Second Text Of Column",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      backgroundColor: Colors.red),
                ),
              ),
              Container(
                child: Text(
                  "Second Text Of Column",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      backgroundColor: Colors.amber),
                ),
              ),
              Container(
                  child: Text(
                "Second Text Of Column",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    backgroundColor: Colors.green),
              ) //text 14),)
                  ),
              Container(
                child: const Text(
                  "First Text Of Column",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      backgroundColor: Colors.blue),
                ) //text 1
                ,
                color: Colors.grey,
              ), //text1)
              Container(
                child: const Text(
                  "Second Text Of Column",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      backgroundColor: Colors.red),
                ),
              ),
              Container(
                child: const Text(
                  "Second Text Of Column",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      backgroundColor: Colors.amber),
                ),
              ),
              Container(
                  child: Text(
                "Second Text Of Column",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    backgroundColor: Colors.green),
              ) //text 14),)
                  ),
              Container(
                child: const Text(
                  "First Text Of Column",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      backgroundColor: Colors.blue),
                ) //text 1
                ,
                color: Colors.grey,
              ), //text1)
              Container(
                child: const Text(
                  "Second Text Of Column",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      backgroundColor: Colors.red),
                ),
              ),
              Container(
                child: Text(
                  "Second Text Of Column",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      backgroundColor: Colors.amber),
                ),
              ),
              Container(
                  child: Text(
                "Second Text Of Column",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    backgroundColor: Colors.green),
              ) //text 14),)
                  ),
              Container(
                child: const Text(
                  "First Text Of Column",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      backgroundColor: Colors.blue),
                ) //text 1
                ,
                color: Colors.grey,
              ), //text1)
              Container(
                child: const Text(
                  "Second Text Of Column",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      backgroundColor: Colors.red),
                ),
              ),
              Container(
                child: Text(
                  "Second Text Of Column",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      backgroundColor: Colors.amber),
                ),
              ),
              Container(
                  child: Text(
                "Second Text Of Column",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    backgroundColor: Colors.green),
              ) //text 14),)
                  ),
              Container(
                child: const Text(
                  "First Text Of Column",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      backgroundColor: Colors.blue),
                ) //text 1
                ,
                color: Colors.grey,
              ), //text1)
              Container(
                child: const Text(
                  "Second Text Of Column",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      backgroundColor: Colors.red),
                ),
              ),
              Container(
                child: Text(
                  "Second Text Of Column",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      backgroundColor: Colors.amber),
                ),
              ),
              Container(
                  child: Text(
                "Second Text Of Column",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    backgroundColor: Colors.green),
              ) //text 14),)
                  )
            ],
          ),
        ),
      );
}
