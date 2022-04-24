import 'package:flutter/material.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/MyAppBar.dart';

class MessengerAppBar {
  static const avtImg =
      "https://thumbs.dreamstime.com/z/male-avatar-icon-flat-style-male-user-icon-cartoon-man-avatar-hipster-vector-stock-91462914.jpg";
  static final List<Widget> _iconsAndActions = [
    CircleAvatar(
      child: IconButton(
          icon: const Icon(Icons.photo_camera),
          onPressed: () => {print("camira btn clicked .... ")},
          iconSize: 30),
      backgroundColor: Colors.black,
    ),
    const SizedBox(width: 5),
    CircleAvatar(
      child: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => {print("edit btn clicked .... ")},
          iconSize: 30),
      backgroundColor: Colors.black,
    ),
  ];

  static getMessengerAppBar() => MyAppBar(
      barColor: Colors.black,
      titleSpacing: 20,
      leading: Container(
        padding: const EdgeInsets.all(10),
        child: const CircleAvatar(
          backgroundColor: Colors.black,
          backgroundImage: NetworkImage(avtImg),
        ),
      ),
      title: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: const [
            SizedBox(),
            Text("Chats"),
          ],
        ),
      ),
      barActions: _iconsAndActions);
}
