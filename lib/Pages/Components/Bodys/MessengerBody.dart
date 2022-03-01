import 'package:flutter/material.dart';
import 'package:untitled1/Models/UserInChatModel.dart';
import 'package:untitled1/Pages/Components/AppBar.Components/UserInChatComponent.dart';

class MessengerBody {
  static getMessengerBody(BuildContext context) {
    Future<List<UserInChatModel>> users = UserInChatComponent.getUsersInChat();
    var chatStacks = UserInChatComponent.getUsersInChatWidgets(users, context);
    return  Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            child: const Padding(
              padding: EdgeInsets.all(2),
                child: SizedBox(
                height: 25,
                child: TextField(
                    decoration: InputDecoration(
                        labelText: "Search.... ",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder()),
                    maxLines: 1))),
            decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(10)),
          ), chatStacks ,
        ],
      );
  }
}
