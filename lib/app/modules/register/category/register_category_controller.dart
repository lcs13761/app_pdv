import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:LuStore/app/model/category.dart';

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
      inLoading.value = false;
  }

   getAllCategories() async {
     var _categories = await category.getAllCategories();
     categories.addAll(_categories["result"]);
   }



   createdOrUpdateOrDelete({id}) async{


     category.id = id;
     category.category = nameCategory.text;
     var _response;
     if(type == "create"){

       _response = await category.create(category);

     }
     if(type == "update"){
      _response = await category.update(category);
     }

     if(type == "delete"){
       _response = await category.delete(id);
     }

     return _response;

   }


 }
