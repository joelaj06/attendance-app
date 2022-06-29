import 'package:attendance_system/feature/attendant_management/presentation/history/getx/history_controller.dart';
import 'package:get/get.dart';

class HistoryBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(HistoryController());
  }

}