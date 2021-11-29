import 'package:flutter/material.dart';
import 'package:lustore/app/theme/loading_style.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'config_user_controller.dart';

class ConfigUserView extends GetView<ConfigUserController> {
  final _formKey = GlobalKey<FormState>();

  ConfigUserView({Key? key}) : super(key: key);

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
                      var _response = await controller.updateUser();
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
            title: const Text('Editar usuario', style: styleColorDark),
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
                    // Container(
                    //   child: selectImage(context),
                    //   decoration:
                    //       const BoxDecoration(color: backgroundColorDark),
                    //   width: 1000,
                    //   height: 200,
                    // ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: textField(
                          "Nome", TextInputType.text, controller.name, 'name',
                          required: true),
                    ),
                    textField(
                        "E-mail", TextInputType.text, controller.email, 'email',
                        required: true),
                    textField(
                        "CPF", TextInputType.number, controller.cpf, 'cpf',
                        required: true),
                    textField("Telefone Celular", TextInputType.number,
                        controller.phone, 'phone'),
                    textField(
                        "CEP", TextInputType.number, controller.cep, 'cep'),
                    textField(
                        "Estado", TextInputType.text, controller.state, 'state',
                        required:
                            controller.cep.text.isNotEmpty ? true : false),
                    textField(
                        "Cidade", TextInputType.text, controller.city, 'city',
                        required:
                            controller.cep.text.isNotEmpty ? true : false),
                    textField("Bairro", TextInputType.text, controller.district,
                        'district',
                        required:
                            controller.cep.text.isNotEmpty ? true : false),
                    textField(
                        "Rua", TextInputType.text, controller.street, 'street',
                        required:
                            controller.cep.text.isNotEmpty ? true : false),
                    textField("Número", TextInputType.number, controller.number,
                        'number',
                        required:
                            controller.cep.text.isNotEmpty ? true : false),
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: textField("Complemento", TextInputType.text,
                          controller.complement, 'complement'),
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }

  Widget textField(String text, type, controllerName, key,
      {format, prefix, required}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 0, bottom: 5, left: 15, right: 15),
          child: TextFormField(
            onChanged: (value) {
              if (key == 'cep') controller.apiCompleteAddress(value);
            },
            validator: (value) {
              if (required == true) {
                if (value == null || value.isEmpty) {
                  return "Preencha esse campo";
                }
                return null;
              }
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
// Widget selectImage(context) {
//   return Column(
//     children: <Widget>[
//       GestureDetector(
//         onLongPress: () {
//           dialogRemoveImage(context, 0);
//         },
//         onTap: () async {
//           dialogSelectImage();
//         },
//         child: Container(
//           margin: const EdgeInsets.only(top: 25),
//           decoration:
//               const BoxDecoration(color: Color.fromRGBO(31, 31, 31, 1.0)),
//           height: 150,
//           width: 150,
//           child: Obx(() {
//             if (controller.fileImage.isNotEmpty) {
//               if (File(controller.fileImage.toString()).isAbsolute) {
//                 return Image.file(File(controller.fileImage.toString()));
//               } else {
//                 return Image.network(controller.fileImage.toString());
//               }
//             } else {
//               return const Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Imagem",
//                   style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
//                 ),
//               );
//             }
//           }),
//         ),
//       ),
//     ],
//   );
// }

// void dialogRemoveImage(context, index) {
//   Get.dialog(AlertDialog(
//     content: ListTile(
//       onTap: () {
//         // Get.back();
//         // controller.fileImage[index]['image'] = null;
//         // var _imageRemove = controller.fileImage[index];
//         // controller.fileImage.removeAt(index);
//         // controller.fileImage.add(_imageRemove);
//       },
//       title: const Text("Remove Imagem."),
//     ),
//   ));
// }

// void dialogSelectImage() {
//   Get.dialog(AlertDialog(
//       content: SizedBox(
//     height: 100,
//     child: Row(
//       children: <Widget>[
//         Expanded(
//           child: GestureDetector(
//             onTap: () async {
//               // Get.back();
//               // var _file = await controller.image.pickImage(
//               //   source: ImageSource.gallery,
//               // );
//               // controller.controlsReturnTypeImage(_file);
//             },
//             child: const ListTile(
//               title: Icon(Icons.image, size: 50),
//               subtitle: Padding(
//                 padding: EdgeInsets.only(top: 10),
//                 child: Text("Galeria", textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: GestureDetector(
//             onTap: () async {
//               Get.back();
//               // var _file = await controller.image
//               //     .pickImage(source: ImageSource.camera);
//               // controller.controlsReturnTypeImage(_file);
//             },
//             child: const ListTile(
//               title: Icon(Icons.add_a_photo_outlined, size: 50),
//               subtitle: Padding(
//                 padding: EdgeInsets.only(top: 10),
//                 child: Text("Câmera", textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   )));
// }

}
