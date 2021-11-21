import 'package:flutter/material.dart';
import 'package:lustore/app/theme/loading_style.dart';
import 'package:get/get.dart';

import 'login_forget_controller.dart';

class LoginForgetView extends GetView<LoginForgetController> {
  LoginForgetView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor:  Colors.black.withOpacity(0.9),
      ),
      backgroundColor: Colors.black.withOpacity(0.9),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 300,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30,bottom: 15),
                  child: const Text("Recuperação de Senha.", style: TextStyle(color: whiteConstColor,fontSize: 16),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 15, left: 15,bottom: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Preencha esse campo";
                      return null;
                    },
                    controller: controller.email,
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                    enableSuggestions: true,
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(

                      hintText: "Email",
                      hintStyle: const TextStyle(color: grayColor),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                ),
                buttonSubmit(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonSubmit(context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: InkWell(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            loading(context);
           var _response = await controller.forget();
            if (_response["result"].length != 0) {
              await 1.delay();
              success(_response["result"], context,action: "back");
              return;
            } else {
              await 1.delay();
              Get.back();
              error(context, _response);
              return;
            }
          }
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 103, 254, 1),
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            "ENVIAR",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

}
