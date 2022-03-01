import 'dart:math';

class UserInChatModel{
  UserInChatModel({
    required this.gender,
    required this.name,
    required this.imgUrl,
});

  Gender gender = Gender.male;
  String name ="";
  String imgUrl ="";
  OnLineState state = Random(0).nextInt(3) %2 == 0 ?
                       OnLineState.offLine:OnLineState.online;

  factory UserInChatModel.fromJson(Map<String,dynamic>json){
    dynamic js = json["results"][0];
    return UserInChatModel(
        gender: js["gender"]=="male"? Gender.male:Gender.female,
        name: _compinStrs(js["name"]["first"],js["name"]["last"]),
        imgUrl: js["picture"]["medium"]
    );
  }

  static String _compinStrs (String fr , String sec )=> fr+""+sec;
}
enum Gender {
  male , female
}
enum OnLineState {
  online , offLine
}