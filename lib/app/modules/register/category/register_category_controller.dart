import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lustore/app/model/category.dart';

class RegisterCategoryController extends GetxController {

   RxBool inLoading = true.obs;
   RxList categories = [].obs;
   RxMap errors = {}.obs;
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
     var _categories = await category.index();
     categories.addAll(_categories["data"]);
     inLoading.value = false;
   }



   createdOrUpdateOrDelete({id}) async{

     category.id = id;
     category.category = nameCategory.text;

     if(type == "create") return await category.store(category);
     if(type == "update") return await category.update(category,id);
     if(type == "delete") return await category.destroy(id);

   }
 }
