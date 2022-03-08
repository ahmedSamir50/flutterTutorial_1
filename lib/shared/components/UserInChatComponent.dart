import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/models/UserInChatModel.dart';
import 'package:untitled1/shared/netwok/remote/chatsHttpService.dart';

class UserInChatComponent {
  static final DateFormat formatter = DateFormat('MM-dd hh:mm');
  static const int reads = 20;
  static Future<List<UserInChatModel>> getUsersInChat() async {
    List<UserInChatModel> userChats = [];
    ChatsHttpService serv = ChatsHttpService();
    for (int i = 0; i < reads; i++) {
      UserInChatModel user = await serv.getUser();
      userChats.add(user);
    }
    return userChats;
  }

  static Widget getUsersInChatWidgets(
      Future<List<UserInChatModel>> userChats, BuildContext context) {
    late List<Widget> usersComp = [];
    late List<Widget> userStates = [];
    return FutureBuilder<List<UserInChatModel>>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (UserInChatModel user in (snapshot.data ?? [])) {
              usersComp.add(getUserWidgetStack(user));
              userStates.add(getUserWidgetStackStatus(user));
            }
            List<Widget> all = [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [...userStates]),
                  ),
              Expanded( child: SingleChildScrollView(
                  child: Column(children:[...usersComp])
          ))];
            return Expanded(child: Column(
              children: all,
            ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator(color: Colors.red,);
        },
        future: userChats);
  }

  static Padding getUserWidgetStack(UserInChatModel user) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 20,
                  foregroundImage: NetworkImage(user.imgUrl),
                ),
                const CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.white,
                ),
                const CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.green,
                )
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.left),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Expanded(
                        child: Text("Fake message ........... ",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15))),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(formatter.format(DateTime.now()),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15)))
                  ],
                )
              ],
            )),
            const SizedBox(height: 10)
          ],
        ));
  }

  static Padding getUserWidgetStackStatus(UserInChatModel user) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Column(
               children: [ Stack(
                 alignment: AlignmentDirectional.bottomEnd,
                 children: [
                   CircleAvatar(
                     radius: 20,
                     foregroundImage: NetworkImage(user.imgUrl),
                   ),
                   const CircleAvatar(
                     radius: 8,
                     backgroundColor: Colors.white,
                   ),
                   const CircleAvatar(
                     radius: 7,
                     backgroundColor: Colors.green,
                   )
                 ],
               ),
                 Text(user.name,
                     style:
                     const TextStyle(color: Colors.white,
                         fontSize: 12 , overflow: TextOverflow.clip),
                     textAlign: TextAlign.left , maxLines: 1,)],
             )
            ],
          ),
        );
  }
}
