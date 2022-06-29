import 'package:attendance_system/core/presentation/utils/date_formatter.dart';
import 'package:attendance_system/feature/attendant_management/data/data_source/database_service/database_repository_impl.dart';
import 'package:attendance_system/feature/attendant_management/data/model/user_action.dart';
import 'package:attendance_system/feature/authentication/data/data_source/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  Rxn<List<UserAction>> userActionList = Rxn<List<UserAction>>();

  List<UserAction>? get userAction => userActionList.value;

  String? uid;

  RxString month = DateFormatter().dateFormatterMonth(DateTime.now()).obs;
  RxString year = DateFormatter().dateFormatterYear(DateTime.now()).obs;
  RxBool isCurrentDate = true.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Timestamp timestamp = Timestamp.now();

  // database repository
  final DatabaseRepositoryImpl _databaseRepositoryImpl =
      DatabaseRepositoryImpl(uid: '');

  // auth controller
  final AuthController _authController = AuthController();

  @override
  void onInit() async {
    super.onInit();
    uid = await _authController.getCurrentUserUid();
    // userActionList.bindStream(getCheckInCheckOutHistory());
  }

  Stream<List<UserAction>> getCheckInCheckOutHistory() {
    debugPrint('uid from oninit: $uid');
    return _databaseRepositoryImpl.getCheckInOrCheckOutHistory(uid!);
  }

  void onMonthSelected(String value){
    month(value);
    debugPrint(month.value);
  }

  void onYearSelected(String value){
    year(value);
  }


  void onMonthYearSelected(DateTime value){
    selectedDate(value);
  }


  void checkCurrentDate() {
    if(month.value == DateFormatter().dateFormatterMonth(timestamp.toDate()) &&
    year.value == DateFormatter().dateFormatterYear(timestamp.toDate())){
      isCurrentDate(true);
      debugPrint('true');
    }else{
      isCurrentDate(false);
      debugPrint('false..');
    }

  }


}
