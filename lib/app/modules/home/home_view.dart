import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lustore/app/modules/drawer/drawer.dart';
import 'package:lustore/app/routes/app_pages.dart';
import 'package:lustore/app/theme/loading_style.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      drawer: DrawerView().drawer(context, route: "Venda"),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: Column(
          children: <Widget>[
            clientAndFinishSale(context),
            searchRow(),
            divider(),
            title(),
            divider(),
            Expanded(
              child: productList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget clientAndFinishSale(context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Obx(
              () => TextField(
                enabled: controller.activeTextField.isTrue,
                style: TextStyle(color: colorDrawerWhite, fontSize: 20),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: colorDrawerWhite, fontSize: 16),
                  hintText: 'Cliente',
                  border: InputBorder.none,
                  enabledBorder: enableBorderInline,
                  focusedBorder: focusBorderInline,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 1,
                    color: colorDrawerWhite,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if(controller.totalSale > 0.0){
                      dialogDemand(controller.totalSale.toDouble(),context);
                   }

                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(15, 70), primary: styleColorBlue),
                  child: Obx(
                    () => Text(
                      "Cobrar\n" +
                          controller.formatter
                              .format(controller.totalSale.toDouble()),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchRow() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: (value) {
                controller.searchProduct(value);
              },
              controller: controller.search,
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

  Widget productList() {
    return Obx(() {
      if (controller.inLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(
            color: styleColorBlue,
          ),
        );
      }
      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: whiteConstColor,
          height: 1,
        ),
        itemCount: controller.allProduct.length,
        itemBuilder: (BuildContext context, int index) {
          var _product = controller.allProduct[index];
          print(_product);
          return ListTile(
            onTap: () {
              dialogAddProductSale(context, _product);
            },
            title: product(_product),
          );
        },
      );
    });
  }

  void dialogAddProductSale(context, _product) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: TextField(
              style: const TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              controller: controller.qts,
              decoration: const InputDecoration(
                label: Text(
                  "Quantidade",
                  style: TextStyle(color: backgroundColorDark, fontSize: 16),
                ),
                border: InputBorder.none,
                enabledBorder: enableBorderInline,
                errorBorder: errorBorderInline,
                focusedErrorBorder: focusBorderInline,
                focusedBorder: focusBorderInline,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50)),
                  onPressed: () async {
                    Get.back();
                    loading(context);
                    await 1.delay();
                    var _response =
                        await controller.productCreateSale(_product);
                    if (_response["result"].length == 0) {
                      Get.back();
                      error(context, _response);
                    } else {
                      await controller.getProducts();
                      controller.search.text = "";
                      controller.qts.text = "1";
                      controller.activeTextField.value = false;
                      controller.saleProductAll.clear();
                      controller.saleProductAll.addAll(_response["result"]);
                      controller.listSale(_response["result"]);
                      Get.back();
                    }
                  },
                  child: const Text(
                    "Salva",
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          );
        });
  }

  Widget product(_product) {
    return Row(
      children: <Widget>[
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: const Color.fromRGBO(31, 31, 31, 1.0),
          ),
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: _product["image"].length != 0
              ? Image.network(
                  _product["image"][0]["image"],
                  fit: BoxFit.fill,
                )
              : const Align(
                  alignment: Alignment.center,
                  child: Text("sa", style: colorAndSizeRegisterProduct),
                ),
        ),
        Expanded(
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                _product["qts"].toString(),
                style: colorAndSizeRegisterProduct,
              ),
            ),
            subtitle: Text(
              _product["product"],
              style: colorAndSizeRegisterProduct,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(controller.formatter.format(_product["saleValue"]),
              style: colorAndSizeRegisterProduct),
        ),
      ],
    );
  }

  Widget floatingButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(Routes.HOME_LISTER_SALES_PRODUCTS,
                arguments: controller.saleProductAll)
            ?.whenComplete(() => (controller.loadingSaleAndProducts()));
      },
      child: const Icon(Icons.expand_less, color: backgroundColorDark),
      backgroundColor: const Color.fromRGBO(250, 255, 230, 1),
    );
  }

  Widget buttonNavigation() {
    return Stack(
      children: <Widget>[
        Obx(
          () => SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Quantidade: " + controller.qtsSale.toString()),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text("Total da Venda: " +
                        controller.formatter
                            .format(controller.totalSale.toDouble())))
              ],
            ),
          ),
        )
      ],
    );
  }


  //dialog
  void dialogDemand(value, context) {
    Get.dialog(Dialog(
      insetPadding:
      const EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
      child: Scaffold(
        backgroundColor: backgroundColorDark,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
          title: const Text(
            "Selecione a forma de pagamento",
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: ListTile(
                  title: const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Valor da Compra",
                      style: TextStyle(fontSize: 16, color: whiteConstColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      controller.formatter.format(value),
                      textAlign: TextAlign.center,
                      style:
                      const TextStyle(fontSize: 24, color: whiteConstColor),
                    ),
                  )),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  padding: const EdgeInsets.all(10),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        moneyDialog(value, context);
                      },
                      child: Container(
                        decoration: const BoxDecoration(color: grayColor),
                        alignment: Alignment.center,
                        child: const Text("DINHEIRO"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                        Get.back();
                        loading(context);
                        var _response = await controller.finishSale();
                        if (_response != true) {
                          Get.back();
                          error(context, _response);
                          return;
                        }
                        await controller.getSale();
                        Get.back();
                        success("Venda realizada com sucesso", context);
                      },
                      child:  Container(
                        decoration: const BoxDecoration(color: grayColor),
                        alignment: Alignment.center,
                        child: const Text("CARTAO DE CRÉDITO"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void moneyDialog(double value, context) {
    Get.dialog(Dialog(
      insetPadding:
      const EdgeInsets.only(top: 150, bottom: 150, left: 30, right: 30),
      child: Scaffold(
        backgroundColor: styleColorBlue,
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 15),
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    color: backgroundColorLogo,
                    child: const Text("Dinheiro"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      controller.formatter.format(value),
                      style:
                      const TextStyle(fontSize: 24, color: whiteConstColor),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "Valor recebido",
                      style: TextStyle(fontSize: 16, color: whiteConstColor),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextField(
                      style: const TextStyle(color: whiteConstColor),
                      enabled: false,
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: controller.value,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: whiteConstColor,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: (50 / 40),
                children: <Widget>[
                  keyboardNumeric("1"),
                  keyboardNumeric("2"),
                  keyboardNumeric("3"),
                  keyboardNumeric("4"),
                  keyboardNumeric("5"),
                  keyboardNumeric("6"),
                  keyboardNumeric("7"),
                  keyboardNumeric("8"),
                  keyboardNumeric("9"),
                  keyboardCleanAll(),
                  keyboardNumeric("0"),
                  keyboardNumericIcon(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Get.back();
                    dialogDemand(value, context);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 15, right: 10, left: 10),
                    child: const Text(
                      "VOLTAR",
                      style: TextStyle(fontSize: 16, color: whiteConstColor),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Get.back();
                    loading(context);
                    var _response = await controller.finishSale();
                    if (_response != true) {
                      Get.back();
                      error(context, _response);
                      return;
                    }
                    await controller.getSale();
                    Get.back();
                    moneyReturn(value - controller.value.numberValue);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 15, right: 20, left: 10),
                    child: const Text(
                      "FINALIZAR VENDA",
                      style: TextStyle(fontSize: 16, color: whiteConstColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget keyboardNumeric(String number) {
    return TextButton(
      onPressed: () {
        controller.thing = controller.thing + number;
        controller.value.updateValue(double.parse(controller.thing));
      },
      child: Text(
        number,
        style: const TextStyle(color: whiteConstColor, fontSize: 20),
      ),
    );
  }

  Widget keyboardCleanAll() {
    return TextButton(
      onPressed: () {
        controller.thing = "";
        controller.value.updateValue(0.0);
      },
      child: const Text(
        "C",
        style: TextStyle(fontSize: 20, color: whiteConstColor),
      ),
    );
  }

  Widget keyboardNumericIcon() {
    return TextButton(
      onPressed: () {
        if (controller.value.text.length > 1) {
          controller.value.text =
              controller.value.text.substring(0, controller.value.text.length - 1);
        }
        if (controller.thing.isNotEmpty) {
          controller.thing = controller.thing.substring(0, controller.thing.length - 1);
        }
      },
      child: const Icon(
        Icons.clear,
        color: whiteConstColor,
        size: 20,
      ),
    );
  }

  void moneyReturn(value) {
    Get.defaultDialog(
        backgroundColor: backgroundColorDark,
        radius: 5,
        title: "TROCO",
        titleStyle: const TextStyle(color: whiteConstColor, fontSize: 16),
        content: ListTile(
          title: Text(
            controller.formatter.format(value),
            style: const TextStyle(color: whiteConstColor, fontSize: 16),
          ),
        ),
        confirm: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
              primary: styleColorBlue
          ),
          child: Text("CONTINUAR"),
        ));
  }
}



