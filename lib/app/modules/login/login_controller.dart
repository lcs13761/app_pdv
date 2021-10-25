import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:LuStore/app/model/user.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool rememberMe = false.obs;
  RxBool show = false.obs;
  User user = User();
  final store = GetStorage();



  loginUser() async{

    bool _emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text);
    if(!_emailValid){
        return "Email inválido";
    }



    user.email = email.text;
    user.password = password.text;
    var _response = await user.login(user);
    if(_response == true && rememberMe.isTrue){
      store.write("remember", true);
    }
    return _response;

  }

}
