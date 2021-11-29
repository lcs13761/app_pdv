import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lustore/app/routes/app_pages.dart';
import 'package:lustore/app/theme/loading_style.dart';
import 'package:get/get.dart';
import 'register_product_controller.dart';

class RegisterProductView extends GetView<RegisterProductController> {
  const RegisterProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorDark,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: backgroundColorLogo,
        title: const Text(
          'Cadastro de produtos',
          style: styleColorDark,
        ),
      ),
      floatingActionButton: floatingButton(),
      body: productList(),
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
      return PagedListView.separated(
          separatorBuilder: (context, index) => const Divider(
                color: whiteConstColor,
                height: 1,
              ),
          pagingController: controller.products,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (BuildContext context, item, index) {
              var _product = item;
              return ListTile(
                onLongPress: () {
                  dialogActionProduct(context, _product, index);
                  
                },
                onTap: () {
                  Get.toNamed(Routes.REGISTER_PRODUCT_CREATE_AND_UPDATE,
                          arguments: _product)
                      ?.whenComplete(() => unawaited(controller.refreshProduct()));
                },
                title: product(_product),
              );
            },
          ));
    });
  }

  void dialogActionProduct(context, _product, index) {
    Get.dialog(AlertDialog(
      content: ListTile(
        onTap: () {
          Get.back();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: const Text("Deseja realmente excluir o produto ?"),
                  actions: [
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
                          "NÃO",
                          style: TextStyle(color: Colors.black),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 50)),
                        onPressed: () async {
                          loading(context);
                          await 1.delay();
                          var _response = await controller.deleteProduct(_product['id']);
                          if (_response != true) {
                            Get.back();
                            Get.back();
                            error(context, _response["error"]);
                          } else {
                            Get.back();
                            Get.back();
                            controller.products.value.itemList!.removeAt(index);
                            // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                            controller.products.notifyListeners();
                          }
                        },
                        child: const Text("SIM"))
                  ],
                );
              });
        },
        title: const Text("Excluir Produto."),
      ),
    ));
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
          child: _product["image"].length != 0 &&
                  _product['image'][0]['image'] != null
              ? Image.network(
                  _product["image"][0]["image"],
                  fit: BoxFit.fill,
                )
              : Align(
                  alignment: Alignment.center,
                  child: Text(_product['product'].toString().substring(0, 2),
                      style: colorAndSizeRegisterProduct),
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
        Get.toNamed(Routes.REGISTER_PRODUCT_CREATE_AND_UPDATE)
            ?.whenComplete(() => unawaited(controller.refreshProduct()));
      },
      child: const Icon(Icons.add, color: whiteConstColor),
      backgroundColor: styleColorBlue,
    );
  }
}
