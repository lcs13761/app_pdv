import 'package:get/get.dart';

import 'config_list_admin_controller.dart';

class ConfigListAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ConfigListAdminController>(
        ConfigListAdminController(),
    );
  }
}
