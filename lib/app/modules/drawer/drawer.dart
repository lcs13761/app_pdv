import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lustore/app/routes/app_pages.dart';
import 'package:lustore/app/theme/loading_style.dart';

class DrawerView {

  final store = GetStorage();

  Widget drawer(BuildContext context,{route}) {
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
                  const Text(
                    "Admin",
                    style: TextStyle(color: backgroundColorDark, fontSize: 16),
                  )
                ],
              )),
          listTile(Icons.shopping_cart_outlined, "Venda",route: Routes.HOME,active: route),
          listTile(Icons.edit, "Cadastros",route: Routes.REGISTER,active: route),
          listTile(Icons.assessment_outlined, "Relatórios",route: Routes.REPORTS,active: route),
          listTile(Icons.power_settings_new, "Sair"),
        ],
      ),
    ));
  }

  Widget listTile(IconData icon, String text,{route,active}) {
    return ListTile(
      onTap: () {

        if(active == text){
          Get.back();
            return;
        }
        if(text == "Sair"){
            store.erase();
            Get.offAllNamed("/login");
        }else{
          Get.offAllNamed(route);
        }

      },
      leading: Icon(
        icon,
        color: backgroundColorDark,
      ),
      title: Text(
        text,
        style:const TextStyle(color: backgroundColorDark, fontSize: 16),
      ),
    );
  }
}
