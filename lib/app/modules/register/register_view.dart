import 'package:flutter/material.dart';
import 'package:lustore/app/routes/app_pages.dart';
import 'package:lustore/app/theme/loading_style.dart';
import 'package:get/get.dart';
import 'package:lustore/app/modules/drawer/drawer.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorDark,
      appBar: AppBar(
        backgroundColor: backgroundColorLogo,
        title: const Text("Cadastros", style: styleColorDark),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: DrawerView().drawer(context,route: "Cadastros"),
      body: bodySelectRegister(),
    );
  }

  Widget bodySelectRegister() {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10,bottom: 10,left: 10),
          child: selectRegionRegister("Categoria", Colors.redAccent,Icons.view_module,Routes.REGISTER_CATEGORY),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10,bottom: 10,right: 10),
          child:  selectRegionRegister("Produto", Colors.green,Icons.playlist_add,Routes.REGISTER_PRODUCT)
        ),


      ],
    );
  }

  Widget selectRegionRegister(String text, color,IconData icon,route) {
    return GestureDetector(
      onTap: (){
       Get.toNamed(route);
      },
      child: Container(
        decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon,color: whiteConstColor,),
            Text(text,style: const TextStyle(color: whiteConstColor,fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
