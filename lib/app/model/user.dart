// ignore_for_file: non_constant_identifier_names

import 'package:lustore/app/core/model.dart';

import 'address.dart';

class User extends Model{

  String? photo;
  String? name;
  String? email;
  String? cpf;
  String? phone;
  Address? address;
  String? current_password;
  String? password_confirmation;
  String? password;

  User(){
    actionApi('user');
  }

  User.fromJson(Map<String,dynamic> json):
        photo = json['photo'],
        name = json['name'],
        email = json["email"],
        cpf = json['cpf'],
        phone = json['phone'],
        address = json['address'],
        current_password = json['current_password'],
        password_confirmation = json['password_confirmation'],
        password = json["password"];


  Map<String,dynamic> toJson(){
    return {
      'photo' : photo,
      'name' : name,
      "email" : email,
      'cpf' : cpf,
      'phone' : phone,
      'address' : address,
      'current_password' : current_password,
      'password_confirmation' : password_confirmation,
      "password" : password,
    };
  }
}