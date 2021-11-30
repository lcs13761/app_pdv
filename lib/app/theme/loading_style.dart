import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


final colorDrawerWhite = Colors.white.withOpacity(0.8);
const grayColor =  Color.fromRGBO(204, 204, 204, 0.8);
const whiteConstColor = Color.fromRGBO(255, 255, 255, 0.8);
const backgroundColorLogo =  Color.fromRGBO(191, 147, 72, 1.0);
const backgroundColorDark =  Color.fromRGBO(43, 43, 43, 1.0);
const styleColorBlue = Color.fromRGBO(0, 103, 254, 1);
const styleColorDark = TextStyle(
  color: Color.fromRGBO(0, 0, 0, 1),
  fontSize: 22);
const styleColorWhite = TextStyle(
  color: whiteConstColor,
  fontSize: 20
);


const colorAndSizeRegisterProduct = TextStyle(
    color:grayColor,
    fontSize: 16);

const borderNone = OutlineInputBorder(

  borderSide: BorderSide(

  )
);

const errorBorderInline = UnderlineInputBorder(
  borderSide: BorderSide(
      color: Colors.red
  ),
);

const focusBorderInline = UnderlineInputBorder(
  borderSide: BorderSide(
      color: styleColorBlue
  ),
);

const enableBorderInline = UnderlineInputBorder(
  borderSide: BorderSide(
      color: Color.fromRGBO(204, 204, 204, 0.8)
  ),
);


void loading(context) {
  CoolAlert.show(
      context: context,
      width: 400,
      type: CoolAlertType.loading,
      text: 'Carregando....',
      animType: CoolAlertAnimType.scale,
      barrierDismissible: false);
}

void confirmAlert(context,String text){
  CoolAlert.show(
    context: context,
    type: CoolAlertType.confirm,
    text: text,
    confirmBtnText: 'SIM',
    cancelBtnText: 'NÃO',
    confirmBtnColor: Colors.green,
  );
}

void error(context,Map text) {
  CoolAlert.show(
      context: context,
      width: 400,
      loopAnimation: false,
      type: CoolAlertType.error,
      text: text.map((key, value) => value[0]).toString(),
      title: "Error!",
      animType: CoolAlertAnimType.scale,
      backgroundColor: const Color(0xCD000000),
      barrierDismissible: false);
}


void success(String text,context,{action}) {
  CoolAlert.show(
      onConfirmBtnTap: () {
        if (action == "back") {
          Get.back();
          Get.back();
        }else{
          Get.back();
        }
      },
      context: context,
      text: text,
      width: 400,
      type: CoolAlertType.success,
      animType: CoolAlertAnimType.scale,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      barrierDismissible: false);
}

