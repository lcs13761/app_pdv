import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lustore/app/model/auth.dart';

class LoginForgetController extends GetxController {

  TextEditingController email = TextEditingController();
  Auth auth = Auth();

  Future forget()async{
    bool _emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text);
    if(!_emailValid){
      return "Email inválido";
    }

    auth.email = email.text;
    return await auth.forget(auth);


  }

}
