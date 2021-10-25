import 'package:get/get.dart';

import 'register_product_create_and_update_controller.dart';

class RegisterProductCreateAndUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RegisterProductCreateAndUpdateController>(
      RegisterProductCreateAndUpdateController(),
    );
  }
}
