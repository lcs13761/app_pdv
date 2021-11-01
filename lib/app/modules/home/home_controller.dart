import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  RxList allProduct = [].obs;
  RxList saveProducts = [].obs;
  RxList saleProductAll = [].obs;
  RxInt qtsSale = 0.obs;
  RxDouble totalSale = 0.0.obs;
  RxBool activeTextField = false.obs;


  @override
  void onInit() async {
    super.onInit();
    await getProducts();
    await getSale();
  }

  Future loadingSaleAndProducts() async {
    await getProducts();
    await getSale();
  }

  Future getSale() async {
    var _product = await sale.getSales();
    saleProductAll.clear();
    saleProductAll.addAll(_product["result"]);
    listSale(_product["result"]);
  }

  Future getProducts() async {
    inLoading.value = true;
    allProduct.clear();
    var _response = await product.getAllProducts();
    inLoading.value = false;
    allProduct.addAll(_response["result"]);
  }

  void searchProduct(String text) {
    if (saveProducts.isEmpty) {
      saveProducts.addAll(allProduct);
    }
    if (search.text.isEmpty) {
      allProduct.clear();
      allProduct.addAll(saveProducts);
      saveProducts.clear();
      return;
    }
    allProduct.clear();
    List _result = saveProducts.value
        .where((element) =>
            element["code"].toString().contains(text) ||
            element["product"].toString().contains(text))
        .toList();
    allProduct.addAll(_result);
  }

  Future productCreateSale(_product) async {
    sale.client = client.text;
    sale.product = Product(
        id: _product["id"],
        qts: int.parse(qts.text) < 1 ? 1 : int.parse(qts.text));
    return await sale.create(sale);
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
    return await sale.finishSale(sale);
  }
}


//dialog
