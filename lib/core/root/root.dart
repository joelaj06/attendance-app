import 'package:flutter/material.dart';
import 'package:attendance_system/feature/attendant_management/presentation/base/screens/base_screen.dart';
import 'package:attendance_system/feature/authentication/data/data_source/auth_controller.dart';
import 'package:attendance_system/feature/authentication/presentation/login/screens/login_screen.dart';
import 'package:get/get.dart';


class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.find<AuthController>().user != null
          ?  BaseScreen()
       //     ? UserDetailScreen()
          : LoginScreen();
    });
  }
}



