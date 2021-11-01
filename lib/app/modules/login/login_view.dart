import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lustore/app/theme/loading_style.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  margin: const EdgeInsets.only(top: 80),
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 300,
                  ),
                ),
                textLogin(),
                textFieldEmail(),
                textFieldPassword(),
                forgetPasswordOrRemember(),
                buttonSubmit(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textLogin() {
    return Container(
      margin: const EdgeInsets.only(top: 35, bottom: 25),
      child: Text(
        "Login",
        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 26),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget textFieldEmail() {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
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
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ),
    );
  }

  Widget textFieldPassword() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) return "Preencha esse campo";
            return null;
          },
          controller: controller.password,
          style: TextStyle(color: Colors.white.withOpacity(0.8)),
          obscureText: controller.show.isTrue ? false : true,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                if (controller.show.isTrue) {
                  controller.show.value = false;
                } else {
                  controller.show.value = true;
                }
              },
              child: controller.show.isTrue ? hiddenPassword : showPassword,
            ),
            prefixIcon: Icon(
              Icons.password,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      ),
    );
  }

  final showPassword =
      Icon(Icons.remove_red_eye_sharp, color: Colors.white.withOpacity(0.9));

  final hiddenPassword =
      Icon(Icons.visibility_off, color: Colors.white.withOpacity(0.9));

  Widget forgetPasswordOrRemember() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 5, right: 15, left: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Obx(
              () => Row(
                children: <Widget>[
                  Checkbox(
                      checkColor: Colors.white,
                      side: BorderSide(
                        color: Colors.white.withOpacity(0.8)
                      ),
                      activeColor: const Color.fromRGBO(0, 103, 254, 1),
                      value: controller.rememberMe.isTrue,
                      onChanged: (value) {
                        if (value != null) {
                          controller.rememberMe.value = value;
                        }
                      }),
                  GestureDetector(
                    onTap: (){
                      if(controller.rememberMe.isTrue){
                        controller.rememberMe.value = false;
                      }else{
                        controller.rememberMe.value = true;
                      }
                    },
                    child: Text(
                      "Lembrar-me?",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Esqueceu a senha?",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ));
  }

  Widget buttonSubmit(context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: InkWell(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            loading(context);
            var _response = await controller.loginUser();
            if (_response == true) {
              await 1.delay();
              Get.offAllNamed("/home");
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
            "ENTRAR",
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
