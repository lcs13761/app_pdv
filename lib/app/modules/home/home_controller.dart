import 'dart:async';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lustore/app/model/product.dart';
import 'package:intl/intl.dart';
import 'package:lustore/app/model/sale.dart';

class HomeController extends GetxController {
  final store = GetStorage();
  TextEditingController client = TextEditingController();
  TextEditingController search = TextEditingController();
  MoneyMaskedTextController value = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', precision: 2,leftSymbol:'R\$ ',initialValue: 0.0);
  TextEditingController qts = TextEditingController(text: "1");
  Product product = Product();
  Sale sale = Sale();
  NumberFormat formatter = NumberFormat.simpleCurrency();
  String codeProduct = "";
  String thing = "";
  RxBool inLoading = true.obs;
  PagingController allProduct = PagingController(firstPageKey: 0);
  RxList saveProducts = [].obs;
  RxList saleProductAll = [].obs;
  RxInt qtsSale = 0.obs;
  RxDouble totalSale = 0.0.obs;
  RxBool activeTextField = false.obs;
  String? nextPageProduct = '';
  int total = 0;


  @override
  void onInit() async {
    super.onInit();
    await loadingSaleAndProducts();
    inLoading.value = false;
  }

  Future loadingSaleAndProducts() async {
    inLoading.value = false;
    allProduct.addPageRequestListener((pageKey) {
      unawaited(getProducts(pageKey: pageKey)) ;
    });
    await getSale();
  }

  Future getSale() async {
    var _product = await sale.index();
    saleProductAll.clear();
    saleProductAll.addAll(_product["data"]);
    listSale(_product["data"]);
  }

  Future getProducts({pageKey}) async {

    try{
     if(nextPageProduct != null){
       Map _response = {};
       if(nextPageProduct!.isEmpty){
         _response = await product.index();
         nextPageProduct = _response['links']['next'];
         total = _response['meta']['total'];
       }else{
         _response = await product.nextProduct(nextPageProduct);
         nextPageProduct = _response['links'].toString().contains('next') ? _response['links']['next'] : null;
       }
       bool isLastPage = false;
        if(allProduct.itemList == null){
          isLastPage = _response['data'].length == total;
        }else{
          isLastPage = allProduct.itemList!.length == total;
        }

       if(isLastPage){
         allProduct.appendLastPage(_response['data']);
       }else{
         final nextPageKey = pageKey ?? 1 + _response['data'].length;
         allProduct.appendPage(_response['data'], nextPageKey);
       }
     }
    }catch(error){
      allProduct.error(error);
    }
  }

  void searchProduct(String text) {
    if (saveProducts.isEmpty) {
     //saveProducts.addAll(allProduct);
    }
    if (search.text.isEmpty) {
      //allProduct.clear();
     // allProduct.addAll(saveProducts);
      saveProducts.clear();
      return;
    }
   // allProduct.clear();
   //  List _result = saveProducts.value
   //      .where((element) =>
   //          element["code"].toString().contains(text) ||
   //          element["product"].toString().contains(text))
   //      .toList();
    // allProduct.addAll(_result);
  }

  Future productCreateSale(_product) async {
    sale.client = client.text;
    sale.product = Product(
        id: _product["id"],
        qts: int.parse(qts.text) < 1 ? 1 : int.parse(qts.text));
    return await sale.store(sale);
  }

  void listSale(_product) {
    int _qts = 0;
    double _value = 0.0;
    for (var index in _product) {
      _value =
          _value + (double.parse(index["saleValue"].toString()) * index["qts"]);
      _qts = _qts + index["qts"] as int;
    }
    totalSale.value = _value;
    qtsSale.value = _qts;
  }

  Future finishSale() async {
    sale.client = client.text;
    //return await sale.finishSale(sale);
  }



}


//dialog
