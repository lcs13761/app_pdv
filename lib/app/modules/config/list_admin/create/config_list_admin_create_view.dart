import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lustore/app/theme/loading_style.dart';

import 'config_list_admin_create_controller.dart';

class ConfigListAdminCreateView
    extends GetView<ConfigListAdminCreateController> {
  final _formKey = GlobalKey<FormState>();

  ConfigListAdminCreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
          appBar: AppBar(
            backgroundColor: backgroundColorLogo,
            title: const Text('Adicionar administrado', style: styleColorDark),
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: textField(
                        "Nome", TextInputType.text, controller.name, 'name'),
                  ),
                  textField("E-mail", TextInputType.emailAddress,
                      controller.email, 'email'),
                  passwordField(
                      "Senha ", TextInputType.text, controller.password, 'password'),
                  passwordField("Confirmação da Senha", TextInputType.text,
                      controller.passwordConfirmation, 'password_confirmation'),
                  buttonSubmit(context)
                ],
              ),
            ),
          )),
    );
  }

  Widget textField(String text, type, controllerName, key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 0, bottom: 5, left: 15, right: 15),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Preencha esse campo";
              }
              return null;
            },
            keyboardType: type,
            controller: controllerName,
            style: const TextStyle(color: whiteConstColor),
            decoration: InputDecoration(
              label: Text(
                text,
                style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.6), fontSize: 16),
              ),
              border: InputBorder.none,
              enabledBorder: enableBorderInline,
              errorBorder: errorBorderInline,
              focusedErrorBorder: focusBorderInline,
              focusedBorder: focusBorderInline,
            ),
          ),
        ),
        Obx(() {
          if (controller.errors.containsKey('errors') &&
              controller.errors['errors'].toString().contains(key)) {
            return Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5, left: 15),
              child: Text(
                controller.errors['errors'][key][0].toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Text('');
        }),
      ],
    );
  }


  Widget passwordField(String text, type, controllerName, key) {
    controller.visiblePassword[key] = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 0, bottom: 5, left: 15, right: 15),
          child: Obx(() => TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Preencha esse campo";
              }
              return null;
            },
            keyboardType: type,
            obscureText: controller.visiblePassword[key] ? false : true,
            autocorrect: false,
            enableSuggestions: true,
            controller: controllerName,
            style: const TextStyle(color: whiteConstColor),
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  if (controller.visiblePassword[key]  == true ) {
                    controller.visiblePassword[key] = false;
                  } else {
                    controller.visiblePassword[key] = true;
                  }
                },
                child: controller.visiblePassword[key] ?  hiddenPassword : showPassword,
              ),
              label: Text(
                text,
                style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.6), fontSize: 16),
              ),
              border: InputBorder.none,
              enabledBorder: enableBorderInline,
              errorBorder: errorBorderInline,
              focusedErrorBorder: focusBorderInline,
              focusedBorder: focusBorderInline,
            ),
          ),),
        ),
        Obx(() {
          if (controller.errors.containsKey('errors') &&
              controller.errors['errors'].toString().contains(key) && controller.errors['errors'][key] != null) {
            return Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5, left: 15),
              child: Text(
                controller.errors['errors'][key][0].toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Text('');
        }),
      ],
    );
  }

  final showPassword =
  Icon(Icons.remove_red_eye_sharp, color: Colors.white.withOpacity(0.9));

  final hiddenPassword =
  Icon(Icons.visibility_off, color: Colors.white.withOpacity(0.9));

  Widget buttonSubmit(context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: InkWell(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            loading(context);
            controller.errors.clear();
            var _response = await controller.createUser();
            print(_response);
            await 1.delay();
            Get.back();
            if (_response == true) {
              success("sucesso", context, action: "back");
            } else {

              controller.errors.addAll(_response);
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
            "SALVAR",
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
