import 'package:flutter/material.dart';
import 'package:lustore/app/theme/loading_style.dart';
import 'package:get/get.dart';
import 'register_category_controller.dart';

class RegisterCategoryView extends GetView<RegisterCategoryController> {
  const RegisterCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorDark,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: backgroundColorLogo,
        title: const Text(
          'Cadastro de categorias',
          style: styleColorDark,
        ),
      ),
      floatingActionButton: floatingButton(context),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: categories(),
      ),
    );
  }

  Widget categories() {
    return Obx(() {
      if (controller.inLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(
            color: styleColorBlue,
          ),
        );
      }
      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: whiteConstColor,
          height: 1,
        ),
        itemCount: controller.categories.length,
        itemBuilder: (BuildContext context, int index) {
          var _category = controller.categories[index];
          return ListTile(
            onLongPress: () {
              dialogActionCategory(context, _category, index);
            },
            onTap: () {
              controller.type = "update";
              controller.nameCategory.text = _category["category"];
              dialogAction(context, id: _category["id"]);
            },
            title: category(_category),
          );
        },
      );
    });
  }

  Widget category(_category) {
    return Row(
      children: <Widget>[
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: const Color.fromRGBO(31, 31, 31, 1.0),
          ),
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: const Center(
            child: Text("sa", style: colorAndSizeRegisterProduct),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              _category["category"],
              style: colorAndSizeRegisterProduct,
            ),
          ),
        ),
      ],
    );
  }

  void dialogActionCategory(context, _category, index) {
    Get.dialog(AlertDialog(
        content: SizedBox(
      height: 130,
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              Get.back();
              controller.type = "update";
              controller.nameCategory.text = _category["category"];
              dialogAction(context, id: _category["id"]);
            },
            title: const Text("Editar Categoria"),
          ),
          const Divider(
            color: backgroundColorDark,
          ),
          ListTile(
            onTap: () {
              Get.back();
              deleteCategory(context, _category, index);
            },
            title: const Text("Excluir Categoria."),
          ),
        ],
      ),
    )));
  }

  void deleteCategory(context, _category, index) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Deseja realmente excluir o produto ?"),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "NÃO",
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50)),
                  onPressed: () async {
                    loading(context);
                    controller.type = "delete";
                    await 1.delay();
                    var _response = await controller.createdOrUpdateOrDelete(
                        id: _category["id"]);
                    if (_response != true) {
                      Get.back();
                      Get.back();
                      //error(context, _response["error"].toString());
                    } else {
                      Get.back();
                      Get.back();
                      controller.categories.removeAt(index);
                    }
                  },
                  child: const Text("SIM"))
            ],
          );
        });
  }

  Widget floatingButton(context) {
    return FloatingActionButton(
      onPressed: () {
        controller.type = "create";
        dialogAction(context);
      },
      child: const Icon(Icons.add, color: whiteConstColor),
      backgroundColor: styleColorBlue,
    );
  }

  void dialogAction(context, {id}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 50)),
                    onPressed: () async {
                      loading(context);
                      await 1.delay();
                      var _response =
                          await controller.createdOrUpdateOrDelete(id: id);
                      if (_response != true) {
                          controller.errors.clear();
                          controller.errors.addAll(_response);
                      } else {
                        if (_response == true) {
                          controller.nameCategory.text = "";
                          controller.inLoading.value = true;
                          controller.categories.clear();
                          await controller.getAllCategories();
                          Get.back();
                          Get.back();
                        }
                      }
                    },
                    child: const Text(
                      "Salva",
                      style: TextStyle(fontSize: 18),
                    ))
              ],
              content: ListTile(
                title: TextField(
                  controller: controller.nameCategory,
                  decoration: const InputDecoration(
                    label: Text(
                      "Categoria",
                      style: TextStyle(color: backgroundColorDark, fontSize: 16),
                    ),
                    border: InputBorder.none,
                    enabledBorder: enableBorderInline,
                    errorBorder: errorBorderInline,
                    focusedErrorBorder: focusBorderInline,
                    focusedBorder: focusBorderInline,
                  ),
                ),
                subtitle: Obx(() {
                  if(controller.errors.containsKey('category')){
                        return Text(controller.errors['category'][0].toString());
                  }
                  return const Text('');
                }),
              )
          );
        });
  }
}
