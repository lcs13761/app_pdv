import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lustore/app/theme/loading_style.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'register_product_create_and_update_controller.dart';

class RegisterProductCreateAndUpdateView
    extends GetView<RegisterProductCreateAndUpdateController> {
  final _formKey = GlobalKey<FormState>();

  RegisterProductCreateAndUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
          appBar: AppBar(
            backgroundColor: backgroundColorLogo,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      loading(context);
                      var _response = await controller.submitTypeAction();
                      await 1.delay();
                      Get.back();
                      if (_response == true) {
                        success("sucesso", context, action: "back");
                      } else {
                        controller.errors.clear();
                        controller.errors.addAll(_response);
                      }
                    }
                  },
                  child: const Icon(Icons.check),
                ),
              )
            ],
            title: Obx(
              () => controller.typeAction.toString() == "create"
                  ? const Text('Novo produto', style: styleColorDark)
                  : const Text('Editar produto', style: styleColorDark),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Obx(() {
            if (controller.onLoadingFinalized.isFalse) {
              return const Center(
                child: CircularProgressIndicator(
                  color: styleColorBlue,
                ),
              );
            }
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: selectImage(context),
                      decoration:
                          const BoxDecoration(color: backgroundColorDark),
                      width: 1000,
                      height: 200,
                    ),
                    categorySelect(),
                    textField(
                        "C??digo", TextInputType.number, controller.cod, 'code'),
                    textField("Produto", TextInputType.text,
                        controller.productName, 'product'),
                    textField("Descri????o", TextInputType.text,
                        controller.description, 'description'),
                    textField("Valor de custo", TextInputType.number,
                        controller.cost, 'costValue',
                        prefix: const Text("R\$ ",
                            style: TextStyle(color: whiteConstColor))),
                    textField("Valor de venda", TextInputType.number,
                        controller.value, 'saleValue',
                        prefix: const Text("R\$ ",
                            style: TextStyle(color: whiteConstColor))),
                    textField("Quantidade em estoque", TextInputType.number,
                        controller.qts, 'qts', format: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ]),
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: textField("Tamanho", TextInputType.number,
                          controller.size, 'size'),
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }

  Widget selectImage(context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onLongPress: () {
            dialogRemoveImage(context, 0);
          },
          onTap: () async {
            dialogSelectImage();
          },
          child: Container(
            margin: const EdgeInsets.only(top: 25),
            decoration:
                const BoxDecoration(color: Color.fromRGBO(31, 31, 31, 1.0)),
            height: 150,
            width: 150,
            child: Obx(() {
              if (controller.fileImage.isNotEmpty &&
                  controller.fileImage[0]['image'] != null) {
                if (File(controller.fileImage[0]['image'].toString())
                    .isAbsolute) {
                  return Image.file(
                      File(controller.fileImage[0]['image'].toString()));
                } else {
                  return Image.network(
                      controller.fileImage[0]['image'].toString());
                }
              } else {
                return const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Imagem",
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
                  ),
                );
              }
            }),
          ),
        ),
      ],
    );
  }

  void dialogRemoveImage(context, index) {
    Get.dialog(AlertDialog(
      content: ListTile(
        onTap: () {
          Get.back();
          controller.fileImage[index]['image'] = null;
          var _imageRemove = controller.fileImage[index];
          controller.fileImage.removeAt(index);
          controller.fileImage.add(_imageRemove);
        },
        title: const Text("Remove Imagem."),
      ),
    ));
  }

  void dialogSelectImage() {
    Get.dialog(AlertDialog(
        content: SizedBox(
      height: 100,
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () async {
                Get.back();
                var _file = await controller.image.pickImage(
                  source: ImageSource.gallery,
                );
                controller.controlsReturnTypeImage(_file);
              },
              child: const ListTile(
                title: Icon(Icons.image, size: 50),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text("Galeria", textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                Get.back();
                var _file = await controller.image
                    .pickImage(source: ImageSource.camera);
                controller.controlsReturnTypeImage(_file);
              },
              child: const ListTile(
                title: Icon(Icons.add_a_photo_outlined, size: 50),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text("C??mera", textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
        ],
      ),
    )));
  }

  Widget categorySelect() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: ListTile(
          title: const Text(
            "Categoria",
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Obx(() => DropdownButton(
                  dropdownColor: backgroundColorDark,
                  value: controller.stringCategory.toString(),
                  onChanged: (value) {
                    controller.stringCategory.value = value.toString();
                  },
                  items: controller.categoryList.map((element) {
                    return DropdownMenuItem(
                      value: element["id"].toString(),
                      child: Text(
                        element["category"].toString().toUpperCase(),
                        style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            fontSize: 16),
                      ),
                    );
                  }).toList(),
                )),
          ),
        ));
  }

  Widget textField(String text, type, controllerName, key, {format, prefix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Preencha esse campo";
              }
              return null;
            },
            keyboardType: type,
            controller: controllerName,
            inputFormatters: format,
            style: const TextStyle(color: whiteConstColor),
            decoration: InputDecoration(
              prefix: prefix,
              label: Text(
                text,
                style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.6), fontSize: 16),
              ),
              border: InputBorder.none,
              enabledBorder: enableBorderInline,
              errorBorder: errorBorderInline,
              focusedErrorBorder: focusBorderInline,
              focusedBorder: focusBorderInline,
            ),
          ),
        ),
        Obx(() {
          if (controller.errors.containsKey('errors') &&
              controller.errors['errors'].toString().contains(key)) {
            return Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5, left: 15),
              child: Text(
                controller.errors['errors'][key][0].toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Text('');
        }),
      ],
    );
  }
}
