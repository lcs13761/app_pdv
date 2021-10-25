import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:LuStore/app/routes/app_pages.dart';
import 'package:LuStore/app/theme/loading_style.dart';

class DrawerView {

  final store = GetStorage();

  Widget drawer(BuildContext context) {
    return Drawer(
        child: ColoredBox(
      color: backgroundColorLogo,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide.none,
                    bottom: BorderSide(
                        width: 1, color: Colors.black.withOpacity(0.3))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo-white.png",
                    width: 150,
                  ),
                  Text(
                    "Admin",
                    style: TextStyle(color: colorDrawerWhite, fontSize: 16),
                  )
                ],
              )),
          listTile(Icons.shopping_cart_outlined, "Venda"),
          listTile(Icons.edit, "Cadastros",route: Routes.REGISTER),
          listTile(Icons.assessment_outlined, "Relatórios"),
          listTile(Icons.power_settings_new, "Sair"),
        ],
      ),
    ));
  }

  Widget listTile(IconData icon, String text,{route}) {
    return ListTile(
      onTap: () {
        if(text == "Sair"){
            store.erase();
            Get.offAllNamed("/login");
        }else{
          Get.offAllNamed(route);
        }

      },
      leading: Icon(
        icon,
        color: colorDrawerWhite,
      ),
      title: Text(
        text,
        style: TextStyle(color: colorDrawerWhite, fontSize: 16),
      ),
    );
  }
}
