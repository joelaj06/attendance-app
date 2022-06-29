import 'package:attendance_system/feature/authentication/data/data_source/auth_controller.dart';
import 'package:get/get.dart';

class AuthBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
  }

}