import 'package:get/get.dart';

import 'login_forget_controller.dart';

class LoginForgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginForgetController>(
      () => LoginForgetController(),
    );
  }
}
