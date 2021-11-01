import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lustore/app/theme/loading_style.dart';
import 'package:get/get.dart';
import 'home_lister_sales_products_controller.dart';

class HomeListerSalesProductsView
    extends GetView<HomeListerSalesProductsController> {
  const HomeListerSalesProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorDark,
      appBar: AppBar(
        backgroundColor: backgroundColorLogo,
        title: const Text(
          'Lista de venda',
          style: styleColorDark,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _product(),
    );
  }

  Widget _product() {
    return Obx(() => ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: whiteConstColor,
            height: 1,
          ),
          itemCount: controller.products.length,
          itemBuilder: (BuildContext context, int index) {
            var _product = controller.products[index];
            return ListTile(
                title: GestureDetector(
              onTap: () {
                controller.qts.text = _product["qts"].toString();
                dialogQts(context, index);
              },
              child: list(_product, context, index),
            ));
          },
        ));
  }

  Widget list(_product, context, index) {
    return SizedBox(
      height: 60,
      child: StaggeredGridView.count(
        primary: false,
        crossAxisCount: 2,
        staggeredTiles: const [
          StaggeredTile.fit(1),
          StaggeredTile.fit(1),
        ],
        children: <Widget>[
          nameProduct(_product),
          infoProduct(_product, context, index),
        ],
      ),
    );
  }

  Widget nameProduct(_product) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      child: Text(
        _product["product"],
        style: const TextStyle(color: whiteConstColor),
      ),
    );
  }

  Widget infoProduct(_product, context, index) {
    return Container(
      height: 60,
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text("x" + _product["qts"].toString(),
              style: const TextStyle(color: whiteConstColor)),
         Obx(
             () =>  Padding(
                 padding: const EdgeInsets.only(left: 10, right: 10),
                 child: Text(
                     controller.formatter
                         .format(controller.products[index]["saleValue"] * _product["qts"]),
                     style: const TextStyle(color: whiteConstColor))),
         ),
          GestureDetector(
            onTap: () {
              dialogDelete(_product["product"],index,context);
            },
            child: Container(
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: const Icon(
                  Icons.delete,
                  color: whiteConstColor,
                )),
          )
        ],
      ),
    );
  }

  void dialogQts(context, index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Quantidade do Produto"),
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
                    controller.action = "update";
                    loading(context);
                    controller.actionProductSale(index);
                  },
                  child: const Text(
                    "Salva",
                    style: TextStyle(fontSize: 18),
                  ))
            ],
            content: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      if (int.parse(controller.qts.text) > 1) {
                        controller.qts.text =
                            (int.parse(controller.qts.text) - 1).toString();
                      }
                    },
                    child: Container(
                      color: Colors.green,
                      width: 60,
                      height: 40,
                      child: const Icon(Icons.remove),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.qts,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(color: colorDrawerWhite, fontSize: 16),
                      border: InputBorder.none,
                      enabledBorder: enableBorderInline,
                      focusedBorder: focusBorderInline,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    onTap: () {
                      controller.qts.text =
                          (int.parse(controller.qts.text) + 1).toString();
                    },
                    child: Container(
                      color: Colors.green,
                      width: 60,
                      height: 60,
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void dialogDelete(_product,index,context){
    Get.dialog(
      AlertDialog(
        title:const Text("Alerta"),
        content: Text("Deseja realmente remove o item " + _product + "?"),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text("NÃO"),
            )
          ),
          GestureDetector(
            onTap: (){
              Get.back();
              controller.action = "delete";
              loading(context);
              controller.actionProductSale(index);
            },
            child:Container(
                padding: EdgeInsets.all(10),
              child:  Text("SIM"),
            )
          ),
        ],
      )
    );
  }
}
