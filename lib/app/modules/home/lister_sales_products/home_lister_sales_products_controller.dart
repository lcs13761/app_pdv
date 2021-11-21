import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lustore/app/model/product.dart';
import 'package:lustore/app/model/sale.dart';

class HomeListerSalesProductsController extends GetxController {

  RxList products = [].obs;
  NumberFormat formatter = NumberFormat.simpleCurrency();
  TextEditingController qts = TextEditingController();
  Sale sale = Sale();
  String action = "update";

    @override
  void onInit() {
    super.onInit();
    _saleProduct(Get.arguments);
  }

  @override
  void onClose(){
      super.onClose();
      products.clear();
  }

    _saleProduct(_product){
        products.addAll(_product);
    }

   actionProductSale(index) async{
        if(action == "update"){
          sale.product = Product(id: products[index]["id"],qts: int.parse(qts.text));
          var _response  = await sale.update(sale,products[index]["id"]);
          if(_response["result"].length != 0){
           var  _update = products[index];
           _update["qts"] = int.parse(qts.text);
           products[index] = _update;
          }
        }

        if(action == "delete"){
            var _response = await sale.destroy(products[index]["id"].toString());
            if(_response != true){
              print(_response);
              return;
            }
            products.removeAt(index);
        }
        Get.back();

    }

}
