import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lustore/app/model/category.dart';

class RegisterCategoryController extends GetxController {

   RxBool inLoading = true.obs;
   RxList categories = [].obs;
   TextEditingController nameCategory = TextEditingController();
   String type = "create";
   NumberFormat formatter = NumberFormat.simpleCurrency();
   Category category = Category();

   @override
  void onInit() async{
    super.onInit();
    await getAllCategories();
  }

   getAllCategories() async {
     var _categories = await category.getAllCategories();
     categories.addAll(_categories["result"]);
     inLoading.value = false;
   }



   createdOrUpdateOrDelete({id}) async{

     category.id = id;
     category.category = nameCategory.text;

     if(type == "create") return await category.create(category);
     if(type == "update") return await category.update(category);
     if(type == "delete") return await category.delete(id);

   }
 }
