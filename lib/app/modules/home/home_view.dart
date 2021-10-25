import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:LuStore/app/modules/drawer/drawer.dart';
import 'package:LuStore/app/routes/app_pages.dart';
import 'package:LuStore/app/theme/loading_style.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: backgroundColorDark,
        appBar: AppBar(
          backgroundColor: backgroundColorLogo,
          title: const Text(
            "LuStore",
            style: styleColorDark,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: const Color.fromRGBO(250, 255, 230, 1),
            child: buttonNavigation()),
        drawer: DrawerView().drawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              searchRow(),
              divider(),
              title(),
              divider(),
            ],
          ),
        ));

  }

  Widget floatingButton() {
    return FloatingActionButton(
      onPressed: () {

        Get.toNamed(Routes.HOME_LISTER_SALES_PRODUCTS);
      },
      child: const Icon(Icons.expand_less, color: backgroundColorDark),
      backgroundColor: const Color.fromRGBO(250, 255, 230, 1),
    );
  }

  Widget searchRow() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              style: TextStyle(color: colorDrawerWhite, fontSize: 20),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: colorDrawerWhite, fontSize: 16),
                hintText: 'Pesquisar um produto',
                border: InputBorder.none,
                enabledBorder: enableBorderInline,
                focusedBorder: focusBorderInline,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            child: Icon(
              Icons.search,
              color: colorDrawerWhite,
            ),
          )
        ],
      ),
    );
  }

  Widget divider() {
    return const Divider(
      color: whiteConstColor,
    );
  }

  Widget title() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      child: const Text(
        "Todos os produtos",
        style: styleColorWhite,
      ),
    );
  }

  Widget buttonNavigation() {
    return SizedBox(
        height: 61,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Quantidade de Produtos:"),
            ),
            Padding(
                padding: EdgeInsets.only(right: 40),
                child: Text("Total da Venda:"))
          ],
        ));
  }
}
