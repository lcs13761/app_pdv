import 'package:get/get.dart';

import 'config_user_controller.dart';

class ConfigUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfigUserController>(
      () => ConfigUserController(),
    );
  }
}
