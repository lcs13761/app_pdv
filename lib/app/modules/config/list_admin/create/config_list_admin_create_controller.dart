import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:lustore/app/model/address.dart';
import 'package:lustore/app/model/user.dart';

class ConfigListAdminCreateController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  TextEditingController password = TextEditingController();
  RxMap visiblePassword = {}.obs;
  User user = User();
  RxMap errors = {}.obs;



  Future createUser() async{
    user.name = name.text;
    user.email = email.text;
    user.password = password.text;
    user.password_confirmation = passwordConfirmation.text;
    user.level = '5';
    print(jsonEncode(user));
    return await user.store(user);
  }

}
