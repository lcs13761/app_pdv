import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lustore/app/model/product.dart';
import 'package:lustore/app/model/sale.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class HomeListerSalesProductsController extends GetxController {

  final store = GetStorage();
  RxList products = [].obs;
  NumberFormat formatter = NumberFormat.simpleCurrency();
  TextEditingController qts = TextEditingController();
  TextEditingController discount = TextEditingController();
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

  discountProductView(_product){

    var value = _product["saleValue"] * _product["qts"];
    var calcDiscount = _product['discount'] / 100;
    calcDiscount = value * calcDiscount;
    return (value - calcDiscount);
  }


  Future discountProduct() async{
      action = 'update';
      products.forEach((element) async{
        int i = 0;
        sale.discount = double.parse(discount.text);
        qts.text = element['qts'].toString();
        await actionProductSale(i);
        i++;
      });
      discount.text = '';
    }

   actionProductSale(index) async{

        if(action == "update"){
          sale.salesman = store.read('email') ?? 'system';
          sale.qts = int.parse(qts.text) < 1 ? 1 : int.parse(qts.text);
          sale.product = Product(id: products[index]["id"]);
          var _response  = await sale.update(sale,products[index]["id"]);
          if(_response == true){
           var  _update = products[index];
           _update["qts"] = int.parse(qts.text);
           _update['discount'] = sale.discount;
           products[index] = _update;
          }
        }
        if(action == "delete"){
            var _response = await sale.destroy(products[index]["id"]);
            if(_response != true){
              return;
            }
            products.removeAt(index);
        }
        Get.back();

    }

}
