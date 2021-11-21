import 'dart:convert';

import 'package:lustore/app/modules/register/product/register_product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lustore/app/api/api_upload.dart';
import 'package:lustore/app/model/category.dart';
import 'package:lustore/app/model/image_controller.dart';
import 'package:lustore/app/model/product.dart';

class RegisterProductCreateAndUpdateController extends GetxController {
  TextEditingController cod = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController size = TextEditingController();
  MoneyMaskedTextController cost = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', precision: 2);
  MoneyMaskedTextController value = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', precision: 2);
  TextEditingController qts = TextEditingController();
  ImagePicker image = ImagePicker();
  RegisterProductController registerProduct = RegisterProductController();
  Category category = Category();
  Product product = Product();
  ApiUpload upload = ApiUpload();
  RxString fileImage = "".obs;
  RxList categoryList = [].obs;
  int id = 0;
  RxString stringCategory = "1".obs;
  RxString typeAction = "create".obs;
  RxBool onLoadingFinalized = false.obs;
  RxMap errors = {}.obs;

  @override
  void onInit() async {
    super.onInit();
    if(Get.arguments != null){
      typeAction.value = "update";
      print(Get.arguments);
      updateType(Get.arguments);
    }
    await getAllCategories();
    onLoadingFinalized.value = true;
  }



  @override
  void onClose() {
    super.onClose();
    categoryList.clear();
  }

  getAllCategories() async {
    var _categories = await category.index();
    categoryList.addAll(_categories["data"]);
  }

  updateType(_product){
    var valueSale = _product["saleValue"].toString().contains(".")
        ? _product["saleValue"]
        : double.parse(_product["saleValue"].toString());

    var costValue =  _product["costValue"].toString().contains(".")
        ? Get.arguments["costValue"]
        : double.parse(_product["costValue"].toString());

      if(_product["image"].length != 0){
        fileImage.value = _product["image"][0]["image"];
      }
      id = _product["id"];
      stringCategory.value = _product["category"]["id"].toString();
      cod.text = _product["code"].toString();
      productName.text = _product["product"].toString();
      description.text = _product["description"].toString();
      cost.updateValue(costValue);
      value.updateValue(valueSale);
      qts.text = _product["qts"].toString();
      size.text = _product["size"].toString();

  }

  void controlsReturnTypeImage(XFile? file) {
    if (file!.path.isNotEmpty) {
      fileImage.value = file.path;
    }
  }

  Future<dynamic> submitTypeAction() async {

    var _image = fileImage.value;

    if(fileImage.isNotEmpty && File(fileImage.toString()).isAbsolute){
      _image = await upload.upload(fileImage.value);
    }

    product.code = cod.text;
    product.product = productName.text;
    product.description = description.text;
    product.costValue = cost.text.contains(".")
        ? double.parse(cost.text.replaceAll(".", "").replaceAll(",", "."))
        : double.parse(cost.text.replaceAll(",", "."));
    product.saleValue = value.text.contains(".")
        ? double.parse(value.text.replaceAll(".", "").replaceAll(",", "."))
        : double.parse(value.text.replaceAll(",", "."));
    product.size = size.text;
    product.qts = int.parse(qts.text);
    product.category = Category(id: int.parse(stringCategory.toString()));
    product.image = [
    ImageController(image: _image)
    ];
    if(typeAction.value == "create") return await product.store(product);
    if(typeAction.value == "update") return await product.update(product,id);

  }




}
