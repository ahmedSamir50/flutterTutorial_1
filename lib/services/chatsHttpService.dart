import 'package:untitled1/Models/UserInChatModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatsHttpService{
  final String userApiUrl = "https://randomuser.me/api";
  Future<UserInChatModel> getUser() async{

    UserInChatModel response = await _fetchUser();
    return response;
  }
  Future<UserInChatModel> _fetchUser() async {
    final response = await http.get(Uri.parse(userApiUrl));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return UserInChatModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load UserInChatModel');
    }
  }
}