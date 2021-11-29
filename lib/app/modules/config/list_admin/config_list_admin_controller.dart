import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lustore/app/model/product.dart';
import 'package:intl/intl.dart';
import 'package:lustore/app/model/user.dart';

class ConfigListAdminController extends GetxController {

  User user = User();
  RxList users = [].obs;
  String? nextPageProduct = '';
  int total = 0;
  RxBool inLoading = true.obs;


  @override
  void onInit() async {
    super.onInit();
    await adminList();
  }

  Future adminList() async{
    inLoading.value = true;
    List _response = await user.index();
    _response.forEach((element) {
      if(element['level'] == '5'){
        users.add(element);
      }

    });

    inLoading.value = false;
  }


}
