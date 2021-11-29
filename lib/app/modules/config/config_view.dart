import 'package:flutter/material.dart';
import 'package:lustore/app/routes/app_pages.dart';
import 'package:lustore/app/theme/loading_style.dart';
import 'package:lustore/app/modules/drawer/drawer.dart';
import 'package:get/get.dart';
import 'config_controller.dart';

class ConfigView extends GetView<ConfigController> {
  const ConfigView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorDark,
      appBar: AppBar(
        backgroundColor: backgroundColorLogo,
        title: const Text("Cadastros", style: styleColorDark),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: DrawerView().drawer(context, route: "Configuração"),
      body: bodySelectRegister(context),
    );
  }

  Widget bodySelectRegister(context) {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
          child: selectRegionRegister(
              "Administradores", Colors.redAccent, Icons.view_module,
              route: Routes.CONFIG_LIST_ADMIN),
        ),
        Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
            child: selectRegionRegister(
                "Editar Perfil", Colors.green, Icons.playlist_add,
                route: Routes.CONFIG_USER)),
        Container(
            margin: const EdgeInsets.only(top: 0, bottom: 10, left: 10),
            child: selectRegionRegister(
                "Modificar Senha", Colors.green, Icons.playlist_add,
                route: Routes.CONFIG_CHANGE_PASSWORD)),
      ],
    );
  }

  Widget selectRegionRegister(String text, color, IconData icon,
      {route, context}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: whiteConstColor,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: whiteConstColor, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
