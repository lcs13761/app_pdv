import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'config_list_admin_create_controller.dart';

class ConfigListAdminCreateView
    extends GetView<ConfigListAdminCreateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConfigListAdminCreateView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ConfigListAdminCreateView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
