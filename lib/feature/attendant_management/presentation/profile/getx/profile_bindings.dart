import 'package:attendance_system/feature/attendant_management/presentation/profile/getx/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController());
  }

}