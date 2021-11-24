import 'package:lustore/app/core/model.dart';

class User extends Model{
  String? email;
  String? password;
  @override
  String action = "user";

  User();

  User.fromJson(Map<String,dynamic> json):
        email = json["email"],
        password = json["password"];


  Map<String,dynamic> toJson(){
    return {
      "email" : email,
      "password" : password,
    };
  }
}