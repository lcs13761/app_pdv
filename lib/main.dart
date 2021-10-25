import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() {

  Intl.defaultLocale = 'pt_BR';
  runApp(
    GetMaterialApp(
      title: "Application",
      theme: ThemeData(
          fontFamily:  GoogleFonts.aleo().fontFamily,
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: borderColorFocus,
            enabledBorder:borderColor,
            errorBorder: errorBorder,
            focusedErrorBorder: borderColorFocus,
          )
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

const errorBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromRGBO(254, 0, 0, 0.6),
    ));

const borderColorFocus = OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromRGBO(0, 103, 254, 1),
    ));

const borderColor =  OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.6)));