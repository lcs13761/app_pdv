import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lustore/app/model/address.dart';
import 'package:lustore/app/model/user.dart';

class ConfigChangePasswordController extends GetxController {

  TextEditingController currentPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  RxMap visiblePassword = {}.obs;
  RxMap errors = {}.obs;
  int? id;
  User user = User();
  Address address = Address();

    Future changePassword () async{

    User _user = await updateUser();
    user.current_password = currentPassword.text;
    user.password = password.text;
    user.password_confirmation = passwordConfirmation.text;

    return await user.update(user, id);


    }

  Future<User> updateUser() async{

    Map _user = await User().index();
    id = _user['id'];
    user.name = _user['name'];
    user.email = _user['email'];
    user.cpf = _user['cpf'];
    user.phone = _user['phone'];

    if(_user['address'].toString().isNotEmpty){
      address.id =  _user['address'][0]['id'];
      address.cep = _user['address'][0]['cep'];
      address.city = _user['address'][0]['city'];
      address.state = _user['address'][0]['state'];
      address.district =_user['address'][0]['district'];
      address.street = _user['address'][0]['street'];
      address.number =_user['address'][0]['number'];
      address.complement =_user['address'][0]['complement'];
      user.address = address;
    }else{
      user.address = null;
    }

    return user;

  }


}
