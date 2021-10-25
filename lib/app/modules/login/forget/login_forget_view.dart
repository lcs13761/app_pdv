import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'login_forget_controller.dart';

class LoginForgetView extends GetView<LoginForgetController> {
  const LoginForgetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginForgetView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LoginForgetView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
