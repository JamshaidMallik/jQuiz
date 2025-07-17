import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color primaryColor = const Color(0xff000000);

extension DismisskeyBoard on BuildContext {
  void dismissKeyBoard(){
    FocusScope.of(this).unfocus();
  }
}

extension CustomSizeBox on int {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

Size get kSize => MediaQuery.of(Get.context!).size;

double primaryFontSize = 12.0;
double secondaryFontSize = 14.0;
double headingFontSize = 16.0;
double kAppPadding = 20.0;

