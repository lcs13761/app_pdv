import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lustore/app/routes/app_pages.dart';
import 'package:lustore/app/theme/loading_style.dart';
import 'config_list_admin_controller.dart';

class ConfigListAdminView extends GetView<ConfigListAdminController> {
  const ConfigListAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorDark,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: backgroundColorLogo,
        title: const Text(
          'Administradores',
          style: styleColorDark,
        ),
      ),
      floatingActionButton: floatingButton(),
      body: adminList(),
    );
  }

  Widget adminList() {
    return Obx(() {
      if (controller.inLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(
            color: styleColorBlue,
          ),
        );
      }
      return ListView.separated(
        itemCount:  controller.users.length,
          separatorBuilder: (context, index) => const Divider(
            color: whiteConstColor,
            height: 1,
          ),
        itemBuilder: (BuildContext context, int index) {
          var _admin = controller.users[index];
          return ListTile(
            onTap: () {
              // Get.toNamed(Routes.REGISTER_PRODUCT_CREATE_AND_UPDATE,
              //     arguments: _product)
              //     ?.whenComplete(() => unawaited(controller.refreshProduct()));
            },
            title: admin(_admin),
          );
        },
      );
    });
  }

  Widget admin(_admin) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                _admin["name"].toString(),
                style: colorAndSizeRegisterProduct,
              ),
            ),
            subtitle: Text(
              _admin["email"],
              style: colorAndSizeRegisterProduct,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget floatingButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(Routes.CONFIG_LIST_ADMIN_CREATE)
         ?.whenComplete(() => unawaited(controller.adminList()));
      },
      child: const Icon(Icons.add, color: whiteConstColor),
      backgroundColor: styleColorBlue,
    );
  }
}
