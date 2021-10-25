import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'home_lister_sales_products_controller.dart';

class HomeListerSalesProductsView
    extends GetView<HomeListerSalesProductsController> {
  const HomeListerSalesProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeListerSalesProductsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeListerSalesProductsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
