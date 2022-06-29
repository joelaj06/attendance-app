import 'package:attendance_system/feature/attendant_management/data/model/user_action.dart';
import 'package:attendance_system/feature/authentication/data/model/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseRepository{


  Future<UserModel?> getUserDetail();
  Future updateUserDetails(
      String? firstName,
      String? lastName,
      String? gender,
      String? phoneNumber,
      String? imgUrl,
      String? userId,
      );

  Future createCheckInOrCheckOutField(String location, String checkIn, String checkOut);

  Future getRecords();

  Stream<List<UserAction>> getCheckInOrCheckOutHistory(String uid);

  void startLocationService();
}