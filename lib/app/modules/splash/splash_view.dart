import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 150),
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/images/logo.png",
              width: 300,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 140),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,

                color: Color.fromRGBO(0, 103, 254, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
