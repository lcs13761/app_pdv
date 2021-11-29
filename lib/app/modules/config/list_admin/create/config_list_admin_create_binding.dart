import 'package:get/get.dart';

import 'config_list_admin_create_controller.dart';

class ConfigListAdminCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfigListAdminCreateController>(
      () => ConfigListAdminCreateController(),
    );
  }
}
