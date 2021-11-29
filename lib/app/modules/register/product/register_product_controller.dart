import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lustore/app/model/product.dart';
import 'package:intl/intl.dart';

class RegisterProductController extends GetxController {
  RxBool inLoading = true.obs;
  Product product = Product();
  PagingController products = PagingController(firstPageKey: 0);
  NumberFormat formatter = NumberFormat.simpleCurrency();
  final store = GetStorage();
  String? nextPageProduct = '';
  int total = 0;

  @override
  void onInit() async {
    super.onInit();
    await getProducts();
  }

  @override
  void onClose() {
    products.dispose();
    super.onClose();
  }

  Future refreshProduct() async {
    nextPageProduct = '';
    products.refresh();
    inLoading.value = false;
  }

  Future getProducts() async {
    inLoading.value = true;

    products.addPageRequestListener((pageKey) {
      unawaited(productPagination(pageKey: pageKey));
    });
    inLoading.value = false;
  }

  Future productPagination({pageKey}) async {
    try {
      if (nextPageProduct != null) {
        Map _response;
        if (nextPageProduct!.isEmpty) {
          _response = await product.index();
          nextPageProduct = _response['links']['next'];
          total = _response['meta']['total'];
        } else {
          _response = await product.nextProduct(nextPageProduct);
          nextPageProduct = _response['links']['next'];
        }
        bool isLastPage = false;
        if (products.itemList == null) {
          isLastPage = _response['data'].length == total;
        } else {
          isLastPage = products.itemList!.length == total;
        }
        if (isLastPage) {
          products.appendLastPage(_response['data']);
        } else {
          final nextPageKey = pageKey ?? 1 + _response['data'].length;
          products.appendPage(_response['data'], nextPageKey);
        }
      }
    } catch (error) {
      products.error(error);
    }
  }

  Future deleteProduct(_id) async {
    return await product.destroy(_id.toString());
  }
}
