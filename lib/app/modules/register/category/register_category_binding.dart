import 'package:get/get.dart';

import 'register_category_controller.dart';

class RegisterCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RegisterCategoryController>(
     RegisterCategoryController(),
    );
  }
}
