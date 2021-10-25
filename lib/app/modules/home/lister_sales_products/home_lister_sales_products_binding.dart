import 'package:get/get.dart';

import 'home_lister_sales_products_controller.dart';

class HomeListerSalesProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeListerSalesProductsController>(
      () => HomeListerSalesProductsController(),
    );
  }
}
